import 'dart:convert';

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDealRegistBottomBtn.dart';
import 'package:unionCDPP/id_widget/IdDottedBorderContainer.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageStep.dart';
import 'package:unionCDPP/id_widget/IdRadio.dart';
import 'package:unionCDPP/id_widget/IdRentRollBoard.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/modelVO/dealBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealMasterItem.dart';
import 'package:unionCDPP/modelVO/dealRentRollItem.dart';
import 'package:unionCDPP/modelVO/dealRentRollResponse.dart';

class DealStep03_2 extends StatefulWidget {
  const DealStep03_2({super.key});

  @override
  IdState<DealStep03_2> createState() => _DealStep03_2State();
}

class _DealStep03_2State extends IdState<DealStep03_2> {
  DealMasterItem? dealMasterItem;
  DealBuildingItem? dealBuildingItem;
  DealRentRollResponse? dealRentRollResponse;
  List<DealRentRollItem> dealRentRollItems = [];
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  String dealNo = GV.pStrg.getXXX(Param_newDealNo);
  String userNo = GV.pStrg.getXXX(Param_commonUserNo);
  String pnu = '';
  String dealType = '';
  String dealCategory = '';
  String register = '';
  String registerEtc = '';
  String address = '';
  String addressDtl = '';
  String areaPos = '';
  String totalFloorRatio = '';
  String bdCoverageRatio = '';
  String lowerNum = '';
  String upperNum = '';
  String elevator = '';
  String parkingNum = '';

  String bdUniqueId = '';
  String buildingName = '';
  String lotArea = '';
  String loan = '';
  String areaPurpose = '';
  String mainPurpose = '';
  String mainStruct = '';
  String ccd = '';
  String officialLandPrice = '';
  String totalLandPrice = '';
  String bdDistrictUnitPlan = '';

  int negotiateINT = 0;
  int dispossessINT = 0;
  int registrationINT = 1;
  int reModel = 0;

  int rentRollBoardCnt = 1;

  List<String> negotiateList = ['가능', '불가능', '협의'];
  List<String> dispossessList = ['전층책임명도', '일부책임명도', '불가능', '협의'];
  List<String> registrationList = ['등록', '미등록'];

  bool evacuationCk = false;
  bool depositChk = false;
  bool monthlyChk = false;

  String dropDownValue = '';

  bool inputListActive = false;

  var _focusDropDown = FocusNode();
  bool changeDropdown = false;
  List<DropdownMenuItem> _items = [];

  List<IdRentRollBoard> rentRolls = [IdRentRollBoard(text1: '', text2: '', text3: '', text4: '', text5: '', text6: '')];
  List rentRollsList = [];

  TextEditingController _wonderPriceController = TextEditingController(); //희망가격가
  TextEditingController _dispossessController = TextEditingController(); //명도기간
  TextEditingController _depositeController = TextEditingController(); //보증금
  TextEditingController _monthlyRentController = TextEditingController(); //월세
  TextEditingController _roomCntController = TextEditingController(); //객실
  TextEditingController _remodelingController = TextEditingController(); //리모델링
  TextEditingController _subwayController = TextEditingController(); //지하철
  TextEditingController _distanceController = TextEditingController(); //거리

  // Map<String, TextEditingController> _controllers = {};

  @override
  void initState() {
    super.initState();
    dealMasterItem = DealMasterItem();
    dealBuildingItem = DealBuildingItem();
    dealRentRollResponse = DealRentRollResponse();
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

    itemList();
    String dealMasterItemStr = GV.pStrg.getXXX('dealMasterJson');
    dealMasterItem = DealMasterItem.fromJson(jsonDecode(dealMasterItemStr));
    String dealBuildItemStr = GV.pStrg.getXXX('dealBuildingJson');
    dealBuildingItem = DealBuildingItem.fromJson(jsonDecode(dealBuildItemStr));
    String dealRentRollStr = GV.pStrg.getXXX('dealRentRollJson');
    String rentRollRegistCheck = GV.pStrg.getXXX(Param_rentRollRegist);

    if (dealMasterItem != null && dealBuildingItem != null) {
      // //dealmaster
      pnu = dealMasterItem!.pnu!;
      dealType = dealMasterItem!.type!;
      dealCategory = dealMasterItem!.category!;
      register = dealMasterItem!.register!;
      registerEtc = dealMasterItem!.registerEtc!;
      address = dealMasterItem!.address!;
      addressDtl = dealMasterItem!.addressDtl!;
      areaPos = dealMasterItem!.areaPos!;
      //building
      bdUniqueId = dealBuildingItem!.bdUniqueId!;
      buildingName = dealBuildingItem!.buildingName!;
      lotArea = dealBuildingItem!.lotArea!;
      areaPurpose = dealBuildingItem!.areaPurpose!;
      totalFloorRatio = dealBuildingItem!.totalFloorRatio!;
      bdCoverageRatio = dealBuildingItem!.bdCoverageRatio!;
      mainPurpose = dealBuildingItem!.mainPurpose!;
      mainStruct = dealBuildingItem!.mainStruct!;
      ccd = dealBuildingItem!.ccd!;
      bdDistrictUnitPlan = dealBuildingItem!.bdDistrictUnitPlan!;
      lowerNum = dealBuildingItem!.lowerNum!;
      upperNum = dealBuildingItem!.upperNum!;
      elevator = dealBuildingItem!.elevator!;
      parkingNum = dealBuildingItem!.parkingNum!;
      officialLandPrice = dealBuildingItem!.officialLandPrice!;
      totalLandPrice = dealBuildingItem!.totalLandPrice!;
      _subwayController.text = dealMasterItem!.stationName!;
      _distanceController.text = dealMasterItem!.stationDistance!;

      //희망가격
      if (dealMasterItem!.asking != null) {
        _wonderPriceController.text = ((double.tryParse(dealMasterItem!.asking!) ?? 0) / 100000000).toString();
      } else {
        _wonderPriceController.text = '';
      }
      //가격협의
      if (dealMasterItem!.negotiationType == '1') {
        negotiateINT = 1;
      } else if (dealMasterItem!.negotiationType == '2') {
        negotiateINT = 2;
      } else if (dealMasterItem!.negotiationType == '3') {
        negotiateINT = 3;
      } else {
        negotiateINT = 0;
      }
      //명도
      if (dealMasterItem!.evacuationType == '1') {
        dispossessINT = 1;
      } else if (dealMasterItem!.evacuationType == '2') {
        dispossessINT = 2;
      } else if (dealMasterItem!.evacuationType == '3') {
        dispossessINT = 3;
      } else if (dealMasterItem!.evacuationType == '4') {
        dispossessINT = 4;
      } else {
        dispossessINT = 0;
      }
      //명도 기간
      if (dealMasterItem!.evacuationPeriod != null) {
        _dispossessController.text = dealMasterItem!.evacuationPeriod!;
      } else {
        _dispossessController.text = '';
      }
      //명도 기간 협의 체크
      if (dealMasterItem!.evacuationChk == 'Y') {
        evacuationCk == true;
      } else {
        evacuationCk == false;
      }
      //보증금
      if (dealBuildingItem!.deposit != null) {
        _depositeController.text = ((double.tryParse(dealBuildingItem!.deposit!) ?? 0) / 10000).toString();
      } else {
        _depositeController.text = '';
      }
      //보증금 체크
      if (dealBuildingItem!.depositChk == 'Y') {
        depositChk = true;
      } else {
        depositChk = false;
      }
      //월세
      if (dealBuildingItem!.monthly != null) {
        _monthlyRentController.text = ((double.tryParse(dealBuildingItem!.monthly!) ?? 0) / 10000).toString();
      } else {
        _monthlyRentController.text = '';
      }
      //월세 체크
      if (dealBuildingItem!.monthlyChk == 'Y') {
        monthlyChk = true;
      } else {
        monthlyChk = false;
      }

      //TODO 융자부분은 추후에 작업
      if (dealBuildingItem!.loan != null) {
        loan = dealBuildingItem!.loan!;
      } else {
        loan = '';
      }

      //객실수
      if (dealBuildingItem!.roomNum != null) {
        _roomCntController.text = dealBuildingItem!.roomNum!;
      } else {
        _roomCntController.text = '';
      }
      //리모델링 체크
      if (dealBuildingItem!.reModel != null) {
        if (dealBuildingItem!.reModel == '-1') {
          reModel = 2;
          _remodelingController.text = '';
        } else if (dealBuildingItem!.reModel == '0') {
          reModel = 3;
          _remodelingController.text = '';
        } else {
          reModel = 1;
          _remodelingController.text = dealBuildingItem!.reModel!;
        }
      } else {
        reModel = 0;
        _remodelingController.text = '';
      }
    }
    //렌트 롤

    if (dealRentRollStr != '') {
      dealRentRollResponse = DealRentRollResponse.fromJson(jsonDecode(dealRentRollStr));

      if (dealRentRollResponse != null) {
        print(dealRentRollResponse);
        // rentRollBoardCnt = dealBuildingItem!.rentrollList!.length;
        rentRolls = [];
        for (var i = 0; i < dealRentRollResponse!.rentrollList!.length; i++) {
          rentRollsList.add(
            [
              dealRentRollResponse!.rentrollList![i].floor,
              dealRentRollResponse!.rentrollList![i].sectors,
              dealRentRollResponse!.rentrollList![i].area,
              ((double.tryParse(dealRentRollResponse!.rentrollList![i].deposit!) ?? 0) / 10000).toString(),
              ((double.tryParse(dealRentRollResponse!.rentrollList![i].rent!) ?? 0) / 10000).toString(),
              dealRentRollResponse!.rentrollList![i].etc
            ],
          );

          rentRolls.add(IdRentRollBoard(
            text1: '',
            text2: '',
            text3: '',
            text4: '',
            text5: '',
            text6: '',
          ));
          rentRolls[i] = IdRentRollBoard(
              text1: dealRentRollResponse!.rentrollList![i].floor!,
              text2: dealRentRollResponse!.rentrollList![i].sectors!,
              text3: dealRentRollResponse!.rentrollList![i].area!,
              text4: ((double.tryParse(dealRentRollResponse!.rentrollList![i].deposit!) ?? 0) / 10000).toString(),
              text5: ((double.tryParse(dealRentRollResponse!.rentrollList![i].rent!) ?? 0) / 10000).toString(),
              text6: dealRentRollResponse!.rentrollList![i].etc!);
        }
        rentRollBoardCnt = dealRentRollResponse!.rentrollList!.length;
      } else {
        rentRollBoardCnt = 1;
      }
    }

    if (rentRollRegistCheck == '2') {
      registrationINT = 2;
    } else {
      registrationINT = 1;
    }
  }

  @override
  void dispose() {
    _dispossessController.dispose();
    _depositeController.dispose();
    _monthlyRentController.dispose();
    _remodelingController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    setState(() {});
  }

  void itemList() {
    _items = [
      const DropdownMenuItem(
        value: 'Y',
        child: Text('있음', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'N',
        child: Text('없음', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
  }

  Widget titleWidget(String title) {
    return SizedBox(
      height: 44,
      child: uiCommon.styledText(title, 18, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
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

  Widget textInputWidget(double width, String hint, TextEditingController controller, bool enabledBool, String keyboarType) {
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
        keyboardType: keyboarType,
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: enabledBool);
  }

  Widget inputWithLable(String title, String hint, TextEditingController controller, bool enabledBool, String keyboardType) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(title),
        textInputWidget(double.infinity, hint, controller, enabledBool, keyboardType),
      ],
    );
  }

  Widget dropDown1(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown) {
    return Container(
      width: double.infinity,
      height: 44,
      padding: EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: IdColors.borderDefault,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonFormField2(
        decoration: const InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
        focusNode: focusDropDown,
        enableFeedback: false,
        isExpanded: true,
        hint: uiCommon.styledText(hint, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
        items: items,
        onChanged: (value) {
          loan = value;
          setState(() {});
          focusDropDown.unfocus();
        },
        onSaved: (value) {},
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Icon(
              changeDropdown ? Icons.expand_less : Icons.expand_more,
              color: IdColors.textDefault,
            ),
          ),
          iconSize: 20,
        ),
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(0, -14),
          decoration: BoxDecoration(
            border: Border.all(color: IdColors.white, width: 0.9),
            borderRadius: BorderRadius.circular(4.0),
            color: IdColors.white,
          ),
        ),
        selectedItemBuilder: (context) {
          return items.map((item) {
            String t1 = (item.child as Text).data!;

            return Container(child: uiCommon.styledText(t1, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left));
          }).toList();
        },
      ),
    );
  }

  double addHight() {
    double result = 0;
    if (rentRollBoardCnt <= 1) {
      result = 0;
    } else {
      for (var i = 1; i < rentRollBoardCnt; i++) {
        result = result + 232;
      }
    }
    return result;
  }

  Future<void> dataToJson() async {
    //딜마스터
    dealMasterItem!.pnu = pnu;
    dealMasterItem!.type = dealType;
    dealMasterItem!.category = dealCategory;
    dealMasterItem!.register = register;
    dealMasterItem!.registerEtc = registerEtc;
    dealMasterItem!.address = address;
    dealMasterItem!.addressDtl = addressDtl;
    dealMasterItem!.areaPos = areaPos;
    dealMasterItem!.stationName = _subwayController.text;
    dealMasterItem!.stationDistance = _distanceController.text;
    //건물
    dealBuildingItem!.totalFloorRatio = totalFloorRatio;
    dealBuildingItem!.lowerNum = lowerNum;
    dealBuildingItem!.upperNum = upperNum;
    dealBuildingItem!.bdUniqueId = bdUniqueId;
    dealBuildingItem!.buildingName = buildingName;
    dealBuildingItem!.lotArea = lotArea;
    dealBuildingItem!.bdCoverageRatio = bdCoverageRatio;
    dealBuildingItem!.areaPurpose = areaPurpose;
    dealBuildingItem!.mainPurpose = mainPurpose;
    dealBuildingItem!.mainStruct = mainStruct;
    dealBuildingItem!.ccd = ccd;
    dealBuildingItem!.bdDistrictUnitPlan = bdDistrictUnitPlan;
    dealBuildingItem!.elevator = elevator;
    dealBuildingItem!.parkingNum = parkingNum;
    dealBuildingItem!.bdUniqueId = bdUniqueId;
    dealBuildingItem!.officialLandPrice = officialLandPrice;
    dealBuildingItem!.totalLandPrice = totalLandPrice;

    //입력한 부분을 json으로 만들기전 작업
    //딜마스터
    dealMasterItem!.asking = ((double.tryParse(_wonderPriceController.text.replaceAll(",", "")) ?? 0) * 100000000).toString();
    dealMasterItem!.negotiationType = negotiateINT.toString();
    dealMasterItem!.evacuationType = dispossessINT.toString();
    if (evacuationCk) {
      dealMasterItem!.evacuationChk = 'Y';
    } else {
      dealMasterItem!.evacuationChk = 'N';
    }
    if (_dispossessController.text == '') {
      dealMasterItem!.evacuationPeriod = '0';
    } else {
      dealMasterItem!.evacuationPeriod = _dispossessController.text.replaceAll(",", "");
    }
    //건물

    dealBuildingItem!.loan = loan;
    if (_depositeController.text == '') {
      dealBuildingItem!.deposit = '0';
    } else {
      dealBuildingItem!.deposit = ((double.tryParse(_depositeController.text.replaceAll(",", "")) ?? 0) * 10000).toString();
    }
    if (depositChk) {
      dealBuildingItem!.depositChk = 'Y';
    } else {
      dealBuildingItem!.depositChk = 'N';
    }
    if (_monthlyRentController.text == '') {
      dealBuildingItem!.monthly = '0';
    } else {
      dealBuildingItem!.monthly = ((double.tryParse(_monthlyRentController.text.replaceAll(",", "")) ?? 0) * 10000).toString();
    }
    if (monthlyChk) {
      dealBuildingItem!.monthlyChk = 'Y';
    } else {
      dealBuildingItem!.monthlyChk = 'N';
    }
    if (_roomCntController.text != '') {
      dealBuildingItem!.roomNum = _roomCntController.text.replaceAll(",", "");
    } else {
      dealBuildingItem!.roomNum = '0';
    }
    if (reModel == 2) {
      dealBuildingItem!.reModel = '-1';
    } else if (reModel == 3) {
      dealBuildingItem!.reModel = '0';
    } else {
      dealBuildingItem!.reModel = _remodelingController.text;
    }
    dealRentRollItems = [];

    if (registrationINT == 1) {
      for (var i = 0; i < rentRollsList.length; i++) {
        dealRentRollItems.add(DealRentRollItem());
        // dealRentRollItems[i].dealNo = dealNo;
        dealRentRollItems[i].floor = rentRollsList[i][0];
        dealRentRollItems[i].sectors = rentRollsList[i][1];
        dealRentRollItems[i].area = rentRollsList[i][2].toString().replaceAll(",", "");
        dealRentRollItems[i].deposit = ((double.tryParse(rentRollsList[i][3].toString().replaceAll(",", "")) ?? 0) * 10000).toString();
        dealRentRollItems[i].rent = ((double.tryParse(rentRollsList[i][4].toString().replaceAll(",", "")) ?? 0) * 10000).toString();
        dealRentRollItems[i].etc = rentRollsList[i][5];
      }
    }

    dealRentRollResponse!.rentrollList = dealRentRollItems;

    GV.pStrg.putXXX('dealMasterJson', jsonEncode(dealMasterItem!.toJson()));
    GV.pStrg.putXXX('dealBuildingJson', jsonEncode(dealBuildingItem!.toJson()));
    GV.pStrg.putXXX('dealRentRollJson', jsonEncode(dealRentRollResponse!.toJson()));
    GV.pStrg.putXXX(Param_rentRollRegist, registrationINT.toString());

    // GV.d(GV.pStrg.getXXX('dealMasterJson'));
    // GV.d(GV.pStrg.getXXX('dealBuildingJson'));
    // GV.d(GV.pStrg.getXXX('dealRentRollJson'));
    // GV.d(GV.pStrg.getXXX(Param_rentRollRegist));

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
                                height: 1418 + addHight(),
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
                                                          (dealType == 'L')
                                                              ? radioWithLable(true, IdColors.green2, '신축부지', IdColors.textDefault, false)
                                                              : radioWithLable(false, IdColors.green2, '신축부지', IdColors.textDisabled, true),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealType == 'B')
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
                                                          (dealCategory == '1')
                                                              ? radioWithLable(true, IdColors.green2, '매각', IdColors.textDefault, false)
                                                              : radioWithLable(false, IdColors.green2, '매각', IdColors.textDisabled, true),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealCategory == '2')
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
                                                inputWithLable(
                                                    '<fb2>*</fb2> 희망매각가<unit>(억원)</unit>', '', _wonderPriceController, true, 'number2'),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
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
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('<fb2>*</fb2> 명도'),
                                                    SizedBox(
                                                      width: double.infinity,
                                                      height: 44,
                                                      child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: List.generate(
                                                            dispossessList.length,
                                                            (index) => radioWithLable2(() {
                                                              dispossessINT = index + 1;
                                                              setState(() {});
                                                            }, (dispossessINT == index + 1) ? true : false, IdColors.green2,
                                                                dispossessList[index], IdColors.textDefault, true),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('<fb2>*</fb2> 명도기간<unit>(개월)</unit>'),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                            child: textInputWidget(
                                                                double.infinity, '', _dispossessController, !evacuationCk, 'number')),
                                                        const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                        Row(
                                                          children: [
                                                            IdNormalBtn(
                                                              onBtnPressed: () {
                                                                //
                                                                if (evacuationCk) {
                                                                  evacuationCk = false;
                                                                } else {
                                                                  evacuationCk = true;
                                                                  _dispossessController.text = '';
                                                                }
                                                                setState(() {});
                                                              },
                                                              childWidget: IdImageBox(
                                                                  imagePath: evacuationCk
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
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          titleWidget('<fb2>*</fb2> 보증금<unit>(만원)</unit>'),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: textInputWidget(
                                                                      double.infinity, '', _depositeController, !depositChk, 'number2')),
                                                              const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                              Row(
                                                                children: [
                                                                  IdNormalBtn(
                                                                    onBtnPressed: () {
                                                                      //
                                                                      if (depositChk) {
                                                                        depositChk = false;
                                                                      } else {
                                                                        depositChk = true;
                                                                        _depositeController.text = '';
                                                                      }
                                                                      setState(() {});
                                                                    },
                                                                    childWidget: IdImageBox(
                                                                        imagePath: depositChk
                                                                            ? 'assets/img/icon_checkBox_checked.png'
                                                                            : 'assets/img/icon_checkBox_none.png',
                                                                        imageWidth: 20,
                                                                        imageHeight: 20,
                                                                        imageFit: BoxFit.contain),
                                                                  ),
                                                                  const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                  uiCommon.styledText('확인중', 18, 0, 1, FontWeight.w500,
                                                                      IdColors.textDefault, TextAlign.left)
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          titleWidget('<fb2>*</fb2> 월세<unit>(만원)</unit>'),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                  child: textInputWidget(
                                                                      double.infinity, '', _monthlyRentController, !monthlyChk, 'number2')),
                                                              const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                              Row(
                                                                children: [
                                                                  IdNormalBtn(
                                                                    onBtnPressed: () {
                                                                      //
                                                                      if (monthlyChk) {
                                                                        monthlyChk = false;
                                                                      } else {
                                                                        monthlyChk = true;
                                                                        _monthlyRentController.text = '';
                                                                      }
                                                                      setState(() {});
                                                                    },
                                                                    childWidget: IdImageBox(
                                                                        imagePath: monthlyChk
                                                                            ? 'assets/img/icon_checkBox_checked.png'
                                                                            : 'assets/img/icon_checkBox_none.png',
                                                                        imageWidth: 20,
                                                                        imageHeight: 20,
                                                                        imageFit: BoxFit.contain),
                                                                  ),
                                                                  const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                  uiCommon.styledText('확인중', 18, 0, 1, FontWeight.w500,
                                                                      IdColors.textDefault, TextAlign.left)
                                                                ],
                                                              )
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          titleWidget('융자여부'),
                                                          dropDown1(
                                                              _focusDropDown,
                                                              (loan == '')
                                                                  ? '선택하세요'
                                                                  : (loan == 'Y')
                                                                      ? '있음'
                                                                      : '없음',
                                                              _items,
                                                              changeDropdown)
                                                        ],
                                                      ),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: inputWithLable(
                                                          '총 객실수 <unit>(주거, 호텔 등)</unit>', '', _roomCntController, true, 'number'),
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('<fb2>*</fb2> 리모델링<unit>(여부)</unit>'),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: Row(
                                                            children: [
                                                              IdRadio(
                                                                  onBtnPressed: () {
                                                                    reModel = 1;
                                                                    setState(() {});
                                                                  },
                                                                  checkBool: (reModel == 1) ? true : false,
                                                                  radioColor: IdColors.green2,
                                                                  enabled: true),
                                                              const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                              Expanded(
                                                                  child: textInputWidget(double.infinity, '(ex.2021.02)',
                                                                      _remodelingController, (reModel == 1) ? true : false, 'text'))
                                                            ],
                                                          ),
                                                        ),
                                                        IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                        radioWithLable2(() {
                                                          reModel = 2;
                                                          _remodelingController.text = '';
                                                          setState(() {});
                                                        }, (reModel == 2) ? true : false, IdColors.green2, '확인중', IdColors.textDefault,
                                                            true),
                                                        radioWithLable2(() {
                                                          reModel = 3;
                                                          _remodelingController.text = '';
                                                          setState(() {});
                                                        }, (reModel == 3) ? true : false, IdColors.green2, '없음', IdColors.textDefault,
                                                            true),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('<fb2>*</fb2> 지하철/거리'),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          child: textInputWidget(double.infinity, '', _subwayController, true, 'text'),
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
                                                          child: textInputWidget(double.infinity, '', _distanceController, true, 'text'),
                                                        )
                                                      ],
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  children: [
                                                    SizedBox(
                                                      height: 44,
                                                      child: Row(
                                                        children: [
                                                          Expanded(
                                                            child: titleWidget('<fb2>*</fb2> Rent Roll'),
                                                          ),
                                                          Row(
                                                            children: List.generate(
                                                              registrationList.length,
                                                              (index) => radioWithLable2(() {
                                                                registrationINT = index + 1;
                                                                setState(() {});
                                                              }, (registrationINT == index + 1) ? true : false, IdColors.green2,
                                                                  registrationList[index], IdColors.textDefault, true),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                    //rent roll board
                                                    Stack(
                                                      children: [
                                                        Column(
                                                          children: List.generate(
                                                            rentRollBoardCnt,
                                                            (index) => Column(
                                                              children: [
                                                                rentRolls[index],
                                                                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                        Visibility(
                                                          visible: (registrationINT == 2) ? true : false,
                                                          child: Positioned(
                                                              top: 0,
                                                              left: 0,
                                                              right: 0,
                                                              bottom: 0,
                                                              child: Container(
                                                                color: Color.fromRGBO(0, 0, 0, 0),
                                                              )),
                                                        )
                                                      ],
                                                    ),
                                                    IdNormalBtn(
                                                      onBtnPressed: () {
                                                        rentRollBoardCnt++;
                                                        rentRolls.add(IdRentRollBoard(
                                                            text1: '', text2: '', text3: '', text4: '', text5: '', text6: ''));
                                                        setState(() {});
                                                      },
                                                      childWidget: IdDottedBorder(
                                                        boxWidth: double.infinity,
                                                        boxHeigh: 58,
                                                        roundRadius: 8,
                                                        pattern: [4, 4],
                                                        boxColor: IdColors.green5,
                                                        borderColor: IdColors.green2,
                                                        childWidget: Center(
                                                          child: uiCommon.styledText(
                                                              '+ 추가', 16, 0, 1, FontWeight.w600, IdColors.green2, TextAlign.left),
                                                        ),
                                                      ),
                                                    )
                                                  ],
                                                ),

                                                const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                                //하단 버튼
                                                IdDealRegistBottomBtn(
                                                  beforeBtnFunction: () {
                                                    uiCommon.IdMovePage(context, PAGE_DEAL_STEP_02_2_PAGE);
                                                  },
                                                  btn1: '이전',
                                                  afterBtnFunction: () {
                                                    rentRollsList = [];
                                                    rentRolls.forEach((element) {
                                                      rentRollsList.add([
                                                        element.rent1(),
                                                        element.rent2(),
                                                        element.rent3(),
                                                        element.rent4(),
                                                        element.rent5(),
                                                        element.rent6()
                                                      ]);
                                                    });
                                                    if (_wonderPriceController.text == '') {
                                                      activeToast('희망매각가를 작성해주세요.');
                                                    } else {
                                                      if (negotiateINT == 0) {
                                                        activeToast('가격협의를 선택해주세요.');
                                                      } else {
                                                        if (dispossessINT == 0) {
                                                          activeToast('명도를 선택해주세요.');
                                                        } else {
                                                          if (_dispossessController.text == '' && evacuationCk == false) {
                                                            activeToast('예상명도기간을 입력해주세요.');
                                                          } else {
                                                            if (_depositeController.text == '' && depositChk == false) {
                                                              activeToast('보증금을 입력해주세요.');
                                                            } else {
                                                              if (_monthlyRentController.text == '' && monthlyChk == false) {
                                                                activeToast('월세를 입력해주세요.');
                                                              } else {
                                                                if (reModel == 0) {
                                                                  activeToast('리모델링 여부를 선택해주세요.');
                                                                } else {
                                                                  if (reModel == 1 && _remodelingController.text == '') {
                                                                    activeToast('리모델링 날짜를 입력해주세요.');
                                                                  } else {
                                                                    if (rentRollsList.length > 0) {
                                                                      for (var i = 0; i < rentRollsList.length; i++) {
                                                                        if ((rentRollsList[i][0] == '' ||
                                                                                rentRollsList[i][1] == '' ||
                                                                                rentRollsList[i][2] == '' ||
                                                                                rentRollsList[i][3] == '' ||
                                                                                rentRollsList[i][4] == '' ||
                                                                                rentRollsList[i][5] == '') &&
                                                                            registrationINT == 1) {
                                                                          activeToast('렌트롤에 빈칸이 있습니다.');
                                                                        } else {
                                                                          dataToJson();
                                                                        }
                                                                      }
                                                                    } else {
                                                                      dataToJson();
                                                                    }
                                                                  }
                                                                }
                                                              }
                                                            }
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
