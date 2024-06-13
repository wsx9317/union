import 'package:flutter/material.dart';
import 'package:union_admin/api/id_api.dart';
import 'package:union_admin/common/globalvar.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/constants/constants.dart';
import 'package:union_admin/id_widget/IdColor.dart';
import 'package:union_admin/id_widget/IdImageBox1.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';
import 'package:union_admin/id_widget/IdSpace.dart';
import 'package:union_admin/modelVO/labelResponse.dart';
import 'package:union_admin/modelVO/search_option_item.dart';
import 'package:union_admin/popup/alertPopup.dart';

class EditLabelPopup extends StatefulWidget {
  final Function() onlyCloseFunction;
  const EditLabelPopup({super.key, required this.onlyCloseFunction});

  @override
  State<EditLabelPopup> createState() => _EditLabelPopupState();
}

class _EditLabelPopupState extends State<EditLabelPopup> {
  String dealNo = GV.pStrg.getXXX(Param_dealNoString);
  //TODO 임시 유저 넘버
  String userNo = '1';
  List labelList = [];
  List setLabelList = [];
  bool alertPopupVisible = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<void> fetchData() async {
    final LabelResponse? ret1 = await IdApi.getLabelList(SearchOptionItme(dealNo: dealNo));
    if (ret1 != null) {
      for (var i = 0; i < ret1.list!.length; i++) {
        labelList.add([ret1.list![i].label, ret1.list![i].labelColor, ret1.list![i].checked, ret1.list![i].dealLabelNo]);
      }
    }
    setState(() {});
  }

  Future<bool> setLabel() async {
    setLabelList = [];
    for (var i = 0; i < labelList.length; i++) {
      if (labelList[i][2] == 1) {
        setLabelList.add(labelList[i][3]);
      }
    }

    if (setLabelList.length > 12) {
      alertPopupVisible = true;
      setState(() {});
      return false;
    } else {
      try {
        final result = await IdApi.setLabel(userNo, dealNo, setLabelList);
        if (result == null) return false;
      } catch (e) {
        print(e);
      }
    }

    return true;
  }

  Color labelColor(int num) {
    Color result = IdColors.black;
    if (num == 1) {
      result = IdColors.dealLabel01;
    } else if (num == 2) {
      result = IdColors.dealLabel02;
    } else if (num == 3) {
      result = IdColors.dealLabel03;
    } else if (num == 4) {
      result = IdColors.dealLabel04;
    } else if (num == 5) {
      result = IdColors.dealLabel05;
    } else if (num == 6) {
      result = IdColors.dealLabel06;
    } else if (num == 7) {
      result = IdColors.dealLabel07;
    } else if (num == 8) {
      result = IdColors.dealLabel08;
    } else if (num == 9) {
      result = IdColors.dealLabel09;
    } else if (num == 10) {
      result = IdColors.dealLabel10;
    } else if (num == 11) {
      result = IdColors.dealLabel11;
    } else if (num == 12) {
      result = IdColors.dealLabel12;
    }
    return result;
  }

  Color labelBgColor(int num) {
    Color result = IdColors.black;
    if (num == 1) {
      result = IdColors.dealLabelBg01;
    } else if (num == 2) {
      result = IdColors.dealLabelBg02;
    } else if (num == 3) {
      result = IdColors.dealLabelBg03;
    } else if (num == 4) {
      result = IdColors.dealLabelBg04;
    } else if (num == 5) {
      result = IdColors.dealLabelBg05;
    } else if (num == 6) {
      result = IdColors.dealLabelBg06;
    } else if (num == 7) {
      result = IdColors.dealLabelBg07;
    } else if (num == 8) {
      result = IdColors.dealLabelBg08;
    } else if (num == 9) {
      result = IdColors.dealLabelBg09;
    } else if (num == 10) {
      result = IdColors.dealLabelBg10;
    } else if (num == 11) {
      result = IdColors.dealLabelBg11;
    } else if (num == 12) {
      result = IdColors.dealLabelBg12;
    }
    return result;
  }

  Widget bottomBtn(String title, Color btnColor, Function() onBtnPressed) {
    return IdNormalBtn(
      onBtnPressed: onBtnPressed,
      childWidget: Container(
        width: 80,
        height: 44,
        decoration: BoxDecoration(color: btnColor, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: uiCommon.styledText(title, 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Stack(
      children: [
        Container(
          width: 300,
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: IdColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
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
              SizedBox(
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      child: uiCommon.styledText('프로젝트 라벨', 18, 0, 1, FontWeight.w800, IdColors.black, TextAlign.left),
                    ),
                    IdNormalBtn(
                      onBtnPressed: widget.onlyCloseFunction,
                      childWidget:
                          const IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                    )
                  ],
                ),
              ),
              const IdSpace(spaceWidth: 0, spaceHeight: 24),
              Container(
                width: double.infinity,
                height: 352,
                padding: const EdgeInsets.symmetric(
                  vertical: 23,
                ),
                decoration: const BoxDecoration(
                  border: Border(
                    top: BorderSide(width: 1, color: IdColors.borderDefault),
                    bottom: BorderSide(width: 1, color: IdColors.borderDefault),
                  ),
                ),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      children: List.generate(
                        labelList.length,
                        (index) => Column(
                          children: [
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: IdColors.backgroundDefault,
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(width: 1, color: IdColors.borderDefault),
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  top: 0,
                                  bottom: 0,
                                  right: 0,
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 40,
                                          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 11),
                                          decoration: BoxDecoration(
                                            color: labelBgColor(int.tryParse(labelList[index][1]) ?? 1),
                                            border: Border.all(
                                              width: 1,
                                              color: labelColor(int.tryParse(labelList[index][1]) ?? 1),
                                            ),
                                            borderRadius: BorderRadius.horizontal(
                                              left: Radius.circular(4),
                                            ),
                                          ),
                                          child: uiCommon.styledText(labelList[index][0], 16, 0, 1.6, FontWeight.w600,
                                              labelColor(int.tryParse(labelList[index][1]) ?? 1), TextAlign.left),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: IdNormalBtn(
                                            onBtnPressed: () {
                                              if (labelList[index][2] == 1) {
                                                labelList[index][2] = 0;
                                              } else {
                                                labelList[index][2] = 1;
                                              }
                                              setState(() {});
                                            },
                                            childWidget: IdImageBox(
                                                imagePath: (labelList[index][2] == 1)
                                                    ? 'assets/img/icon_checkbox_checked.png'
                                                    : 'assets/img/icon_checkbox_noneCheck.png',
                                                imageWidth: 16,
                                                imageHeight: 16,
                                                imageFit: BoxFit.cover)),
                                      )
                                    ],
                                  ),
                                )
                              ],
                            ),
                            IdSpace(spaceWidth: 0, spaceHeight: (index + 1 == labelList.length) ? 0 : 4),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              IdSpace(spaceWidth: 0, spaceHeight: 24),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: Row(
                  children: [
                    Expanded(child: SizedBox()),
                    Row(
                      children: [
                        bottomBtn('취소', IdColors.textTertiary, widget.onlyCloseFunction),
                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                        bottomBtn('저장', IdColors.green, () async {
                          if (await setLabel()) {
                            uiCommon.IdMovePage(context, PAGE_DEAL_DETAIL_PAGE);
                          } else {
                            GV.d('실패');
                            alertPopupVisible = true;
                            setState(() {});
                          }
                        }),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        Visibility(
          visible: alertPopupVisible,
          child: Positioned(
              top: 0,
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: IdColors.black8Per,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AlertPopup(
                        width: 300,
                        popupTitle: '에러',
                        content: '최대 선택가능한 12개를 넘겼습니다.\n현재 ${setLabelList.length}개입니다.',
                        onlyCloseFunction: () {
                          alertPopupVisible = false;
                          setState(() {});
                        },
                        activeFunction: () {
                          alertPopupVisible = false;
                          setState(() {});
                        }),
                  ],
                ),
              )),
        )
      ],
    );
    return wg1;
  }
}
