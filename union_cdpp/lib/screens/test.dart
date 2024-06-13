import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/modelVO/dealLandItem.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  DealLandItem? landItem;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    landItem = DealLandItem();
    fetchData();
  }

  Future<void> fetchData() async {
    final dynamic ret1 = await IdApi.loadImage(
        'http://flexwill.duckdns.org:7080/https://unionccdp.s3.ap-northeast-2.amazonaws.com/DEAL/20240225/11139742444143770.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240225T023250Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=AKIA32IXZOKHRST6UVXA%2F20240225%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=eff91c82a6777aff4069065ef3d1d4e6de6ff92e56eebfbdc691a9a779bdab96');

    print('=========ret1============');
    print(ret1);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          IdNormalBtn(
            onBtnPressed: () {
              landItem!.lineName = 'hi';
              landItem!.stationName = 'hi';
              landItem!.distance = 'hi';
              GV.pStrg.putXXX('landItemJson', jsonEncode(landItem!.toJson()));
              setState(() {});
              print(GV.pStrg.getXXX('landItemJson'));
            },
            childWidget: Container(
              width: 100,
              height: 100,
              color: Colors.red,
            ),
          ),
          Image(
            image: NetworkImage(
                "http://flexwill.duckdns.org:7080/https://unionccdp.s3.ap-northeast-2.amazonaws.com/DEAL/20240225/11139742444143770.png?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Date=20240225T023250Z&X-Amz-SignedHeaders=host&X-Amz-Expires=3599&X-Amz-Credential=AKIA32IXZOKHRST6UVXA%2F20240225%2Fap-northeast-2%2Fs3%2Faws4_request&X-Amz-Signature=eff91c82a6777aff4069065ef3d1d4e6de6ff92e56eebfbdc691a9a779bdab96",
                scale: 1),
            frameBuilder: null,
            loadingBuilder: null,
            width: 520.0,
            height: 259.4,
            alignment: Alignment.center,
          )
        ],
      ),
    );
  }
}
