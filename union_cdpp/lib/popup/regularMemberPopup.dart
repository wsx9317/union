import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class RegularmemberPopup extends StatefulWidget {
  final Function() backPageFunction;
  const RegularmemberPopup({super.key, required this.backPageFunction});

  @override
  State<RegularmemberPopup> createState() => _RegularmemberPopupState();
}

class _RegularmemberPopupState extends State<RegularmemberPopup> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 420,
      height: 423,
      padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 17),
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: IdColors.white,
          ),
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
          Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 29,
              ),
              Positioned(
                top: 0,
                left: 7,
                child: uiCommon.styledText('정회원 딜 등록안내', 18, 0, 1.6, FontWeight.w700, IdColors.black, TextAlign.left),
              ),
              Positioned(
                top: 0,
                right: 7,
                child: IdNormalBtn(
                  onBtnPressed: widget.backPageFunction,
                  childWidget: IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                ),
              )
            ],
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 48),
          SizedBox(
            width: double.infinity,
            child: uiCommon.styledText('정회원이 되어야 딜을 등록할 수 있습니다.', 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.center),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
            decoration: ShapeDecoration(
              color: IdColors.green5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Column(
              children: [
                SizedBox(
                    width: double.infinity,
                    child: uiCommon.styledText(
                        '정회원 기준 : \n- 가입 후 관리자가 정보 확인 후 등급이 반영됩니다. \n- 중개인, 시행사의 경우 소속, 사무실 주소, 명함을 등록하셔야 정회원이 되실 수 있습니다.',
                        14,
                        0,
                        1.6,
                        FontWeight.w500,
                        IdColors.textDefault,
                        TextAlign.left)),
              ],
            ),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          IdNormalBtn(
            onBtnPressed: () {
              uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
            },
            childWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(
                    color: IdColors.white,
                    border: Border.all(width: 1, color: IdColors.textDefault),
                    borderRadius: BorderRadius.circular(8)),
                child: Center(child: uiCommon.styledText('회원정보 바로가기', 15, 1, 0, FontWeight.w600, IdColors.textDefault, TextAlign.center)),
              ),
            ),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          IdNormalBtn(
            onBtnPressed: widget.backPageFunction,
            // onBtnPressed: () {
            //   uiCommon.IdMovePage(context, PAGE_HOME_PAGE);
            // },
            childWidget: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 7),
              child: Container(
                width: double.infinity,
                height: 44,
                decoration: BoxDecoration(color: IdColors.green2, borderRadius: BorderRadius.circular(8)),
                child: Center(child: uiCommon.styledText('확인', 15, 1, 0, FontWeight.w600, IdColors.white, TextAlign.center)),
              ),
            ),
          ),
        ],
      ),
    );
    return wg1;
  }
}
