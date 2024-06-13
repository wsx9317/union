import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdPageStep extends StatefulWidget {
  final List stepDesc;
  final int pageNumber;
  const IdPageStep({super.key, required this.stepDesc, required this.pageNumber});

  @override
  State<IdPageStep> createState() => _IdPageStepState();
}

class _IdPageStepState extends State<IdPageStep> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: List.generate(
        widget.stepDesc.length,
        (index) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                (index + 1 <= widget.pageNumber)
                    ? Container(
                        width: 32,
                        height: 32,
                        decoration: const BoxDecoration(color: IdColors.green2, shape: BoxShape.circle),
                        child: const Center(
                          child: IdImageBox(
                              imagePath: 'assets/img/icon_check_white.png', imageWidth: 18, imageHeight: 18, imageFit: BoxFit.cover),
                        ),
                      )
                    : (index == widget.pageNumber)
                        ? Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color.fromRGBO(255, 255, 255, 0),
                              shape: BoxShape.circle,
                              border: Border.all(
                                width: 4,
                                color: IdColors.green1,
                              ),
                            ),
                          )
                        : Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color.fromRGBO(255, 255, 255, 0),
                                border: Border.all(
                                  width: 1,
                                  color: IdColors.borderDefault,
                                )),
                          ),
                const IdSpace(spaceWidth: 24, spaceHeight: 0),
                uiCommon.styledText((index <= 8) ? 'Step 0${index + 1}' : 'Step ${index + 1}', 16, 0, 1, FontWeight.w700,
                    IdColors.textDefault, TextAlign.left),
                const IdSpace(spaceWidth: 16, spaceHeight: 0),
                uiCommon.styledText(widget.stepDesc[index], 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left)
              ],
            ),
            (index == widget.stepDesc.length - 1)
                ? SizedBox()
                : Padding(
                    padding: const EdgeInsets.only(left: 16),
                    child: Container(
                      width: 1,
                      height: 24,
                      color: (index + 1 <= widget.pageNumber) ? IdColors.green1 : IdColors.borderDefault,
                    ),
                  )
          ],
        ),
      ),
    );
    return wg1;
  }
}
