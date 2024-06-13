import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class MyAlarmPopup_02 extends StatefulWidget {
  final Function() closeFunction;
  final String title;
  final String content;
  final Function() dealCheckLink;
  const MyAlarmPopup_02({super.key, required this.closeFunction, required this.title, required this.content, required this.dealCheckLink});

  @override
  State<MyAlarmPopup_02> createState() => _MyAlarmPopup_02State();
}

class _MyAlarmPopup_02State extends State<MyAlarmPopup_02> {
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
            height: 337,
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
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.only(top: 24),
                  child: Column(
                    children: [
                      SizedBox(
                        child: Column(
                          children: [
                            uiCommon.styledText((widget.content.contains(']')) ? widget.content.split(']')[0] + ']' : '', 16, 0, 1.6,
                                FontWeight.w700, IdColors.green2, TextAlign.center),
                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                            uiCommon.styledText((widget.content.contains(']')) ? widget.content.split(']')[1] : '', 16, 0, 1.6,
                                FontWeight.w400, IdColors.textDefault, TextAlign.center),
                          ],
                        ),
                      ),
                      const IdSpace(spaceWidth: 0, spaceHeight: 32),
                      IdNormalBtn(
                        onBtnPressed: widget.dealCheckLink,
                        childWidget: Container(
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: IdColors.white,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(width: 1, color: IdColors.textDefault),
                          ),
                          child: Center(
                            child: uiCommon.styledText('딜 확인', 15, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.center),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const IdSpace(spaceWidth: 0, spaceHeight: 32),
                Row(
                  children: [
                    //취소 버튼
                    Expanded(
                      child: IdNormalBtn(
                        onBtnPressed: widget.closeFunction,
                        childWidget: Container(
                          width: double.infinity,
                          height: 44,
                          decoration: BoxDecoration(
                            color: IdColors.borderDefault,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Center(
                            child: uiCommon.styledText('닫기', 15, 0, 1, FontWeight.w600, IdColors.textTertiary, TextAlign.center),
                          ),
                        ),
                      ),
                    ),
                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                    //확인 버튼
                    Expanded(
                      child: IdNormalBtn(
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
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
    return wg1;
  }
}
