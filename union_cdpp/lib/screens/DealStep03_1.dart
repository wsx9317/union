import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDealRegistBottomBtn.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageStep.dart';
import 'package:unionCDPP/id_widget/IdRadio.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/modelVO/dealLandItem.dart';
import 'package:unionCDPP/modelVO/dealLotItem.dart';
import 'package:unionCDPP/modelVO/dealMasterItem.dart';
import 'package:unionCDPP/modelVO/dealNewBuildingItem.dart';

class DealStep03_1 extends StatefulWidget {
  const DealStep03_1({super.key});

  @override
  IdState<DealStep03_1> createState() => _DealStep03_1State();
}

class _DealStep03_1State extends IdState<DealStep03_1> {
  DealMasterItem? dealMasterItem;
  DealNewBuildingItem? dealNewBuildingItem;
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  String pnu = '';
  String dealType = '';
  String dealCategory = '';
  String register = '';
  String registerEtc = '';
  String address = '';
  String addressDtl = '';
  String areaPos = '';

  List<DealLotItem> dealLotItems = [];

  int negotiateINT = 0;
  int assetINT = 0;
  int ownerINT = 0;

  DealLandItem? dealLandItem;
  var dealLandItem2;

  List<String> negotiateList = ['가능', '불가능', '추후협의'];
  List<String> assetList = ['명도예정/명도중', '공실', '나대지', '인허가/착공'];
  List<String> ownerList = ['개인/법인', '시행사', '브릿지/PF'];

  bool negotiateBool = false;

  TextEditingController _wonderPriceController = TextEditingController(); //희망가격가
  TextEditingController _dispossessController = TextEditingController(); //명도기간
  TextEditingController _subwayController = TextEditingController(); //지하철
  TextEditingController _distanceController = TextEditingController(); //거리
  //자산규모 데이터
  TextEditingController _building1Controller = TextEditingController(); //용도
  TextEditingController _building2Controller = TextEditingController(); //용적률
  TextEditingController _building3Controller = TextEditingController(); //건폐율
  TextEditingController _building4Controller = TextEditingController(); //건축면적
  TextEditingController _building5Controller = TextEditingController(); //연면적
  TextEditingController _building6Controller = TextEditingController(); //지상연면적
  TextEditingController _building7Controller = TextEditingController(); //지상
  TextEditingController _building8Controller = TextEditingController(); //지하
  TextEditingController _building9Controller = TextEditingController(); //주차대수
  TextEditingController _building10Controller = TextEditingController(); //승강기
  TextEditingController _building11Controller = TextEditingController(); //기타

  @override
  void initState() {
    super.initState();
    dealMasterItem = DealMasterItem();
    dealNewBuildingItem = DealNewBuildingItem();
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

    String dealMasterItemStr = GV.pStrg.getXXX('dealMasterJson');
    String dealNewBuildingItemStr = GV.pStrg.getXXX('dealNewBuildingJson');

    if (dealMasterItemStr != '') {
      dealMasterItem = DealMasterItem.fromJson(jsonDecode(dealMasterItemStr));
      dealType = dealMasterItem!.type!;
      dealCategory = dealMasterItem!.category!;
      register = dealMasterItem!.register!;
      registerEtc = dealMasterItem!.registerEtc!;
      address = dealMasterItem!.address!;
      addressDtl = dealMasterItem!.addressDtl!;
      areaPos = dealMasterItem!.areaPos!;
      _subwayController.text = dealMasterItem!.stationName!;
      _distanceController.text = dealMasterItem!.stationDistance!;
      if (dealMasterItem!.asking != null) {
        _wonderPriceController.text = NumberFormat('#,##0.00').format((double.tryParse(dealMasterItem!.asking!) ?? 0) / 100000000);
      }
      if (dealMasterItem!.negotiationType != null) {
        negotiateINT = int.tryParse(dealMasterItem!.negotiationType!) ?? 1;
      }
      if (dealMasterItem!.assetStatus != null) {
        assetINT = int.tryParse(dealMasterItem!.assetStatus!) ?? 1;
      }
      if (dealMasterItem!.owner != null) {
        ownerINT = int.tryParse(dealMasterItem!.owner!) ?? 1;
      }
      if (dealMasterItem!.evacuationPeriod != null) {
        if (dealMasterItem!.evacuationPeriod == '0') {
          _dispossessController.text = '';
        } else {
          _dispossessController.text = dealMasterItem!.evacuationPeriod!;
        }
      }
      if (dealMasterItem!.evacuationChk == 'Y') {
        negotiateBool = true;
      } else {
        negotiateBool = false;
      }
    }

    if (dealNewBuildingItemStr != '') {
      dealNewBuildingItem = DealNewBuildingItem.fromJson(jsonDecode(dealNewBuildingItemStr));
      _building1Controller.text = dealNewBuildingItem!.landUsage!;
      _building2Controller.text = dealNewBuildingItem!.totalFloorRatio!;
      _building3Controller.text = dealNewBuildingItem!.buildingCoverage!;
      _building4Controller.text = dealNewBuildingItem!.buildingArea!;
      _building5Controller.text = dealNewBuildingItem!.totalFloorArea!;
      _building6Controller.text = dealNewBuildingItem!.upperFloorArea!;
      _building7Controller.text = dealNewBuildingItem!.upperNum!;
      _building8Controller.text = dealNewBuildingItem!.lowerNum!;
      _building9Controller.text = dealNewBuildingItem!.parkingNum!;
      _building10Controller.text = dealNewBuildingItem!.elevator!;
      _building11Controller.text = dealNewBuildingItem!.etc!;
    }

    setState(() {});
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() {});
  }

  Widget titleWidget(String title) {
    return SizedBox(
      height: 44,
      child: uiCommon.styledText(title, 18, 0, 1.6, FontWeight.w700, IdColors.textDefault, TextAlign.left),
    );
  }

  Widget titleWidget2(String title) {
    return Container(
      width: double.infinity,
      height: 44,
      decoration: BoxDecoration(
          color: IdColors.green5,
          border: Border(
            right: BorderSide(width: 1, color: IdColors.borderDefault),
            bottom: BorderSide(width: 1, color: IdColors.borderDefault),
          )),
      child: Center(child: uiCommon.styledText(title, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left)),
    );
  }

  Widget radioWithLable(
    bool checkBool,
    Color radioColor,
    String lable,
    Color lableColor,
    bool enable,
  ) {
    return Row(
      children: [
        IdRadio(
          onBtnPressed: null,
          checkBool: checkBool,
          radioColor: radioColor,
          enabled: enable,
        ),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        uiCommon.styledText(lable, 18, 0, 1, FontWeight.w600, lableColor, TextAlign.left)
      ],
    );
  }

  Widget radioWithLable2(Function() onBntPressed, bool checkBool, Color radioColor, String lable, Color lableColor, bool enable) {
    return Row(
      children: [
        Row(
          children: [
            IdRadio(
              onBtnPressed: onBntPressed,
              checkBool: checkBool,
              radioColor: radioColor,
              enabled: enable,
            ),
            const IdSpace(spaceWidth: 8, spaceHeight: 0),
            uiCommon.styledText(lable, 18, 0, 1, FontWeight.w600, lableColor, TextAlign.left)
          ],
        ),
        const IdSpace(spaceWidth: 32, spaceHeight: 0),
      ],
    );
  }

  Widget addressInput(String hint, TextEditingController controller) {
    return IdInputValidation(
        width: 196.33,
        height: 44,
        inputColor: IdColors.backgroundDefault,
        round: 8,
        controller: controller,
        textAlign: 'start',
        hintText: hint,
        hintTextFontSize: 16,
        hintTextfontWeight: FontWeight.w500,
        hintTextFontColor: IdColors.textTertiary,
        keyboardType: 'text',
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: false);
  }

  Widget textInputWidget(double width, String hint, TextEditingController controller, String keyboardType, bool enabledBool) {
    return IdInputValidation(
        width: width,
        height: 44,
        inputColor: IdColors.backgroundDefault,
        round: 8,
        textAlign: 'start',
        controller: controller,
        hintText: hint,
        hintTextFontSize: 16,
        hintTextfontWeight: FontWeight.w400,
        hintTextFontColor: IdColors.textTertiary,
        keyboardType: keyboardType,
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: enabledBool);
  }

  Widget textInputWidget2(double width, String hint, TextEditingController controller, String keyboardType) {
    return Expanded(
      child: IdInputValidation(
          width: width,
          height: 44,
          inputColor: IdColors.backgroundDefault,
          round: 8,
          textAlign: 'start',
          controller: controller,
          hintText: hint,
          hintTextFontSize: 16,
          hintTextfontWeight: FontWeight.w400,
          hintTextFontColor: IdColors.textTertiary,
          keyboardType: keyboardType,
          validationText: '',
          validationVisible: false,
          vlaidationCheck: false,
          enabledBool: true),
    );
  }

  Widget inputWithLable(String title, String hint, TextEditingController controller, String keyBoardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(title),
        textInputWidget(double.infinity, hint, controller, keyBoardType, true),
      ],
    );
  }

  Widget inputWithLable2(String title, String hint, TextEditingController controller, String keyBoardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget2(title),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: IdColors.borderDefault),
              bottom: BorderSide(width: 1, color: IdColors.borderDefault),
            ),
          ),
          child: textInputWidget(double.infinity, hint, controller, keyBoardType, true),
        ),
      ],
    );
  }

  Widget inputWithLable3(
      String title, String hint, TextEditingController controller1, TextEditingController controller2, String keyBoardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget2(title),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: IdColors.borderDefault),
              bottom: BorderSide(width: 1, color: IdColors.borderDefault),
            ),
          ),
          child: Row(
            children: [
              textInputWidget2(double.infinity, hint, controller1, keyBoardType),
              SizedBox(
                width: 15,
                child: uiCommon.styledText('/', 16, 0, 1, FontWeight.w400, IdColors.textDefault, TextAlign.center),
              ),
              textInputWidget2(double.infinity, hint, controller2, keyBoardType),
            ],
          ),
        ),
      ],
    );
  }

  Widget inputWithLable4(String title, String hint, TextEditingController controller, String keyBoardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget2(title),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: const BoxDecoration(
            border: Border(
              right: BorderSide(width: 1, color: IdColors.borderDefault),
              bottom: BorderSide(width: 1, color: IdColors.borderDefault),
            ),
          ),
          child: Container(
            width: double.infinity,
            height: 120,
            decoration: BoxDecoration(
              color: IdColors.backgroundDefault,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: controller,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> dataToJson() async {
    //딜마스터
    dealMasterItem!.asking = ((double.tryParse(_wonderPriceController.text.replaceAll(',', '')) ?? 0) * 100000000).toString();
    dealMasterItem!.negotiationType = negotiateINT.toString();
    dealMasterItem!.assetStatus = assetINT.toString();
    dealMasterItem!.evacuationType = '0';
    if (_dispossessController.text == '') {
      dealMasterItem!.evacuationPeriod = '0';
    } else {
      dealMasterItem!.evacuationPeriod = _dispossessController.text;
    }
    if (negotiateBool) {
      dealMasterItem!.evacuationChk = "Y";
    } else {
      dealMasterItem!.evacuationChk = "N";
    }
    dealMasterItem!.owner = ownerINT.toString();
    dealMasterItem!.stationName = _subwayController.text;
    dealMasterItem!.stationDistance = _distanceController.text;

    //신부지내용;

    dealNewBuildingItem!.landUsage = _building1Controller.text;
    if (_building2Controller.text == '') {
      dealNewBuildingItem!.totalFloorRatio = '0';
    } else {
      dealNewBuildingItem!.totalFloorRatio = _building2Controller.text;
    }
    if (_building3Controller.text == '') {
      dealNewBuildingItem!.buildingCoverage = '0';
    } else {
      dealNewBuildingItem!.buildingCoverage = _building3Controller.text;
    }
    if (_building4Controller.text == '') {
      dealNewBuildingItem!.buildingArea = '0';
    } else {
      dealNewBuildingItem!.buildingArea = _building4Controller.text;
    }
    if (_building5Controller.text == '') {
      dealNewBuildingItem!.totalFloorArea = '0';
    } else {
      dealNewBuildingItem!.totalFloorArea = _building5Controller.text;
    }
    if (_building6Controller.text == '') {
      dealNewBuildingItem!.upperFloorArea = '0';
    } else {
      dealNewBuildingItem!.upperFloorArea = _building6Controller.text;
    }
    if (_building7Controller.text == '') {
      dealNewBuildingItem!.upperNum = '0';
    } else {
      dealNewBuildingItem!.upperNum = _building7Controller.text;
    }
    if (_building8Controller.text == '') {
      dealNewBuildingItem!.lowerNum = '0';
    } else {
      dealNewBuildingItem!.lowerNum = _building8Controller.text;
    }
    if (_building9Controller.text == '') {
      dealNewBuildingItem!.parkingNum = '0';
    } else {
      dealNewBuildingItem!.parkingNum = _building9Controller.text;
    }
    if (_building10Controller.text == '') {
      dealNewBuildingItem!.elevator = '0';
    } else {
      dealNewBuildingItem!.elevator = _building10Controller.text;
    }
    dealNewBuildingItem!.etc = _building11Controller.text;
    //TODO 소유자 이게 맞는지 확인이 필요
    dealNewBuildingItem!.owner = ownerINT.toString();
    dealNewBuildingItem!.lowerFloorArea = '0';

    GV.pStrg.putXXX('dealMasterJson', jsonEncode(dealMasterItem!.toJson()));
    GV.pStrg.putXXX('dealNewBuildingJson', jsonEncode(dealNewBuildingItem!.toJson()));

    // print(GV.pStrg.getXXX('dealMasterJson'));
    // print(GV.pStrg.getXXX('dealNewBuildingJson'));
    // print(GV.pStrg.getXXX('dealLotJson'));

    uiCommon.IdMovePage(context, PAGE_DEAL_STEP_04_1_PAGE);
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
                                height: 1221,
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
                                              IdPageStep(stepDesc: stepDesc, pageNumber: 3)
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
                                                uiCommon.styledText('<fb2>Step 3.</fb2> 제안할 부동산의 거래 정보를 입력하세요.', 32, 0, 1.3,
                                                    FontWeight.w700, IdColors.textDefault, TextAlign.left),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Stack(
                                                  children: [
                                                    const SizedBox(
                                                      width: double.infinity,
                                                      height: 44,
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      left: 0,
                                                      child: Row(
                                                        children: [
                                                          uiCommon.styledText(
                                                              'Deal 종류', 18, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealType == "L")
                                                              ? radioWithLable(true, IdColors.green2, '신축부지', IdColors.textDefault, false)
                                                              : radioWithLable(false, IdColors.green2, '신축부지', IdColors.textDisabled, true),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealType == "B")
                                                              ? radioWithLable(true, IdColors.green2, '건물', IdColors.textDefault, false)
                                                              : radioWithLable(false, IdColors.green2, '건물', IdColors.textDisabled, true),
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      top: 0,
                                                      right: 0,
                                                      child: Row(
                                                        children: [
                                                          uiCommon.styledText(
                                                              'Deal 유형', 18, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealCategory == "1")
                                                              ? radioWithLable(true, IdColors.green2, '매각', IdColors.textDefault, false)
                                                              : radioWithLable(false, IdColors.green2, '매각', IdColors.textDisabled, true),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealCategory == "2")
                                                              ? radioWithLable(true, IdColors.green2, '위탁운영', IdColors.textDefault, false)
                                                              : radioWithLable(false, IdColors.green2, '위탁운영', IdColors.textDisabled, true),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
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
                                                Row(
                                                  children: [
                                                    Expanded(
                                                        child: inputWithLable(
                                                            '<fb2>*</fb2> 희망매각가<unit>(억원)</unit>', '', _wonderPriceController, 'number')),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          titleWidget('<fb2>*</fb2> 가격협의'),
                                                          SizedBox(
                                                            width: double.infinity,
                                                            height: 44,
                                                            child: Row(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: List.generate(
                                                                  negotiateList.length,
                                                                  (index) => radioWithLable2(() {
                                                                    negotiateINT = index + 1;
                                                                    setState(() {});
                                                                  }, (negotiateINT == index + 1) ? true : false, IdColors.green2,
                                                                      negotiateList[index], IdColors.textDefault, true),
                                                                )),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('<fb2>*</fb2> 자산현황'),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 44,
                                                      child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: List.generate(
                                                            assetList.length,
                                                            (index) => radioWithLable2(() {
                                                              assetINT = index + 1;
                                                              setState(() {});
                                                            }, (assetINT == index + 1) ? true : false, IdColors.green2, assetList[index],
                                                                IdColors.textDefault, true),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('예상명도기간<unit>(개월)</unit>'),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: textInputWidget(double.infinity, '', _dispossessController, 'text',
                                                                negotiateBool ? false : true)),
                                                        const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                        Row(
                                                          children: [
                                                            IdNormalBtn(
                                                              onBtnPressed: () {
                                                                //
                                                                if (negotiateBool) {
                                                                  negotiateBool = false;
                                                                } else {
                                                                  negotiateBool = true;
                                                                }
                                                                setState(() {});
                                                              },
                                                              childWidget: IdImageBox(
                                                                  imagePath: negotiateBool
                                                                      ? 'assets/img/icon_checkBox_checked.png'
                                                                      : 'assets/img/icon_checkBox_none.png',
                                                                  imageWidth: 20,
                                                                  imageHeight: 20,
                                                                  imageFit: BoxFit.contain),
                                                            ),
                                                            const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                '협의', 18, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left)
                                                          ],
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('<fb2>*</fb2> 소유자'),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 44,
                                                      child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: List.generate(
                                                            ownerList.length,
                                                            (index) => radioWithLable2(() {
                                                              ownerINT = index + 1;
                                                              setState(() {});
                                                            }, (ownerINT == index + 1) ? true : false, IdColors.green2, ownerList[index],
                                                                IdColors.textDefault, true),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('<fb2>*</fb2> 인근 지하철/거리'),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: textInputWidget(double.infinity, '', _subwayController, 'text', true),
                                                        ),
                                                        SizedBox(
                                                          width: 15,
                                                          height: 44,
                                                          child: Center(
                                                            child: uiCommon.styledText(
                                                                '/', 18, 0, 1, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          child: textInputWidget(double.infinity, '', _distanceController, 'text', true),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                titleWidget('신축예상규모<unit>(인허가/착공)</unit>'),
                                                Container(
                                                  width: double.infinity,
                                                  decoration: BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(width: 1, color: IdColors.borderDefault),
                                                      left: BorderSide(width: 1, color: IdColors.borderDefault),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      //첫번째
                                                      Row(
                                                        children: [
                                                          Expanded(child: inputWithLable2('용도', '', _building1Controller, 'text')),
                                                          Expanded(child: inputWithLable2('용적률', '', _building2Controller, 'number')),
                                                          Expanded(child: inputWithLable2('건폐율', '', _building3Controller, 'number')),
                                                        ],
                                                      ),
                                                      //두번째
                                                      Row(
                                                        children: [
                                                          Expanded(child: inputWithLable2('건축면적', '', _building4Controller, 'number')),
                                                          Expanded(child: inputWithLable2('연면적', '', _building5Controller, 'number')),
                                                          Expanded(child: inputWithLable2('지상연면적', '', _building6Controller, 'number')),
                                                        ],
                                                      ),
                                                      //세번째
                                                      Row(
                                                        children: [
                                                          Expanded(
                                                              child: inputWithLable3(
                                                                  '지상/지하', '', _building7Controller, _building8Controller, 'number')),
                                                          Expanded(child: inputWithLable2('주차대수', '', _building9Controller, 'number')),
                                                          Expanded(child: inputWithLable2('승강기', '', _building10Controller, 'number')),
                                                        ],
                                                      ),
                                                      //네번째
                                                      Row(
                                                        children: [
                                                          Expanded(child: inputWithLable4('기타', '', _building11Controller, 'text')),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                                IdDealRegistBottomBtn(
                                                  beforeBtnFunction: () {
                                                    uiCommon.IdMovePage(context, PAGE_DEAL_STEP_02_1_PAGE);
                                                  },
                                                  btn1: '이전',
                                                  afterBtnFunction: () {
                                                    if (_wonderPriceController.text == '') {
                                                      activeToast('희망가격을 입력해주세요.');
                                                    } else {
                                                      if (negotiateINT == 0) {
                                                        activeToast('가격협의를 선택해주세요.');
                                                      } else {
                                                        if (assetINT == 0) {
                                                          activeToast('자산현황을 선택해주세요.');
                                                        } else {
                                                          if (ownerINT == 0) {
                                                            activeToast('소유자를 선택해주세요.');
                                                          } else {
                                                            dataToJson();
                                                          }
                                                        }
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
                      idCommonFooter(),
                    ],
                  ),
                ),
                idCommonHeader(),
                idHeadToastWidget(),
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
