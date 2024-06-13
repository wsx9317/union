import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class InfoPopup extends StatefulWidget {
  final String popupTitle;
  final Function() cloesFunction;
  final Widget contentChildWidget;
  const InfoPopup({super.key, required this.popupTitle, required this.cloesFunction, required this.contentChildWidget});

  @override
  State<InfoPopup> createState() => _InfoPopupState();
}

class _InfoPopupState extends State<InfoPopup> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 420,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: IdColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
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
          Row(
            children: [
              Expanded(
                child: uiCommon.styledText(widget.popupTitle, 18, 0, 1.6, FontWeight.w700, Colors.black, TextAlign.left),
              ),
              const IdSpace(spaceWidth: 16, spaceHeight: 0),
              IdNormalBtn(
                onBtnPressed: widget.cloesFunction,
                childWidget: IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 20, imageHeight: 20, imageFit: BoxFit.cover),
              ),
            ],
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 48),
          widget.contentChildWidget,
          const IdSpace(spaceWidth: 0, spaceHeight: 48),
          IdNormalBtn(
            onBtnPressed: widget.cloesFunction,
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
        ],
      ),
    );
    return wg1;
  }
}
