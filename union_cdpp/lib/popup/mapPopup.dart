import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:http/http.dart' as http;

class MapPopup extends StatefulWidget {
  final Function() onlyCloseFunction;
  final String latitude;
  final String longitude;

  const MapPopup({super.key, required this.onlyCloseFunction, required this.latitude, required this.longitude});

  @override
  State<MapPopup> createState() => _MapPopupState();
}

class _MapPopupState extends State<MapPopup> {
  Future<Uint8List> loadImageV1() async {
    //TODO  CORS 이슈때문에 cors무시하는 proxy를 거쳐서 가져오도록 되어 있음. 나중에 proxy프로그램을 서버에 설치하거나  api서버에서 가져오는 api를 작성할 필요가 있음.
    String mapUrl =
        'https://flexwill.duckdns.org:7080/https://naveropenapi.apigw.ntruss.com/map-static/v2/raster?w=400&h=420&center=${widget.longitude},${widget.latitude}&level=17&scale=2&scaleControl=true';
    Map<String, String> mapHeader = const {
      "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
      "Access-Control-Allow-Origin": "*",
      'Accept': '*/*',
      'X-NCP-APIGW-API-KEY-ID': 'oblzrjl4h1',
      'X-NCP-APIGW-API-KEY': 'HR33Y1j0olrYptMEZhNJhmGrAbLuBsecVgxRBLJj'
      //TODO 유니언쪽 계정에 key 및 암호를 설정해야됨.  이래는 참조
      //https://api.ncloud-docs.com/docs/ai-naver-mapsstaticmap-raster
      //https://blog.naver.com/6sub/221893778682
    };

    try {
      final res = await http.get(Uri.parse(mapUrl), headers: mapHeader);
      return res.bodyBytes;
    } catch (e) {
      print(e);
    }
    return Uint8List(0);
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 600,
      height: 800,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: IdColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: IdColors.borderDefault,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: IdColors.black8Per,
            blurRadius: 16,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 29,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: uiCommon.styledText('지도', 18, 0, 1.6, FontWeight.w700, IdColors.black, TextAlign.left),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IdNormalBtn(
                  onBtnPressed: widget.onlyCloseFunction,
                  childWidget: IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                ),
              )
            ],
          ),
          IdSpace(spaceWidth: 0, spaceHeight: 24),
          FutureBuilder<Uint8List>(
            future: loadImageV1(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text('Error: ${snapshot.error}');
              } else {
                return Image.memory(snapshot.data!);
              }
            },
          ),
        ],
      ),
    );
    return wg1;
  }
}
