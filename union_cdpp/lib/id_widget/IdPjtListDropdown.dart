import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdPjtDropdown extends StatefulWidget {
  final List pjtDataList;
  final List pjtDataColorList;
  final String pageName;
  const IdPjtDropdown({super.key, required this.pjtDataList, required this.pjtDataColorList, required this.pageName});

  @override
  State<IdPjtDropdown> createState() => _IdPjtDropdownState();
}

Color mainColor(String colorStr) {
  Color result = IdColors.green2;

  if (colorStr == '1') {
    result = IdColors.labelMain_01;
  } else if (colorStr == '2') {
    result = IdColors.labelMain_02;
  } else if (colorStr == '3') {
    result = IdColors.labelMain_03;
  } else if (colorStr == '4') {
    result = IdColors.labelMain_04;
  } else if (colorStr == '5') {
    result = IdColors.labelMain_05;
  } else if (colorStr == '6') {
    result = IdColors.labelMain_06;
  } else if (colorStr == '7') {
    result = IdColors.labelMain_07;
  } else if (colorStr == '8') {
    result = IdColors.labelMain_08;
  } else if (colorStr == '9') {
    result = IdColors.labelMain_09;
  } else if (colorStr == '10') {
    result = IdColors.labelMain_10;
  } else if (colorStr == '11') {
    result = IdColors.labelMain_11;
  } else if (colorStr == '12') {
    result = IdColors.labelMain_12;
  }

  return result;
}

Color backColor(String colorStr) {
  Color result = IdColors.green2;
  if (colorStr == '1') {
    result = IdColors.labelBack_01;
  } else if (colorStr == '2') {
    result = IdColors.labelBack_02;
  } else if (colorStr == '3') {
    result = IdColors.labelBack_03;
  } else if (colorStr == '4') {
    result = IdColors.labelBack_04;
  } else if (colorStr == '5') {
    result = IdColors.labelBack_05;
  } else if (colorStr == '6') {
    result = IdColors.labelBack_06;
  } else if (colorStr == '7') {
    result = IdColors.labelBack_07;
  } else if (colorStr == '8') {
    result = IdColors.labelBack_08;
  } else if (colorStr == '9') {
    result = IdColors.labelBack_09;
  } else if (colorStr == '10') {
    result = IdColors.labelBack_10;
  } else if (colorStr == '11') {
    result = IdColors.labelBack_11;
  } else if (colorStr == '12') {
    result = IdColors.labelBack_12;
  }
  return result;
}

class _IdPjtDropdownState extends State<IdPjtDropdown> {
  bool openDropdown1 = false;
  bool openDropdown2 = false;
  @override
  Widget build(BuildContext context) {
    Widget wg1 = (widget.pjtDataList.isNotEmpty)
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  (widget.pageName == 'MyDeal')
                      ? Row(
                          children: List.generate(
                            (widget.pjtDataList.length < 4) ? widget.pjtDataList.length : 4,
                            (index) => Row(
                              children: [
                                Container(
                                  width: 94,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: backColor(widget.pjtDataColorList[index]),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: mainColor(
                                        widget.pjtDataColorList[index],
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: uiCommon.styledText(widget.pjtDataList[index], 14, 0, 1, FontWeight.w600,
                                        mainColor(widget.pjtDataColorList[index]), TextAlign.center),
                                  ),
                                ),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0)
                              ],
                            ),
                          ),
                        )
                      : Row(
                          children: [
                            Container(
                              width: 94,
                              height: 26,
                              decoration: BoxDecoration(
                                color: backColor(widget.pjtDataColorList[0]),
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(
                                  width: 1,
                                  color: mainColor(
                                    widget.pjtDataColorList[0],
                                  ),
                                ),
                              ),
                              child: Center(
                                child: uiCommon.styledText(widget.pjtDataList[0], 14, 0, 1, FontWeight.w600,
                                    mainColor(widget.pjtDataColorList[0]), TextAlign.center),
                              ),
                            ),
                            const IdSpace(spaceWidth: 8, spaceHeight: 0)
                          ],
                        ),
                  (widget.pageName == 'MyDeal')
                      ? (widget.pjtDataList.length > 5)
                          ? IdNormalBtn(
                              onBtnPressed: () {
                                if (widget.pageName == 'MyDeal') {
                                  if (openDropdown1) {
                                    openDropdown1 = false;
                                  } else {
                                    openDropdown1 = true;
                                  }
                                } else {
                                  if (openDropdown2) {
                                    openDropdown2 = false;
                                  } else {
                                    openDropdown2 = true;
                                  }
                                }
                                setState(() {});
                              },
                              childWidget: Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: const IdImageBox(
                                    imagePath: 'assets/img/icon_dropdown_more.png',
                                    imageWidth: 26,
                                    imageHeight: 26,
                                    imageFit: BoxFit.cover),
                              ),
                            )
                          : const SizedBox()
                      : (widget.pjtDataList.length > 1)
                          ? IdNormalBtn(
                              onBtnPressed: () {
                                if (widget.pageName == 'MyDeal') {
                                  if (openDropdown1) {
                                    openDropdown1 = false;
                                  } else {
                                    openDropdown1 = true;
                                  }
                                } else {
                                  if (openDropdown2) {
                                    openDropdown2 = false;
                                  } else {
                                    openDropdown2 = true;
                                  }
                                }
                                setState(() {});
                              },
                              childWidget: Container(
                                width: 26,
                                height: 26,
                                decoration: const BoxDecoration(shape: BoxShape.circle),
                                child: const IdImageBox(
                                    imagePath: 'assets/img/icon_dropdown_more.png',
                                    imageWidth: 26,
                                    imageHeight: 26,
                                    imageFit: BoxFit.cover),
                              ),
                            )
                          : SizedBox()
                ],
              ),
              Visibility(
                visible: openDropdown1,
                child: Column(
                  children: [
                    const IdSpace(spaceWidth: 0, spaceHeight: 8),
                    Container(
                      width: 636,
                      padding: const EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 8),
                      decoration: BoxDecoration(
                        color: IdColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: IdColors.black8Per,
                            blurRadius: 12,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: Wrap(
                        children: List.generate(
                          widget.pjtDataList.length,
                          (index) => SizedBox(
                            width: 102,
                            child: Row(
                              children: [
                                Container(
                                  width: 94,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: backColor(widget.pjtDataColorList[index]),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: mainColor(
                                        widget.pjtDataColorList[index],
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: uiCommon.styledText(widget.pjtDataList[index], 14, 0, 1, FontWeight.w600,
                                        mainColor(widget.pjtDataColorList[index]), TextAlign.left),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Visibility(
                visible: openDropdown2,
                child: Column(
                  children: [
                    const IdSpace(spaceWidth: 0, spaceHeight: 8),
                    Container(
                      width: 110,
                      constraints: BoxConstraints(maxHeight: 110),
                      padding: const EdgeInsets.only(top: 8, bottom: 8, left: 8, right: 8),
                      decoration: BoxDecoration(
                        color: IdColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(
                            color: IdColors.black8Per,
                            blurRadius: 12,
                            offset: Offset(0, 0),
                            spreadRadius: 0,
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: List.generate(
                            widget.pjtDataList.length,
                            (index) => Column(
                              children: [
                                Container(
                                  width: 94,
                                  height: 26,
                                  decoration: BoxDecoration(
                                    color: backColor(widget.pjtDataColorList[index]),
                                    borderRadius: BorderRadius.circular(8),
                                    border: Border.all(
                                      width: 1,
                                      color: mainColor(
                                        widget.pjtDataColorList[index],
                                      ),
                                    ),
                                  ),
                                  child: Center(
                                    child: uiCommon.styledText(widget.pjtDataList[index], 14, 0, 1, FontWeight.w600,
                                        mainColor(widget.pjtDataColorList[index]), TextAlign.left),
                                  ),
                                ),
                                (index == widget.pjtDataList.length - 1) ? SizedBox() : const IdSpace(spaceWidth: 0, spaceHeight: 8),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )
        : const SizedBox();
    return wg1;
  }
}
