import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdDealRegistBottomBtn extends StatefulWidget {
  final Function() beforeBtnFunction;
  final String btn1;
  final Function() afterBtnFunction;
  final String btn2;
  const IdDealRegistBottomBtn(
      {super.key, required this.beforeBtnFunction, required this.btn1, required this.afterBtnFunction, required this.btn2});

  @override
  State<IdDealRegistBottomBtn> createState() => _IdDealRegistBottomBtnState();
}

class _IdDealRegistBottomBtnState extends State<IdDealRegistBottomBtn> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Row(
      children: [
        IdNormalBtn(
          onBtnPressed: widget.beforeBtnFunction,
          childWidget: Container(
            height: 57,
            padding: EdgeInsets.symmetric(horizontal: 32),
            decoration: ShapeDecoration(
              color: IdColors.borderDefault,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: Center(
              child: uiCommon.styledText(widget.btn1, 18, 0, 1, FontWeight.w700, IdColors.textTertiary, TextAlign.left),
            ),
          ),
        ),
        const IdSpace(spaceWidth: 12, spaceHeight: 0),
        Expanded(
          child: IdNormalBtn(
            onBtnPressed: widget.afterBtnFunction,
            childWidget: Container(
              height: 57,
              decoration: ShapeDecoration(
                color: IdColors.green2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
              child: Center(
                child: uiCommon.styledText(widget.btn2, 18, 0, 1, FontWeight.w700, IdColors.white, TextAlign.left),
              ),
            ),
          ),
        ),
      ],
    );
    return wg1;
  }
}
