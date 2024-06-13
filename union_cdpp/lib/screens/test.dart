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
    final dynamic ret1 = await IdApi.loadImage('');

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
            image: NetworkImage("", scale: 1),
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
