import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';

class IdBoardCnt extends StatefulWidget {
  final int currentCnt;
  final int totalCnt;
  const IdBoardCnt({super.key, required this.currentCnt, required this.totalCnt});

  @override
  State<IdBoardCnt> createState() => _IdBoardCntState();
}

class _IdBoardCntState extends State<IdBoardCnt> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Row(
      children: [
        uiCommon.styledText(widget.currentCnt.toString(), 16, 0.14, 1.6, FontWeight.w600, IdColors.green2, TextAlign.left),
        uiCommon.styledText('건 / 총 ', 16, 0.14, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
        uiCommon.styledText(widget.totalCnt.toString(), 16, 0.14, 1.6, FontWeight.w600, IdColors.green2, TextAlign.left),
        uiCommon.styledText('건', 16, 0.14, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
      ],
    );
    return wg1;
  }
}
