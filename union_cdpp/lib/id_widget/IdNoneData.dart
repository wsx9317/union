import 'package:flutter/gestures.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:flutter/material.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdNoneData extends StatefulWidget {
  final String dataBoardType;
  final String? imgPath;
  final double? imgWidth;
  final double? imgHeight;
  final String? noDataText;
  final Widget? childWidget;

  const IdNoneData(
      {super.key, required this.dataBoardType, this.imgPath, this.imgWidth, this.imgHeight, this.noDataText, this.childWidget});

  @override
  State<IdNoneData> createState() => _IdNoneDataState();
}

class _IdNoneDataState extends State<IdNoneData> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = (widget.dataBoardType == 'normal')
        ? SizedBox(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: uiCommon.styledText('검색된 데이터가 없습니다.', 18, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                ),
              ],
            ),
          )
        : Column(
            children: [
              const IdSpace(spaceWidth: 0, spaceHeight: 140),
              SizedBox(
                width: 200,
                child: Column(
                  children: [
                    (widget.imgPath != null)
                        ? IdImageBox(
                            imagePath: (widget.imgPath != null) ? widget.imgPath! : '',
                            imageWidth: (widget.imgWidth != null) ? widget.imgWidth! : 0,
                            imageHeight: (widget.imgHeight != null) ? widget.imgHeight! : 0,
                            imageFit: BoxFit.cover)
                        : const SizedBox(),
                    const IdSpace(spaceWidth: 0, spaceHeight: 24),
                    uiCommon.styledText((widget.noDataText != null) ? widget.noDataText! : '', 18, 0, 1.6, FontWeight.w400,
                        IdColors.textDefault, TextAlign.left),
                    const IdSpace(spaceWidth: 0, spaceHeight: 40),
                    (widget.childWidget != null) ? widget.childWidget! : const SizedBox()
                  ],
                ),
              ),
              const IdSpace(spaceWidth: 0, spaceHeight: 240),
            ],
          );
    return wg1;
  }
}
