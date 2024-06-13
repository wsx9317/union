import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
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
import 'package:unionCDPP/modelVO/myInfoItem.dart';
import 'package:unionCDPP/popup/infoPopup.dart';

class DealStep04_2 extends StatefulWidget {
  const DealStep04_2({super.key});

  @override
  IdState<DealStep04_2> createState() => _DealStep04_2State();
}

class _DealStep04_2State extends IdState<DealStep04_2> {
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  String userNo = GV.pStrg.getXXX(Param_commonUserNo);

  String userName = '';
  String userId = '';
  String userCompany = '';

  bool popupVisible = false;

  int dealCnt = int.tryParse(GV.pStrg.getXXX(Param_regOrderCntStr)) ?? 1;
  String exclusiveContract = '';

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

    if (GV.pStrg.getXXX(Param_dominantlyOwnedStr) == 'true') {
      exclusiveContract = 'Y';
    } else {
      exclusiveContract = 'N';
    }

    stepDesc = ['딜 종류와 유형', '제안한 부동산 기본 정보', '제안한 부동산 거래 정보', '기타  정보 및 사진'];
    GV.pStrg.putXXX(Param_rentRollRegist, '렌트롤등록');

    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    final dynamic ret1 = await IdApi.getMember(MyInfoItem(userNo: userNo));
    if (ret1 != null) {
      MyInfoItem data = ret1;
      userName = data.userName!;
      userCompany = data.office!;
      userId = data.userId!;
      // totalRowsCnt = _faqDs[0].data!.totalCnt!;
    }
    setState(() {});
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
                                height: (exclusiveContract == 'N') ? 585 : 538,
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
                                                    '모든 정보가 등록되었습니다.', 32, 0, 1.3, FontWeight.w700, IdColors.textDefault, TextAlign.left),
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
                                                          imagePath: (exclusiveContract == 'N')
                                                              ? 'assets/img/img_deal_registration_01.png'
                                                              : 'assets/img/img_deal_registration_04.png',
                                                          imageWidth: 300,
                                                          imageHeight: 300,
                                                          imageFit: BoxFit.cover),
                                                      IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                      uiCommon.styledText(
                                                          (dealCnt == 0)
                                                              ? '$userCompany+$userName($userId )님은\n이 물건의 최초 등록자입니다.\n\n안심중개권을 신청하여 중개권리를 보호받을 수 있습니다.\n<onlyGreen>안심중개권</onlyGreen>을 신청하시겠습니까?'
                                                              : (exclusiveContract == 'N')
                                                                  ? '$userCompany+$userName($userId )님은\n이 물건의 ${dealCnt + 1}번째 등록자이십니다.\n이 물건은 아직 전속보호계약이 체결되지 않았습니다.\n\n독점 전속보호계약으로 이 딜을 독점 하시겠습니까?'
                                                                  : '$userCompany+$userName($userId )님은\n이 물건의 ${dealCnt + 1}번째 등록자이십니다.\n애석하게도 이 물건은 독점 전속보호계약이 이미 체결된 딜입니다.',
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
                                                  child: (exclusiveContract == 'N')
                                                      ? Column(
                                                          children: [
                                                            uiCommon.styledText('독점등록이란 중개권리를 보장하기위한 딜스테이션의 정책입니다.', 18, 0, 1.6,
                                                                FontWeight.w400, IdColors.textDefault, TextAlign.center),
                                                            IdNormalBtn(
                                                              onBtnPressed: () {
                                                                popupVisible = true;
                                                                setState(() {});
                                                              },
                                                              childWidget: uiCommon.styledText('<u>자세히 알아보기</u>', 18, 0, 1.6,
                                                                  FontWeight.w400, IdColors.detailBtn, TextAlign.center),
                                                            )
                                                          ],
                                                        )
                                                      : uiCommon.styledText(
                                                          '후순위 등록자는 유니언에서 별도로 기록하고 있으며,\n앞선 중개인과의 소통이 불발되거나 전속보호가 해지되는 경우,\n당사에서 별도로 연락 드리겠습니다.',
                                                          18,
                                                          0,
                                                          1.6,
                                                          FontWeight.w400,
                                                          IdColors.textDefault,
                                                          TextAlign.center),
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                IdDealRegistBottomBtn(
                                                  beforeBtnFunction: (exclusiveContract == 'N')
                                                      ? () {
                                                          GV.pStrg.putXXX(exclusiveContract, 'no');
                                                          uiCommon.IdMovePage(context, PAGE_DEAL_STEP_04_4_PAGE);
                                                        }
                                                      : () {
                                                          uiCommon.IdMovePage(context, PAGE_HOME_PAGE);
                                                        },
                                                  btn1: (exclusiveContract == 'N') ? '좀 더 생각해본 후에' : 'Home',
                                                  afterBtnFunction: (exclusiveContract == 'N')
                                                      ? () {
                                                          uiCommon.IdMovePage(context, PAGE_DEAL_STEP_04_3_PAGE);
                                                        }
                                                      : () {
                                                          uiCommon.IdMovePage(context, PAGE_DEAL_STEP_01_PAGE);
                                                        },
                                                  btn2: (exclusiveContract == 'N') ? '독점 전속보호서약 신청' : '추가 딜 등록',
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
                Visibility(
                  visible: popupVisible,
                  child: Positioned(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: IdColors.black16Per,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Center(
                            child: InfoPopup(
                              popupTitle: '독점등록이란?',
                              cloesFunction: () {
                                if (popupVisible) {
                                  popupVisible = false;
                                } else {
                                  popupVisible = true;
                                }
                                setState(() {});
                              },
                              contentChildWidget: Column(
                                children: [
                                  popupContent('독점등록이란, 중개인이 안심하고 물건을 등록할 수 있도록 하기위한 제도입니다.'),
                                  const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                  popupContent(
                                      '등록하신 물건에 대한 중개권리를 보장하기위한 딜스테이션의 정책입니다. 중개권리에 대한 보장은, 딜스테이션의 독점등록서약을 통해 권리에 대한 보호를 강화하며 중개인은 물건을 안심하고 딜스테이션에 등록할 수 있습니다.'),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                )
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
