import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdToolTipMessage1 extends StatefulWidget {
  final String imgPath;
  final String message;
  const IdToolTipMessage1({super.key, required this.imgPath, required this.message});

  @override
  State<IdToolTipMessage1> createState() => _IdToolTipMessage1State();
}

class _IdToolTipMessage1State extends State<IdToolTipMessage1> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 328,
      decoration: BoxDecoration(color: IdColors.green2, borderRadius: BorderRadius.circular(8)),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        color: IdColors.white90per,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 5),
              child: IdImageBox(imagePath: widget.imgPath, imageWidth: 16, imageHeight: 16, imageFit: BoxFit.cover),
            ),
            const IdSpace(spaceWidth: 8, spaceHeight: 0),
            Expanded(
              child: SizedBox(
                child: uiCommon.styledText(widget.message, 14, 0, 1.6, FontWeight.w400, IdColors.green2, TextAlign.left),
              ),
            ),
          ],
        ),
      ),
    );
    return wg1;
  }
}
