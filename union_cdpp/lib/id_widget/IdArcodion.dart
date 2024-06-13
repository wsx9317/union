import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdArcodion extends StatefulWidget {
  final String category;
  final String question;
  final Widget imgWidget;
  final Widget arcodonWidget;
  const IdArcodion({
    super.key,
    required this.category,
    required this.question,
    required this.imgWidget,
    required this.arcodonWidget,
  });

  @override
  State<IdArcodion> createState() => _IdArcodionState();
}

class _IdArcodionState extends State<IdArcodion> {
  // bool descVisible = false;
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          IdSpace(spaceWidth: 0, spaceHeight: 37),
          uiCommon.styledText(widget.category, 16, 0.14, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
          const IdSpace(spaceWidth: 0, spaceHeight: 12),
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: SizedBox(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            uiCommon.styledText('Q.', 20, 0, 1.6, FontWeight.w800, IdColors.green1, TextAlign.left),
                            const IdSpace(spaceWidth: 8, spaceHeight: 0),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 1.5),
                              child:
                                  uiCommon.styledText(widget.question, 20, 0, 1.6, FontWeight.w800, IdColors.textDefault, TextAlign.left),
                            ),
                          ],
                        ),
                      ),
                    ),
                    widget.imgWidget
                  ],
                ),
              ],
            ),
          ),
          widget.arcodonWidget,
          const IdSpace(spaceWidth: 0, spaceHeight: 32),
        ],
      ),
    );
    return wg1;
  }
}
