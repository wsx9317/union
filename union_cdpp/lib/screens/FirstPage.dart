import 'dart:async';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/IdCommonHeader.dart';
import 'package:unionCDPP/modelVO/myInfoItem.dart';
import 'package:webviewx_plus/webviewx_plus.dart';

import '../api/id_api.dart';

class FirstPage extends StatefulWidget {
  bool test = true;
  FirstPage({super.key, this.test = false});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  MyInfoItem user1 = GV.myInfoItem;

  @override
  void initState() {
    super.initState();
    if (!widget.test)
      Future.delayed(Duration(milliseconds: 10), () {
        var menu1 = user1.isNotEmpty() ? PAGE_LOGGED_INTRO : PAGE_INTRO;
        uiCommon.IdPushPage(context, menu1);
        Navigator.pushReplacementNamed(context, menu1);
      });
  }

  @override
  void dispose() {
    GV.d('dispose intro');
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    uiCommon.setScreen(context);

    return WillPopScope(
        onWillPop: () async {
          // uiCommon.IdMovePage(context, '{PREV}');
          return false;
        },
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [],
            ),
          ),
        ));
  }
}
