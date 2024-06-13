import 'package:flutter/material.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDealRegistBottomBtn.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageStep.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';

class DealStep04_4 extends StatefulWidget {
  const DealStep04_4({super.key});

  @override
  IdState<DealStep04_4> createState() => _DealStep04_4State();
}

class _DealStep04_4State extends IdState<DealStep04_4> {
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  String contractStatus = GV.pStrg.getXXX(Param_exclusiveContract);

  @override
  void initState() {
    super.initState();
    menuNavigator = ['home', 'Deal', 'Deal 등록'];
    menuNavigatorLink = [
      () {
        // uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
      },
      () {
        // uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
      }
    ];
    stepDesc = ['딜 종류와 유형', '제안한 부동산 기본 정보', '제안한 부동산 거래 정보', '기타  정보 및 사진'];

    print(contractStatus);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget popupContent(String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 12),
          child: Container(
            width: 4,
            height: 4,
            decoration: const BoxDecoration(
              color: IdColors.textDefault,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        Expanded(
          child: uiCommon.styledText(content, 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
        ),
      ],
    );
  }

  @override
  Widget idBuild(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          uiCommon.IdMovePage(context, '{PREV}');
          return false;
        },
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const IdSpace(spaceWidth: 0, spaceHeight: 74),
                      Stack(
                        children: [
                          Column(
                            children: [
                              Container(
                                width: double.infinity,
                                height: 726,
                                color: IdColors.pageTopBackground,
                              ),
                              Container(
                                width: double.infinity,
                                //TODO - 전체길이
                                height: 482,
                                color: IdColors.white,
                              ),
                            ],
                          ),
                          Positioned(
                            top: 0,
                            left: 0,
                            right: 0,
                            bottom: 0,
                            child: SizedBox(
                              width: double.infinity,
                              child: Center(
                                child: Container(
                                  constraints: const BoxConstraints(
                                    maxWidth: 1224,
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      IdTopNavigator(navigatorMenu: menuNavigator, navigatorLink: menuNavigatorLink),
                                      const IdSpace(spaceWidth: 0, spaceHeight: 30),
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          //설명부분
                                          Column(
                                            children: [
                                              const IdSpace(spaceWidth: 0, spaceHeight: 90),
                                              SizedBox(
                                                width: 321,
                                                child: uiCommon.styledText('거래하고 싶은 매물을\n등록해볼까요?', 56, 0, 1.3, FontWeight.w700,
                                                    IdColors.textDefault, TextAlign.left),
                                              ),
                                              const IdSpace(spaceWidth: 0, spaceHeight: 158),
                                              IdPageStep(stepDesc: stepDesc, pageNumber: 4)
                                            ],
                                          ),
                                          const IdSpace(spaceWidth: 84, spaceHeight: 0),
                                          //입력부분
                                          Container(
                                            width: 807,
                                            padding: const EdgeInsets.all(60),
                                            decoration: ShapeDecoration(
                                              color: IdColors.white,
                                              shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(24),
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
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                uiCommon.styledText(
                                                    (contractStatus == 'yes') ? '감사합니다! 안심중개권신청이 완료되었습니다.' : '감사합니다! 모든 딜 등록 절차가 완료되었습니다.',
                                                    32,
                                                    0,
                                                    1.3,
                                                    FontWeight.w700,
                                                    IdColors.textDefault,
                                                    TextAlign.left),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 1,
                                                  child: CustomPaint(
                                                    painter: DashedLinePainter1(),
                                                  ),
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Center(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                    children: [
                                                      IdImageBox(
                                                          imagePath: (contractStatus == 'yes')
                                                              ? 'assets/img/img_deal_registration_02.png'
                                                              : 'assets/img/img_deal_registration_03.png',
                                                          imageWidth: 300,
                                                          imageHeight: 300,
                                                          imageFit: BoxFit.cover),
                                                      const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                      uiCommon.styledText(
                                                          (contractStatus == 'yes')
                                                              ? '영업일 기준 48시간 내 딜스테이션 담당자가 확인하여\n승인절차를 진행할 예정입니다.'
                                                              : '등록하신 물건은 ‘마이페이지‘ 에서 조회하실 수 있습니다.\n이후에라도 안심중개권을 희망하시는 경우,\n마이페이지에서 안심중개권을 신청해주시기 바랍니다.',
                                                          24,
                                                          1,
                                                          1.6,
                                                          FontWeight.w600,
                                                          IdColors.textDefault,
                                                          TextAlign.center)
                                                    ],
                                                  ),
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                SizedBox(
                                                  width: double.infinity,
                                                  height: 1,
                                                  child: CustomPaint(
                                                    painter: DashedLinePainter1(),
                                                  ),
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Center(
                                                  child: Row(
                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                    children: [
                                                      uiCommon.styledText(
                                                          '등록한 딜은 ', 18, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.center),
                                                      IdNormalBtn(
                                                        onBtnPressed: () {
                                                          uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
                                                        },
                                                        childWidget: uiCommon.styledText('<u>My Page</u>', 18, 0, 1.6, FontWeight.w400,
                                                            IdColors.detailBtn, TextAlign.center),
                                                      ),
                                                      uiCommon.styledText(' 에서 내가 등록한 딜에서 확인 하실 수 있습니다.', 18, 0, 1.6, FontWeight.w400,
                                                          IdColors.textDefault, TextAlign.center),
                                                    ],
                                                  ),
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                                IdDealRegistBottomBtn(
                                                  beforeBtnFunction: () {
                                                    GV.pStrg.putXXX(Param_exclusiveContract, 'unkown');
                                                    GV.pStrg.putXXX(Param_regOrderCntStr, '갯수');
                                                    GV.pStrg.putXXX(Param_dominantlyOwnedStr, '독점유무');
                                                    uiCommon.IdMovePage(context, PAGE_HOME_PAGE);
                                                  },
                                                  btn1: 'Home',
                                                  afterBtnFunction: () {
                                                    GV.pStrg.putXXX(Param_exclusiveContract, 'unkown');
                                                    GV.pStrg.putXXX(Param_regOrderCntStr, '갯수');
                                                    GV.pStrg.putXXX(Param_dominantlyOwnedStr, '독점유무');
                                                    uiCommon.IdMovePage(context, PAGE_DEAL_STEP_01_PAGE);
                                                  },
                                                  btn2: '추가 딜 등록',
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      idCommonFooter(),
                    ],
                  ),
                ),
                idCommonHeader(),
              ],
            ),
          ),
        ));
  }
}

class DashedLinePainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = IdColors.borderDefault
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    const dashWidth = 4;
    const dashSpace = 2;
    double startX = 0;

    while (startX < size.width) {
      canvas.drawLine(
        Offset(startX, 0),
        Offset(startX + dashWidth, 0),
        paint,
      );

      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
