import 'dart:html' as html;
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

import '../common/globalvar.dart';

class HtmlPopup extends StatefulWidget {
  // 메인 웹뷰에서 보낸 createWindowAction 값 저장 변수
  final CreateWindowAction createWindowAction;

  // 생성자 초기화
  const HtmlPopup({Key? key, required this.createWindowAction}) : super(key: key);

  @override
  State<HtmlPopup> createState() => _HtmlPopupPopupState();
}

class _HtmlPopupPopupState extends State<HtmlPopup> {
  /// flutter -> html 샘플코드
  ///            html.window.postMessage('hello', '*');
  /// hmlt -> flutter  는 아래코드
  var htmlListener = html.window.onMessage.listen((html.MessageEvent event) {
    try {
      var data = event.data;
      GV.d('HtmlPopup', '${data.runtimeType}: $data');
    } catch (e) {
      debugPrint(e.toString());
    }
  });

  @override
  void dispose() {
    GV.d('dispose htmlpopup');
    htmlListener.cancel();
    // html.window.removeEventListener(htmlListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Column(
          children: [
            IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(
                  Icons.close,
                  size: 40,
                  color: Colors.red,
                )),
            // 팝업 표시를 위한 웹뷰 설정
            InAppWebView(
              // 메인 웹뷰에서 받은 windowId
              // windowId: widget.createWindowAction.windowId,
              // 팝업 닫기 기능 구현
              onCloseWindow: (controller) {
                Navigator.pop(context);
              },
              onLoadStop: (controller, url) {
                GV.d('HtmlPopup',url);
                htmlListener = html.window.onMessage.listen((html.MessageEvent event) {
                  try {
                    var data = event.data;
                    GV.d('HtmlPopup', '${data.runtimeType}: $data');
                  } catch (e) {
                    debugPrint(e.toString());
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
