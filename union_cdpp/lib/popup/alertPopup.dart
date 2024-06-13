import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class AlertPopup extends StatefulWidget {
  final String? alertTitle;
  final Widget? alertWithImg;
  final String alertBody;
  final Function() onBtnPressedLeft;
  final Function() onBtnPressedRight;
  const AlertPopup(
      {super.key,
      this.alertTitle,
      this.alertWithImg,
      required this.alertBody,
      required this.onBtnPressedLeft,
      required this.onBtnPressedRight});

  @override
  State<AlertPopup> createState() => _AlertPopupState();
}

class _AlertPopupState extends State<AlertPopup> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 420,
      height: 168,
      padding: const EdgeInsets.only(top: 32, bottom: 26),
      decoration: BoxDecoration(
        color: IdColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: IdColors.black8Per,
            blurRadius: 16,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Visibility(
            visible: (widget.alertTitle != null) ? true : false,
            child: Column(
              children: [
                SizedBox(
                  width: 340,
                  child: Center(
                      child: uiCommon.styledText((widget.alertTitle != null) ? widget.alertTitle! : '', 18, 0, 1.6, FontWeight.w700,
                          IdColors.black, TextAlign.left)),
                ),
                const IdSpace(spaceWidth: 0, spaceHeight: 16),
              ],
            ),
          ),
          Visibility(
            visible: (widget.alertWithImg != null) ? true : false,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (widget.alertWithImg != null) ? widget.alertWithImg! : const SizedBox(),
                const IdSpace(spaceWidth: 0, spaceHeight: 16),
              ],
            ),
          ),
          SizedBox(
            width: 340,
            child: uiCommon.styledText(widget.alertBody, 16, 0, 1.6, FontWeight.w400, IdColors.black, TextAlign.left),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 40),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: ShapeDecoration(
                      color: IdColors.borderDefault,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: IdNormalBtn(
                      onBtnPressed: widget.onBtnPressedLeft,
                      childWidget: Center(
                        child: uiCommon.styledText('취소', 15, 0, 1.6, FontWeight.w600, IdColors.textTertiary, TextAlign.left),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 44,
                    decoration: ShapeDecoration(
                      color: IdColors.green2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                    child: IdNormalBtn(
                      onBtnPressed: widget.onBtnPressedRight,
                      childWidget: Center(
                        child: uiCommon.styledText('확인', 15, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
    return wg1;
  }
}
