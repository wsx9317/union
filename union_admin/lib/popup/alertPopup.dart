import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/id_widget/IdColor.dart';
import 'package:union_admin/id_widget/IdImageBox1.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';
import 'package:union_admin/id_widget/IdSpace.dart';

class AlertPopup extends StatefulWidget {
  final String popupTitle;
  final String content;
  final Function() onlyCloseFunction;
  final Function() activeFunction;
  final double? width;
  const AlertPopup(
      {super.key,
      required this.popupTitle,
      required this.content,
      required this.onlyCloseFunction,
      required this.activeFunction,
      this.width});

  @override
  State<AlertPopup> createState() => _AlertPopupState();
}

class _AlertPopupState extends State<AlertPopup> {
  Widget bottomBtn(String btnTitle, Color btnColor, Function() onBtnPressed) {
    return IdNormalBtn(
      onBtnPressed: onBtnPressed,
      childWidget: Container(
        width: 80,
        height: 44,
        decoration: BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: uiCommon.styledText(btnTitle, 16, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: (widget.width != null) ? widget.width : 400,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: IdColors.white,
        boxShadow: [
          BoxShadow(
            color: Color(0x14000000),
            blurRadius: 16,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 77,
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(child: uiCommon.styledText(widget.popupTitle, 18, 0, 1, FontWeight.w600, IdColors.black, TextAlign.left)),
                IdNormalBtn(
                  onBtnPressed: widget.onlyCloseFunction,
                  childWidget:
                      const IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 24, vertical: 23),
            decoration: BoxDecoration(
                border: Border(
              top: BorderSide(width: 1, color: IdColors.borderDefault),
              bottom: BorderSide(width: 1, color: IdColors.borderDefault),
            )),
            child: uiCommon.styledText(widget.content, 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
          ),
          Container(
            width: double.infinity,
            height: 92,
            padding: EdgeInsets.all(24),
            child: Row(
              children: [
                Expanded(child: SizedBox()),
                Row(
                  children: [
                    bottomBtn('취소', IdColors.textTertiary, widget.onlyCloseFunction),
                    IdSpace(spaceWidth: 8, spaceHeight: 0),
                    bottomBtn('확인', IdColors.green, widget.activeFunction),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
    return wg1;
  }
}
