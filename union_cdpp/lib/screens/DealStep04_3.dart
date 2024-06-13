import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdCommmonFooter.dart';
import 'package:unionCDPP/id_widget/IdCommonHeader.dart';
import 'package:unionCDPP/id_widget/IdDealRegistBottomBtn.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageStep.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/id_widget/IdTopToast.dart';

class DealStep04_3 extends StatefulWidget {
  const DealStep04_3({super.key});

  @override
  IdState<DealStep04_3> createState() => _DealStep04_3State();
}

class _DealStep04_3State extends IdState<DealStep04_3> {
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  String userName = '';
  String userId = '';
  String userOffice = '';
  String dealAddress = '';

  String dealNo = GV.pStrg.getXXX(Param_newDealNo);
  String userNo = GV.pStrg.getXXX(Param_commonUserNo);

  bool check1YN = false;
  bool check2YN = false;

  String today = DateFormat('yyyy-MM-dd').format(DateTime.now());
  String lastDateTime = '';
  DateTime now = DateTime.now();

  String thisYear = '';
  String thisMonth = '';
  String thisDay = '';

  List<String> contentList = [
    '안심중개인이 다음 항목을 위반하는 경우, 딜스테이션은 2회의 경고 후 안심중개권을 해지 통보할 수 있다.',
    '가. 중개인의 업무미숙 (반복적인 중개 오류, 매수의뢰자의 컴플레인 발생 등)',
    '나. 중개인의 과실로 인해 커뮤니케이션의 차질이 생기는 경우 (과도한 답변 지연, 요청 불응 등)',
    '안심중개인이 다음 항목을 위반하는 경우, 딜스테이션은 즉시 안심중개권을 해지 통보할 수 있다.',
    '가. 허위 매물 정보로 등록된 경우 (잘못된 주소, 매물 정보 적발 등)',
    '나. 신의성실 원칙에 위반하는 경우 (중개인 담합, 호가 허위등록 등)',
    '다. 기타 사유로 거래가 불가능한 상황 (거래완료 매물 등록, 영업불가, 하자사항 미고지 등)',
  ];

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

    DateTime futureData = DateTime(now.year, now.month, now.day + 180);
    lastDateTime = DateFormat('yyyy-MM-dd').format(futureData);

    userName = GV.pStrg.getXXX(Param_commonUserName);
    userId = GV.pStrg.getXXX(Param_commonUserId);
    userOffice = GV.pStrg.getXXX(Param_commonUserOffice);
    dealAddress = GV.pStrg.getXXX(Param_dealAddress);

    print(today);
    thisYear = today.substring(0, 4);
    thisMonth = today.substring(4, 6);
    thisDay = today.substring(6, 8);
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget textWithVerse1(String verse, String content) {
    return Row(
      children: [
        uiCommon.styledText('$verse. ', 18, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
        uiCommon.styledText(content, 18, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
      ],
    );
  }

  Widget textWidthVerse2(String verse, String content) {
    return Row(
      children: [
        const IdSpace(spaceWidth: 16, spaceHeight: 0),
        textWithVerse1(verse, content),
      ],
    );
  }

  Future<bool> applyDomi() async {
    final result = await IdApi.setApplyDomi(dealNo, userNo);
    if (result == null) {
      return false;
    }
    return true;
  }

  Widget withDottedText(String text) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Container(
            width: 30,
            padding: EdgeInsets.only(top: 5),
            child: Center(
              child: Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: IdColors.textDefault,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
        ),
        uiCommon.styledText(text, 18, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
      ],
    );
  }

  Widget checkWithLabel(bool checkBox, String text, Function() onBtnPressed) {
    return Row(
      children: [
        IdNormalBtn(
          onBtnPressed: onBtnPressed,
          childWidget: IdImageBox(
              imagePath: checkBox ? 'assets/img/icon_checkBox_green.png' : 'assets/img/icon_checkBox_none.png',
              imageHeight: 20,
              imageWidth: 20,
              imageFit: BoxFit.cover),
        ),
        const IdSpace(spaceWidth: 16, spaceHeight: 0),
        uiCommon.styledText(text, 18, 0, 1, FontWeight.w400, IdColors.textTertiary, TextAlign.left)
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
                                height: 555,
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
                                                    '안심중개권 서비스 정책', 32, 0, 1.3, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  children: [
                                                    withDottedText('안심중개 신청 매물 : $dealAddress'),
                                                    withDottedText('등록자 : $userOffice $userName'),
                                                    withDottedText('보호기간 : $today ~ $lastDateTime'),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                uiCommon.styledText(
                                                    "안심중개권은 등록된 딜에 대해 보호기간 동안 중개에 대한 권리를 우선 보장해주는 서비스입니다.\n딜스테이션은 안심중개권이 체결된 경우, 보호기간동안 안심중개권을 체결한 자 (이하 '안심중개인') 외의 등록자에게 매수의뢰를 요청하지 않으며, 기타의 방법을 통해 매입을 진행하지 않습니다.\n안심중개권 보호기간은 신청일로부터 6개월 이며, 보호기간 연장을 원하는 경우 연장신청을 통해 연장가능합니다.",
                                                    18,
                                                    0,
                                                    1.6,
                                                    FontWeight.w400,
                                                    IdColors.textDefault,
                                                    TextAlign.left),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    uiCommon.styledText("딜스테이션은 각 항목을 위반한 안심중개인에게 안심중개권의 해지를 통보할 수 있습니다.", 18, 0, 1.6,
                                                        FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                    Column(
                                                      children: List.generate(
                                                          contentList.length,
                                                          (index) => Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 20,
                                                                    child: uiCommon.styledText("${index + 1}.", 18, 0, 1.6, FontWeight.w400,
                                                                        IdColors.textDefault, TextAlign.left),
                                                                  ),
                                                                  Expanded(
                                                                    child: SizedBox(
                                                                      child: uiCommon.styledText(contentList[index], 18, 0, 1.6,
                                                                          FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                                    ),
                                                                  ),
                                                                ],
                                                              )),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                checkWithLabel(
                                                  check1YN,
                                                  '위 내용을 확인하였고, 이상 없음을 확인하였습니다.',
                                                  () {
                                                    if (check1YN) {
                                                      check1YN = false;
                                                    } else {
                                                      check1YN = true;
                                                    }
                                                    setState(() {});
                                                  },
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                                checkWithLabel(
                                                  check2YN,
                                                  '위 항목에 대해 동의하며, 안심중개권을 신청합니다.',
                                                  () {
                                                    if (check2YN) {
                                                      check2YN = false;
                                                    } else {
                                                      check2YN = true;
                                                    }
                                                    setState(() {});
                                                  },
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                                IdDealRegistBottomBtn(
                                                  beforeBtnFunction: () {
                                                    uiCommon.IdMovePage(
                                                        context, GV.pStrg.getHistoryPages()[GV.pStrg.getHistoryPages().length - 2]);
                                                  },
                                                  btn1: '취소',
                                                  afterBtnFunction: () async {
                                                    if (!check1YN || !check2YN) {
                                                      activeToast('내용을 확인 하시고 체크하여 주세요.');
                                                    } else {
                                                      GV.pStrg.putXXX(Param_exclusiveContract, 'yes');
                                                      if (await applyDomi()) {
                                                        uiCommon.IdMovePage(context, PAGE_DEAL_STEP_04_4_PAGE);
                                                      } else {
                                                        print('disable to move page');
                                                      }
                                                    }
                                                  },
                                                  btn2: '다음',
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
                      const IdCommonFooter(),
                    ],
                  ),
                ),
                idCommonHeader(),
                idHeadToastWidget()
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
