import 'package:flutter/material.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/id_widget/IdColor.dart';
import 'package:union_admin/id_widget/IdImageBox1.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';

class AgreePopup extends StatefulWidget {
  final Function() onlyCloseFunction;
  const AgreePopup({super.key, required this.onlyCloseFunction});

  @override
  State<AgreePopup> createState() => _AgreePopupState();
}

class _AgreePopupState extends State<AgreePopup> {
  int tabNum = 1;

  Widget tabBtn(String btnTitle, int btnNum) {
    return IdNormalBtn(
      onBtnPressed: () {
        tabNum = btnNum;
        setState(() {});
      },
      childWidget: Stack(
        children: [
          Container(
            width: (tabNum == 1) ? 145 : 149,
            height: 50,
            decoration: (tabNum == btnNum)
                ? BoxDecoration(
                    border: Border.all(width: 1, color: IdColors.textDefault),
                    color: IdColors.white,
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  )
                : const BoxDecoration(
                    color: IdColors.white,
                    border: Border(bottom: BorderSide(width: 1, color: IdColors.textDefault)),
                  ),
            child: Center(
              child: uiCommon.styledText(
                  btnTitle, 16, 0, 1, FontWeight.w700, (tabNum == btnNum) ? IdColors.textDefault : IdColors.textTertiary, TextAlign.center),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 700,
      height: 516,
      decoration: BoxDecoration(
        color: IdColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            height: 77,
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                IdNormalBtn(
                  onBtnPressed: widget.onlyCloseFunction,
                  childWidget:
                      const IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 347,
            padding: const EdgeInsets.symmetric(vertical: 23, horizontal: 24),
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: IdColors.borderDefault),
                bottom: BorderSide(width: 1, color: IdColors.borderDefault),
              ),
            ),
            child: Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 66,
                      child: Row(
                        children: [
                          tabBtn('독점보호인증서', 1),
                          tabBtn('독점보호 정책서', 2),
                          Expanded(
                            child: Container(
                              width: double.infinity,
                              height: 50,
                              decoration: const BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(width: 1, color: IdColors.textDefault),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (tabNum == 1) ? true : false,
                      child: Positioned(
                          bottom: 0,
                          left: 1,
                          child: Container(
                            width: 143,
                            height: 17,
                            color: IdColors.white,
                          )),
                    ),
                    Visibility(
                      visible: (tabNum == 2) ? true : false,
                      child: Positioned(
                          bottom: 0,
                          left: 150,
                          child: Container(
                            width: 147,
                            height: 17,
                            color: IdColors.white,
                          )),
                    )
                  ],
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: SizedBox(
                    width: double.infinity,
                    height: 233,
                    //TODO 추후 디자인이 생기면 만들곳
                    child: uiCommon.styledText(
                        '내용은 아직 미정입니다.\n등록 완료 화면으로 이동 (딜 등록 시 독점전속계약 완료)\n\n- 체크박스 미 체크 시 “내용 확인에 체크 하여 주세요. 확인’ system alert',
                        15,
                        0,
                        1.6,
                        FontWeight.w400,
                        IdColors.textSecondly,
                        TextAlign.left),
                  ),
                )
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 92,
            padding: const EdgeInsets.all(24),
            child: Row(
              children: [
                const Expanded(child: SizedBox()),
                IdNormalBtn(
                  onBtnPressed: widget.onlyCloseFunction,
                  childWidget: Container(
                    width: 80,
                    height: 44,
                    decoration: BoxDecoration(
                      color: IdColors.textTertiary,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: uiCommon.styledText('닫기', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
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
