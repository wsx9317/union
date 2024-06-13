// ignore_for_file: must_be_immutable, non_constant_identifier_names

import 'dart:async';
import 'dart:convert';
import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:uuid/uuid.dart';
import 'package:web_socket_client/web_socket_client.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import '../common/utils.dart';
import '../id_widget/Basic/IdState.dart';
import '../id_widget/IdCommonHeader.dart';
import '../modelVO/myInfoItem.dart';
import '../popup/htmlPopup.dart';

class HtmlWebPage extends StatefulWidget {
  String? param;
  HtmlWebPage({super.key, this.param});

  @override
  IdState<HtmlWebPage> createState() => _HtmlWebPageState();
}

class _HtmlWebPageState extends IdState<HtmlWebPage> {
  MyInfoItem user1 = GV.myInfoItem;
  var uuidStr = '';
  bool visibleProgress = false;
  WebSocket? socket;
  StreamSubscription<html.MessageEvent>? htmlListener;
  // WebViewXController? xcontroller;

  @override
  void initState() {
    super.initState();
    GV.pStrg.putXXX(Param_pageType, 'introPage');
    // GV.d('htmlpageparam', widget.param);

    GV.pStrg.putXXX(key_gv_uuid, const Uuid().v4());
    uuidStr = GV.pStrg.getXXX(key_gv_uuid);
    GV.pStrg.putXXX(Param_nowPage, '현재페이지');
    if (widget.param!.startsWith('Intro') == false) {
      // login, findid,signup 이면
      Future.delayed(Duration(milliseconds: 10), () async {
        String uuidStr = GV.pStrg.getXXX(key_gv_uuid);
        GV.d('uuidStr', uuidStr);
        socket = WebSocket(
          Uri.parse(ID_WEB_URI),
          backoff: ConstantBackoff(Duration(seconds: 1)),
          timeout: const Duration(seconds: 5),
        );
        socket?.messages.listen((event) {
          // GV.d(event.toString());
          if (event.toString().isNotEmpty) {
            var jmap = jsonDecode(utf8.decode(utf8.encode(event.toString())));
            GV.pStrg.putXXX(key_gv_login, jsonEncode(jmap));
            MyInfoItem data1 = MyInfoItem.fromJson(jmap);
            GV.myInfoItem = data1;
            IdUtil.setCookie(GV.myInfoItem.accessToken!);
            IdUtil.getCookie();
            uiCommon.IdMovePage(context, PAGE_HOME_PAGE);
          }
        });
        await socket?.connection.firstWhere((state) => state is Connected);
        socket?.send('hi123907812|bid|$uuidStr|org|cdpp');
      });
    } else if (widget.param!.contains('Logged') == true) {
      if (IdApi.getMember(MyInfoItem(userNo: GV.myInfoItem.userNo)) is Future<Null>) {
        IdUtil.logout();
        uiCommon.IdMovePage(context, PAGE_INTRO);
        return;
      }
    }
    htmlListener = html.window.onMessage.listen((event) {
      GV.d(event.data);

      if (widget.param!.contains('Logged') == false) {
        switch (event.data) {
          case "menu1": //회원가입
            uiCommon.IdMovePage(context, PAGE_SIGNUP);
            break;
          case "menu2": //아이디 비번/찾기
            uiCommon.IdMovePage(context, PAGE_FIND_IDPWD);
            break;
        }
      }
    });
  }

  @override
  void dispose() {
    GV.d('dispose htmlMemberScreen');
    htmlListener?.cancel();
    socket?.close();
    super.dispose();
  }

  @override
  Widget idBuild(BuildContext context) {
    if (user1.isNotEmpty() && (["login", "signUp", "findIdPwd"].contains(widget.param))) {
      Future.delayed(Duration(milliseconds: 10), () {
        uiCommon.IdMovePage(context, PAGE_HOME_PAGE);
      });
      return Scaffold(body: SizedBox());
    }

    uuidStr = GV.pStrg.getXXX(key_gv_uuid);
    var introUrl = 'https://uniondata.devsp.kr/index.html';
    switch (widget.param) {
      case 'IntroLogged2':
      case 'Intro2':
        introUrl = 'https://uniondata.devsp.kr/index2.html';
        break;
      case 'IntroLogged3':
      case 'Intro3':
        introUrl = 'https://uniondata.devsp.kr/index3.html';
    }

    var w1 = SizedBox(
      width: GV.screen.width,
      height: GV.screen.height - 74,
      child: WebViewX(
        initialContent: introUrl,
        javascriptMode: JavascriptMode.unrestricted,
        initialSourceType: SourceType.url,
        width: GV.screen.width,
        height: GV.screen.height - 74,
        // onWebViewCreated: (controller) => xcontroller = controller,
      ),
    );

    var svrStr =
        '<script language="javascript"> window.open("$ID_SSO_URI/loginPage?callBackUrl=$ID_BASE_URI/internal/login-callback?bid=$uuidStr&org=cdpp","w1212"); </script>';
    if (widget.param == "signUp") {
      svrStr =
          '<script language="javascript"> window.open("$ID_SSO_URI/join?callBackUrl=$ID_BASE_URI/internal/login-callback?bid=$uuidStr&org=cdpp","w1212"); </script>';
    } else if (widget.param == "findIdPwd") {
      svrStr =
          '<script language="javascript"> window.open("$ID_SSO_URI/find/idPassword?callBackUrl=$ID_BASE_URI//internal/login-callback?bid=$uuidStr&org=cdpp","w1212"); </script>';
    }

    var w2 = InAppWebView(
      // 팝업 허용을 위한 옵션 설정
      initialOptions: InAppWebViewGroupOptions(
        // 모든 플랫폼 공용 옵션
        crossPlatform: InAppWebViewOptions(
            javaScriptEnabled: true, // 자바스크립트 사용 여부
            javaScriptCanOpenWindowsAutomatically: true),
        // 안드로이드 플랫폼 옵션
        android: AndroidInAppWebViewOptions(supportMultipleWindows: true),
      ),
      initialData: InAppWebViewInitialData(data: svrStr),
      onSafeBrowsingHit: (controller, url, threatType) async {
        GV.d('loadstop1', url);
      },
      onCreateWindow: (controller, reqCreateWindowAction) async {
        // 팝업을 띄울 때의 제어 코드 작성
        showDialog(
          context: context,
          builder: (ctx) => HtmlPopup(createWindowAction: reqCreateWindowAction),
        );
        return true;
      },
    );

    return WillPopScope(
        onWillPop: () async {
          uiCommon.IdMovePage(context, '{PREV}');
          return false;
        },
        child: Scaffold(
          body: SizedBox(
            width: GV.screen.width,
            height: GV.screen.height,
            child: Stack(
              children: [
                widget.param!.startsWith('Intro')
                    ? SizedBox()
                    : Positioned(
                        top: 74, left: GV.screen.width, child: Container(width: GV.screen.width, height: GV.screen.height, child: w2)),
                Positioned(top: 74, left: 0, child: w1),
                const Positioned(top: 0, left: 0, right: 0, child: IdCommonHeader()),
              ],
            ),
          ),
        ));
  }
}
