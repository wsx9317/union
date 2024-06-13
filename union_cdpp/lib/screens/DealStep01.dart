import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageStep.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/modelVO/myInfoItem.dart';
import 'package:unionCDPP/popup/regularMemberPopup.dart';

class DealStep01 extends StatefulWidget {
  const DealStep01({super.key});

  @override
  IdState<DealStep01> createState() => _DealStep01State();
}

class _DealStep01State extends IdState<DealStep01> {
  // double screenWidth = GV.screen.width;
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  String dealTypeStr = '';
  String dealCategoryStr = '';

  List dealTypeList = ['newConstructionSite', 'building'];
  List dealCategoryList = ['forSale', 'consignmentOperation'];

  bool regularMemberVisible = false;

  MyInfoItem user1 = GV.myInfoItem;
  int userGrade = 0;

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

    if (user1.isNotEmpty()) {
      userGrade = int.tryParse(user1.grade!) ?? 0;
    }

    if (userGrade <= 1) {
      regularMemberVisible = true;
    } else {
      regularMemberVisible = false;
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<bool> setDealNo() async {
    final result = await IdApi.setDealNo();
    if (result == null) return false;
    GV.pStrg.putXXX(Param_newDealNo, result);
    return true;
  }

  Widget inputBtn(Function() onBtnPressed, String bntStatus, List btnStatusList, int listNum, String imgPath, String btnStr) {
    return IdNormalBtn(
      onBtnPressed: onBtnPressed,
      childWidget: Container(
        width: 335.5,
        height: 77,
        decoration: ShapeDecoration(
          color: (bntStatus == btnStatusList[listNum]) ? IdColors.green5 : IdColors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: (bntStatus == btnStatusList[listNum]) ? IdColors.green2 : IdColors.borderDefault,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IdImageBox(imagePath: imgPath, imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
            const IdSpace(spaceWidth: 10, spaceHeight: 0),
            uiCommon.styledText(btnStr, 18, 0, 1, FontWeight.w600,
                (bntStatus == btnStatusList[listNum]) ? IdColors.green2 : IdColors.textSecondly, TextAlign.left),
          ],
        ),
      ),
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
                              height: 360,
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
                                            IdPageStep(stepDesc: stepDesc, pageNumber: 1)
                                          ],
                                        ),
                                        const IdSpace(spaceWidth: 84, spaceHeight: 0),
                                        //입력부분
                                        Container(
                                          width: 807,
                                          height: 784,
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
                                              uiCommon.styledText('<fb2>Step 1.</fb2> 딜의 종류와 유형을 선택해주세요.', 32, 0, 1.3, FontWeight.w700,
                                                  IdColors.textDefault, TextAlign.left),
                                              const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 44,
                                                child: uiCommon.styledText(
                                                    'Deal 종류', 18, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                              ),
                                              Row(
                                                children: [
                                                  inputBtn(
                                                    () {
                                                      dealTypeStr = dealTypeList[0];
                                                      setState(() {});
                                                    },
                                                    dealTypeStr,
                                                    dealTypeList,
                                                    0,
                                                    'assets/img/icon_mydeal_01.png',
                                                    '신축부지',
                                                  ),
                                                  const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                  inputBtn(
                                                    () {
                                                      dealTypeStr = dealTypeList[1];
                                                      setState(() {});
                                                    },
                                                    dealTypeStr,
                                                    dealTypeList,
                                                    1,
                                                    'assets/img/icon_mydeal_02.png',
                                                    '건물',
                                                  ),
                                                ],
                                              ),
                                              const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 44,
                                                child: uiCommon.styledText(
                                                    'Deal 유형', 18, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                              ),
                                              Row(
                                                children: [
                                                  inputBtn(
                                                    () {
                                                      dealCategoryStr = dealCategoryList[0];
                                                      setState(() {});
                                                    },
                                                    dealCategoryStr,
                                                    dealCategoryList,
                                                    0,
                                                    'assets/img/icon_mydeal_03.png',
                                                    '매각',
                                                  ),
                                                  const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                  inputBtn(
                                                    () {
                                                      dealCategoryStr = dealCategoryList[1];
                                                      setState(() {});
                                                    },
                                                    dealCategoryStr,
                                                    dealCategoryList,
                                                    1,
                                                    'assets/img/icon_mydeal_04.png',
                                                    '위탁운영',
                                                  ),
                                                ],
                                              ),
                                              const IdSpace(spaceWidth: 0, spaceHeight: 233),
                                              IdNormalBtn(
                                                onBtnPressed: () async {
                                                  GV.pStrg.putXXX(Param_dealType, dealTypeStr);
                                                  GV.pStrg.putXXX(Param_dealCategory, dealCategoryStr);
                                                  GV.pStrg.putXXX('dealMasterJson', '');
                                                  GV.pStrg.putXXX('dealNewBuildingJson', '');
                                                  GV.pStrg.putXXX('dealLotJson', '');
                                                  GV.pStrg.putXXX('dealBuildingJson', '');
                                                  GV.pStrg.putXXX('dealRentRollJson', '');
                                                  GV.pStrg.putXXX(Param_rentRollRegist, '렌트롤등록');

                                                  setState(() {});
                                                  if (dealTypeStr != '' && dealCategoryStr != '') {
                                                    if (await setDealNo()) {
                                                      if (dealTypeStr == dealTypeList[0]) {
                                                        uiCommon.IdMovePage(context, PAGE_DEAL_STEP_02_1_PAGE);
                                                      } else {
                                                        uiCommon.IdMovePage(context, PAGE_DEAL_STEP_02_2_PAGE);
                                                      }
                                                    } else {
                                                      print('Fail set Deal NO');
                                                    }
                                                  } else {
                                                    print('disable move page');
                                                  }
                                                },
                                                childWidget: Container(
                                                  width: double.infinity,
                                                  height: 57,
                                                  decoration: ShapeDecoration(
                                                    color: IdColors.green2,
                                                    shape: RoundedRectangleBorder(
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: uiCommon.styledText(
                                                        '다음', 18, 0, 1, FontWeight.w700, IdColors.white, TextAlign.left),
                                                  ),
                                                ),
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
                        ),
                      ],
                    ),
                    idCommonFooter(),
                  ],
                ),
              ),
              //헤더
              idCommonHeader(),
              Visibility(
                visible: regularMemberVisible,
                child: Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    color: IdColors.white,
                    child: Container(
                      color: IdColors.black40Per,
                      child: Center(
                        child: RegularmemberPopup(
                          backPageFunction: () {
                            uiCommon.IdMovePage(context, GV.pStrg.getHistoryPages()[GV.pStrg.getHistoryPages().length - 2]);
                            setState(() {});
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        )));
  }
}
