import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class MyAlarmPopup_01 extends StatefulWidget {
  final Function() closeFunction;
  final String title;
  final String content;
  const MyAlarmPopup_01({super.key, required this.closeFunction, required this.title, required this.content});

  @override
  State<MyAlarmPopup_01> createState() => _MyAlarmPopup_01State();
}

class _MyAlarmPopup_01State extends State<MyAlarmPopup_01> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Positioned(
      top: 0,
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        color: Color.fromRGBO(0, 0, 0, 0),
        child: Center(
          child: Container(
            width: 420,
            height: 243,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: IdColors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 16,
                  offset: Offset(0, 0),
                  spreadRadius: 0,
                  color: IdColors.black8Per,
                ),
              ],
            ),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          child: uiCommon.styledText(widget.title, 18, 0, 1.6, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                        ),
                      ),
                      IdNormalBtn(
                        onBtnPressed: widget.closeFunction,
                        childWidget:
                            IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                      )
                    ],
                  ),
                ),
                const IdSpace(spaceWidth: 0, spaceHeight: 24),
                SizedBox(
                  width: double.infinity,
                  height: 74,
                  child: Center(
                    child: uiCommon.styledText(widget.content, 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.center),
                  ),
                ),
                const IdSpace(spaceWidth: 0, spaceHeight: 24),
                IdNormalBtn(
                  onBtnPressed: widget.closeFunction,
                  childWidget: Container(
                    width: double.infinity,
                    height: 44,
                    decoration: BoxDecoration(
                      color: IdColors.green2,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: uiCommon.styledText('확인', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    return wg1;
  }
}
