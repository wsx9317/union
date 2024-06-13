import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/common/utils.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDealRegistBottomBtn.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdLotInfoInputTable.dart';
import 'package:unionCDPP/id_widget/IdLotInfoInputTable2.dart';
import 'package:unionCDPP/id_widget/IdLotInfoInputTable3.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageStep.dart';
import 'package:unionCDPP/id_widget/IdRadio.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/modelVO/dealLandItem.dart';
import 'package:unionCDPP/modelVO/dealLotItem.dart';
import 'package:unionCDPP/modelVO/dealLotResponse.dart';
import 'package:unionCDPP/modelVO/dealMasterItem.dart';
import 'package:unionCDPP/popup/addressPopup.dart';
import '../id_widget/KakaoAddress/kakao_address_widget.dart';

class DealStep02_1 extends StatefulWidget {
  const DealStep02_1({super.key});

  @override
  IdState<DealStep02_1> createState() => _DealStep02_1State();
}

class _DealStep02_1State extends IdState<DealStep02_1> {
  DealMasterItem? dealMasterItem;
  DealLotResponse? dealLotResponse;
  List<DealLotItem> dealLotItems = [];
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  int searchingInt = 0;

  int fieldDataCnt = 0;

  bool lotAreaPopupVisible = false;
  bool lotAreaPyPopupVisible = false;
  bool areaPurposePopupVisible = false;
  bool sellPricePopupVisible = false;
  bool officialPricePopupVisible = false;
  bool totalPricePopupVisible = false;

  int rowNum = 0;
  //주소 재검색을 위한 로 번호
  int rowNum2 = 0;

  String dealTypeStr = '';
  String dealCategoryStr = '';

  List dealTypeList = ['newConstructionSite', 'building'];
  List dealCategoryList = ['forSale', 'consignmentOperation'];

  List registrantList = ['중개사', '소유주', '시행사', '기타'];
  List registrantBoolList = [false, false, false, false];

  List<List> fieldData =
      []; //리스트 순서 : 주소, m2, 평, 목적, 공시지가, 총공시지가, 왼쪽라디오, 오른쪽라디오, 매도가, 역이름, 역 거리, pnu , m2, py, araepurpose, official, total

  List<IdLotInfoInpuTable2> lotList1 = [
    IdLotInfoInpuTable2(
        tableNumber: '1', lotArea: '', lotAreaPy: '', address: '', areaPurpose: '', officialPrice: 0, totalPrice: 0, directInputBool: false)
  ];
  List<IdLotInfoInpuTable3> lotList2 = [];

  String stationName = '';
  String stationDistance = '';

  String areaPos = '';

  String jibunAddress = '';

  String popupTitle = '';

  String pnu = '';

  TextEditingController _registrantController = TextEditingController();
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _address3Controller = TextEditingController();
  TextEditingController _address4Controller = TextEditingController();
  //팝업 인풋창에서 쓸거
  TextEditingController _lotAreaController = TextEditingController();
  TextEditingController _lotAreaPyController = TextEditingController();
  TextEditingController _areaPurpoesController = TextEditingController();
  TextEditingController _sellPriceController = TextEditingController();
  TextEditingController _officialLandPriceController = TextEditingController();
  TextEditingController _totalLandPriceController = TextEditingController();
  TextEditingController _totalSellPriceController = TextEditingController();
  //알수없는 입력창 컨트롤러

  // Map<String, TextEditingController> _controllers = {};

  bool directInputAddress1Bool = false;
  bool directInputAddress2Bool = false;
  bool directInputAddress3Bool = false;
  bool directInputUnkownBool = false;

  bool dealTypeBool = false;
  bool dealCategoryBool = false;

  bool dealVATInclude1Bool = false;
  bool dealVATSeparately1Bool = false;

  bool directInputBool = false;

  bool addressPopup = false;

  DealLandItem? dealLand;

  @override
  void initState() {
    super.initState();
    dealMasterItem = DealMasterItem();
    dealLotResponse = DealLotResponse();
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

    dealTypeStr = GV.pStrg.getXXX(Param_dealType);
    dealCategoryStr = GV.pStrg.getXXX(Param_dealCategory);

    if (Param_dealType == dealTypeList[0]) {
      dealTypeBool = true;
    }

    dealLand = DealLandItem();

    String dealMasterItemStr = GV.pStrg.getXXX('dealMasterJson');
    String dealLotStr = GV.pStrg.getXXX('dealLotJson');

    if (dealMasterItemStr != '') {
      dealMasterItem = DealMasterItem.fromJson(jsonDecode(dealMasterItemStr));
      pnu = dealMasterItem!.pnu!;
      if (dealMasterItem!.register == '1') {
        registrantBoolList[0] = true;
      } else if (dealMasterItem!.register == '2') {
        registrantBoolList[1] = true;
      } else if (dealMasterItem!.register == '3') {
        registrantBoolList[2] = true;
      } else {
        registrantBoolList[4] = true;
      }
      if (dealMasterItem!.registerEtc != null) {
        _registrantController.text = dealMasterItem!.registerEtc!;
      } else {
        _registrantController.text = '';
      }
      _address1Controller.text = dealMasterItem!.address!.split(' ')[0];
      _address2Controller.text = dealMasterItem!.address!.split(' ')[1];
      _address3Controller.text = dealMasterItem!.address!.split(' ')[2];
      _address4Controller.text = dealMasterItem!.addressDtl!;
      stationName = dealMasterItem!.stationName!;
      stationDistance = dealMasterItem!.stationDistance!;
    }
    if (dealLotStr != '') {
      dealLotResponse = DealLotResponse.fromJson(jsonDecode(dealLotStr));
      dealLotItems = dealLotResponse!.lotList!;
      searchingInt = dealLotItems.length;
      for (var i = 0; i < dealLotItems.length; i++) {
        if (i == 0) {
          fieldData.add([
            dealLotItems[i].address,
            double.tryParse(dealLotItems[i].lotArea!) ?? 0,
            double.tryParse(dealLotItems[i].lotAreaPy!) ?? 0,
            dealLotItems[i].areaPurpose!,
            (double.tryParse(dealLotItems[i].officialLandPrice!) ?? 0) / 10000,
            (double.tryParse(dealLotItems[i].totalLandPrice!) ?? 0) / 10000,
            false,
            false,
            ((double.tryParse(dealLotItems[i].asking!) ?? 0) / 100000000).toString(),
            stationName,
            stationDistance,
            dealLotItems[i].pnu!
          ]);
        } else {
          if (dealLotItems[i].asking! != '0') {
            fieldData.add([
              dealLotItems[i].address,
              double.tryParse(dealLotItems[i].lotArea!) ?? 0,
              double.tryParse(dealLotItems[i].lotAreaPy!) ?? 0,
              dealLotItems[i].areaPurpose!,
              (double.tryParse(dealLotItems[i].officialLandPrice!) ?? 0) / 10000,
              (double.tryParse(dealLotItems[i].totalLandPrice!) ?? 0) / 10000,
              false,
              true,
              ((double.tryParse(dealLotItems[i].asking!) ?? 0) / 100000000).toString(),
              stationName,
              stationDistance,
              pnu
            ]);
          } else {
            fieldData.add([
              dealLotItems[i].address,
              double.tryParse(dealLotItems[i].lotArea!) ?? 0,
              double.tryParse(dealLotItems[i].lotAreaPy!) ?? 0,
              dealLotItems[i].areaPurpose!,
              (double.tryParse(dealLotItems[i].officialLandPrice!) ?? 0) / 10000,
              (double.tryParse(dealLotItems[i].totalLandPrice!) ?? 0) / 10000,
              true,
              false,
              '',
              stationName,
              stationDistance,
              pnu
            ]);
          }
        }
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _registrantController.dispose();
    _address1Controller.dispose();
    _address2Controller.dispose();
    _address3Controller.dispose();
    _address4Controller.dispose();
    _lotAreaController.dispose();
    _lotAreaPyController.dispose();
    _areaPurpoesController.dispose();
    _sellPriceController.dispose();
    _officialLandPriceController.dispose();
    _totalLandPriceController.dispose();
    _totalSellPriceController.dispose();
  }

  Future<void> fetchData() async {
    final dynamic ret1 = await IdApi.getLandInfo(jibunAddress);
    if (ret1 != null) {
      DealLandItem data = ret1;
      if (searchingInt == 1) {
        if (fieldData.isEmpty) {
          fieldData.add(
            [
              data.address,
              double.tryParse(data.lotArea!) ?? 0,
              double.tryParse(data.lotAreaPy!) ?? 0,
              data.areaPurpose!,
              (double.tryParse(data.officialLandPrice!) ?? 0) / 10000,
              (double.tryParse(data.totalLandPrice!) ?? 0) / 10000,
              false,
              false,
              '',
              data.stationName,
              data.distance,
              data.pnu
            ],
          );
        } else {
          fieldData[rowNum2][0] = data.address;
          fieldData[rowNum2][1] = double.tryParse(data.lotArea!) ?? 0;
          fieldData[rowNum2][2] = double.tryParse(data.lotAreaPy!) ?? 0;
          fieldData[rowNum2][3] = data.areaPurpose!;
          fieldData[rowNum2][4] = (double.tryParse(data.officialLandPrice!) ?? 0) / 10000;
          fieldData[rowNum2][5] = (double.tryParse(data.totalLandPrice!) ?? 0) / 10000;
          fieldData[rowNum2][6] = false;
          fieldData[rowNum2][7] = false;
          fieldData[rowNum2][8] = '';
          fieldData[rowNum2][9] = data.stationName;
          fieldData[rowNum2][10] = data.distance;
          fieldData[rowNum2][11] = data.pnu;
        }
      } else {
        fieldData[rowNum2][0] = data.address;
        fieldData[rowNum2][1] = double.tryParse(data.lotArea!) ?? 0;
        fieldData[rowNum2][2] = double.tryParse(data.lotAreaPy!) ?? 0;
        fieldData[rowNum2][3] = data.areaPurpose!;
        fieldData[rowNum2][4] = (double.tryParse(data.officialLandPrice!) ?? 0) / 10000;
        fieldData[rowNum2][5] = (double.tryParse(data.totalLandPrice!) ?? 0) / 10000;
        fieldData[rowNum2][6] = false;
        fieldData[rowNum2][7] = false;
        fieldData[rowNum2][8] = '';
        fieldData[rowNum2][9] = data.stationName;
        fieldData[rowNum2][10] = data.distance;
        fieldData[rowNum2][11] = data.pnu;
      }
    }
    setState(() {});
  }

  Widget commonInpuPopup(Function() closeFunction, TextEditingController controller, String keyboardType, Function() complete) {
    return Container(
      color: IdColors.black8Per,
      child: Center(
        child: Container(
          width: 600,
          height: 232,
          padding: const EdgeInsets.all(40),
          decoration: BoxDecoration(
            color: IdColors.white,
            borderRadius: BorderRadius.circular(16),
            boxShadow: const [
              BoxShadow(
                color: IdColors.black8Per,
                blurRadius: 16,
                offset: Offset(0, 0),
                spreadRadius: 0,
              ),
            ],
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: uiCommon.styledText(popupTitle, 20, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                  ),
                  IdNormalBtn(
                    onBtnPressed: closeFunction,
                    childWidget: const IdImageBox(
                        imagePath: 'assets/img/icon_close_big.png', imageWidth: 32, imageHeight: 32, imageFit: BoxFit.cover),
                  ),
                ],
              ),
              const IdSpace(spaceWidth: 0, spaceHeight: 16),
              textInput((controller == _sellPriceController) ? '단위: 억원' : '', controller, true, keyboardType),
              const IdSpace(spaceWidth: 0, spaceHeight: 16),
              Row(
                children: [
                  const Expanded(child: SizedBox()),
                  IdNormalBtn(
                    onBtnPressed: complete,
                    childWidget: Container(
                      width: 100,
                      height: 44,
                      decoration: BoxDecoration(
                        color: IdColors.green2,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Center(
                        child: uiCommon.styledText('입력', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

//m2 팝업
  Widget lotAreaPopup(int rowNum) {
    return commonInpuPopup(
      () {
        lotAreaPopupVisible = false;
        setState(() {});
      },
      _lotAreaController,
      'number2',
      () {
        fieldData[rowNum - 1][1] = double.tryParse(_lotAreaController.text) ?? 0;
        lotAreaPopupVisible = false;
        setState(() {});
      },
    );
  }

//평 팝업
  Widget lotAreaPyPopup(int rowNum) {
    return commonInpuPopup(
      () {
        lotAreaPyPopupVisible = false;
        setState(() {});
      },
      _lotAreaPyController,
      'number2',
      () {
        fieldData[rowNum - 1][2] = double.tryParse(_lotAreaPyController.text) ?? 0;
        lotAreaPyPopupVisible = false;
        setState(() {});
      },
    );
  }

//용도지역 팝업
  Widget areaPurposePopup(int rowNum) {
    return commonInpuPopup(
      () {
        areaPurposePopupVisible = false;
        setState(() {});
      },
      _areaPurpoesController,
      'text',
      () {
        fieldData[rowNum - 1][3] = _areaPurpoesController.text;
        areaPurposePopupVisible = false;
        setState(() {});
      },
    );
  }

//매도가격 팝업
  Widget sellPricePopup(int rowNum) {
    return commonInpuPopup(
      () {
        sellPricePopupVisible = false;
        setState(() {});
      },
      _sellPriceController,
      'number2',
      () {
        fieldData[rowNum - 1][8] = _sellPriceController.text.replaceAll(',', '');
        sellPricePopupVisible = false;
        setState(() {});
      },
    );
  }

//공시지가 팝업
  Widget officialPricePopup(int rowNum) {
    return commonInpuPopup(
      () {
        officialPricePopupVisible = false;
        setState(() {});
      },
      _officialLandPriceController,
      'number2',
      () {
        fieldData[rowNum - 1][4] = double.tryParse(_officialLandPriceController.text.replaceAll(',', '')) ?? 0;
        officialPricePopupVisible = false;
        setState(() {});
      },
    );
  }

//공시지가 합계 팝업
  Widget totalPricePopup(int rowNum) {
    return commonInpuPopup(
      () {
        totalPricePopupVisible = false;
        setState(() {});
      },
      _totalLandPriceController,
      'number2',
      () {
        fieldData[rowNum - 1][5] = double.tryParse(_totalLandPriceController.text.replaceAll(',', '')) ?? 0;
        totalPricePopupVisible = false;
        setState(() {});
      },
    );
  }

  Widget radioWithLable(bool checkBool, Color radioColor, String lable, Color lableColor, bool enable) {
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

  Widget radioWithLable3(Function() onBntPressed, String lable, bool enable) {
    return Row(
      children: [
        IdRadio(
          onBtnPressed: onBntPressed,
          checkBool: false,
          radioColor: IdColors.green2,
          enabled: enable,
        ),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        uiCommon.styledText(lable, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left)
      ],
    );
  }

  Widget textInput(String hint, TextEditingController controller, bool enabledBool, String keyboarType) {
    return Expanded(
      child: IdInputValidation(
          width: double.infinity,
          height: 44,
          inputColor: IdColors.backgroundDefault,
          round: 8,
          controller: controller,
          textAlign: 'start',
          hintText: (controller.text.isNotEmpty) ? '' : hint,
          hintTextFontSize: 16,
          hintTextfontWeight: FontWeight.w500,
          hintTextFontColor: IdColors.textTertiary,
          keyboardType: keyboarType,
          validationText: '',
          validationVisible: false,
          vlaidationCheck: false,
          enabledBool: enabledBool),
    );
  }

  double addHeight() {
    double result = 0;
    if (searchingInt == 0) {
      result = 0;
    } else if (searchingInt >= 1) {
      result = 606;
    }
    for (var i = 1; i < fieldData.length; i++) {
      result = result + 254;
    }

    return result;
  }

  Widget inputPrice(Function() radio1Onchange, Function() radio2Onchange, bool radio1Bool, bool radio2Bool,
      TextEditingController textController, Function() inputOnchange) {
    return Container(
      height: 60,
      decoration: const BoxDecoration(
        color: IdColors.white,
        border: Border(
          left: BorderSide(width: 1, color: IdColors.borderDefault),
          right: BorderSide(width: 1, color: IdColors.borderDefault),
          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 172,
            height: 60,
            decoration: const BoxDecoration(
                border: Border(
              right: BorderSide(width: 1, color: IdColors.borderDefault),
            )),
            child: Center(
              child: uiCommon.styledText('매도가격', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
            ),
          ),
          SizedBox(
            width: 513,
            height: 60,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const IdSpace(spaceWidth: 24, spaceHeight: 0),
                radioWithLable3(radio1Onchange, '포함', false),
                const IdSpace(spaceWidth: 32, spaceHeight: 0),
                radioWithLable3(radio2Onchange, '별도', true),
                const IdSpace(spaceWidth: 24, spaceHeight: 0),
                Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: IdInputValidation(
                      width: 280,
                      height: 44,
                      inputColor: IdColors.backgroundDefault,
                      round: 8,
                      textAlign: 'start',
                      controller: textController,
                      onChange: inputOnchange,
                      hintText: '',
                      hintTextFontSize: 16,
                      hintTextfontWeight: FontWeight.w500,
                      hintTextFontColor: IdColors.textDefault,
                      keyboardType: 'text',
                      validationText: '',
                      validationVisible: false,
                      vlaidationCheck: false,
                      enabledBool: true),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget fieldDataBoardHeader(
      double headerWidth, double headerHeight, String headerStr, double bottomWidth, double leftWidth, double rightWidth) {
    return Container(
      width: headerWidth,
      height: headerHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: IdColors.green5,
        border: Border(
          top: const BorderSide(width: 1, color: IdColors.borderDefault),
          left: BorderSide(width: leftWidth, color: IdColors.borderDefault),
          right: BorderSide(width: rightWidth, color: IdColors.borderDefault),
          bottom: BorderSide(width: bottomWidth, color: IdColors.borderDefault),
        ),
      ),
      child: Center(child: uiCommon.styledText(headerStr, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left)),
    );
  }

  Widget fieldDataBoardBody(double bodyWidth, double bodyHeight, double leftWidth, double rightWidth, Widget childWidget) {
    return Container(
      width: bodyWidth,
      height: bodyHeight,
      padding: const EdgeInsets.symmetric(vertical: 16),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: leftWidth, color: IdColors.borderDefault),
          right: BorderSide(width: rightWidth, color: IdColors.borderDefault),
          bottom: const BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: childWidget,
    );
  }

  Widget fieldDataBoard() {
    return Column(
      children: [
        //header
        SizedBox(
          width: 687,
          height: 60,
          child: Row(
            children: [
              fieldDataBoardHeader(57, 59, 'No', 1, 1, 0),
              Expanded(
                child: SizedBox(
                  height: double.infinity,
                  child: Column(
                    children: [
                      Expanded(child: fieldDataBoardHeader(132, 29.5, '대지면적', 0, 1, 0)),
                      Expanded(
                        child: SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              fieldDataBoardHeader(66, 29.5, '㎡', 1, 1, 0),
                              Expanded(child: fieldDataBoardHeader(66, 29.5, '평', 1, 1, 0)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              fieldDataBoardHeader(79, 59, '용도지역', 1, 1, 0),
              fieldDataBoardHeader(182, 59, '매도가격', 1, 1, 0),
              fieldDataBoardHeader(105, 59, '개별공시지가', 1, 1, 0),
              fieldDataBoardHeader(132, 59, '공시지가합계', 1, 1, 1),
            ],
          ),
        ),
        //body
        Column(
          children: [
            Column(
              children: List.generate(
                fieldData.length,
                (index) => IdLotInfoInpuTable(
                  tableNumber: (index + 1).toString(),
                  lotArea: (double.tryParse(fieldData[index][1].toString()) ?? 0).toStringAsFixed(2),
                  lotAreaPy: (double.tryParse(fieldData[index][2].toString()) ?? 0).toStringAsFixed(2),
                  address: fieldData[index][0],
                  areaPurpose: fieldData[index][3],
                  officialPrice: fieldData[index][4].toStringAsFixed(2),
                  totalPrice: fieldData[index][5].toStringAsFixed(2),
                  leftRadio: fieldData[index][6],
                  leftRadioAction: (index == 0)
                      ? () => null
                      : (fieldData[index][0] == '')
                          ? () => null
                          : () {
                              if (fieldData[index][6]) {
                                fieldData[index][6] = false;
                              } else {
                                fieldData[index][6] = true;
                                fieldData[index][7] = false;
                                fieldData[index][8] = '';
                                _sellPriceController.text = '';
                              }
                              setState(() {});
                            },
                  rightRadio: fieldData[index][7],
                  rightRadioAction: (index == 0)
                      ? () => null
                      : (fieldData[index][0] == '')
                          ? () => null
                          : () {
                              if (fieldData[index][7]) {
                                fieldData[index][7] = false;
                              } else {
                                fieldData[index][7] = true;
                                fieldData[index][6] = false;
                              }
                              sellPricePopupVisible = true;
                              popupTitle = '매도가격';
                              rowNum = index + 1;
                              setState(() {});
                            },
                  directInputBool: directInputBool,
                  searchAddress: () {
                    addressPopup = true;
                    rowNum2 = index;
                    _sellPriceController.text = '';
                    setState(() {});
                  },
                  m2Function: () {
                    lotAreaPopupVisible = true;
                    popupTitle = '㎡';
                    rowNum = index + 1;
                    setState(() {});
                  },
                  pyFunction: () {
                    lotAreaPyPopupVisible = true;
                    popupTitle = '평';
                    rowNum = index + 1;
                    setState(() {});
                  },
                  areaPurposeFunction: () {
                    areaPurposePopupVisible = true;
                    popupTitle = '용도지역';
                    rowNum = index + 1;
                    setState(() {});
                  },
                  askingFunction: () {
                    sellPricePopupVisible = true;
                    popupTitle = '매도가격';
                    rowNum = index + 1;
                    setState(() {});
                  },
                  officialPriceFunction: () {
                    officialPricePopupVisible = true;
                    popupTitle = '공시지가';
                    rowNum = index + 1;
                    setState(() {});
                  },
                  totalPriceFunction: () {
                    totalPricePopupVisible = true;
                    popupTitle = '공시지가 합계';
                    rowNum = index + 1;
                    setState(() {});
                  },
                  sellPrice: fieldData[index][8],
                ),
              ),
            ),
            SizedBox(
              width: 687,
              child: Row(
                children: [
                  fieldDataBoardBody(
                      57,
                      190,
                      1,
                      0,
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 60),
                        child: IdNormalBtn(
                          onBtnPressed: () {
                            fieldData.add(['', 0, 0, '', 0, 0, false, false, '', '', '', '', '']);
                            setState(() {});
                          },
                          childWidget: uiCommon.styledText('추가', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                        ),
                      )),
                  SizedBox(
                    width: 393,
                    height: 190,
                    child: Column(
                      children: [
                        Row(
                          children: [
                            fieldDataBoardBody(
                                66,
                                60,
                                1,
                                0,
                                Center(
                                  child: uiCommon.styledText('주소', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                                )),
                            Expanded(child: fieldDataBoardBody(66, 60, 1, 0, SizedBox())),
                          ],
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              fieldDataBoardBody(66, 130, 1, 0, SizedBox()),
                              Expanded(child: fieldDataBoardBody(57, 130, 1, 0, SizedBox())),
                              fieldDataBoardBody(79, 130, 1, 0, SizedBox()),
                              fieldDataBoardBody(182, 130, 1, 0, SizedBox()),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  fieldDataBoardBody(105, 190, 1, 0, SizedBox()),
                  fieldDataBoardBody(132, 190, 1, 1, SizedBox()),
                ],
              ),
            ),
            SizedBox(
              width: 687,
              child: Row(
                children: [
                  fieldDataBoardBody(
                    57,
                    85,
                    1,
                    0,
                    Center(
                      child: uiCommon.styledText('합계', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                    ),
                  ),
                  SizedBox(
                    width: 132,
                    height: 85,
                    child: Row(
                      children: [
                        fieldDataBoardBody(
                          66,
                          85,
                          1,
                          0,
                          Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                uiCommon.styledText(
                                    totalM2().toStringAsFixed(2), 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                                uiCommon.styledText('㎡', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: fieldDataBoardBody(
                            57,
                            85,
                            1,
                            0,
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  uiCommon.styledText(
                                      totalPyong().toStringAsFixed(2), 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                                  uiCommon.styledText('py', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                      child: fieldDataBoardBody(
                    66,
                    85,
                    1,
                    0,
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: uiCommon.styledText(
                              (fieldData.length > 1) ? fieldData[0][0] + '외 ${fieldData.length - 1}개 필지' : fieldData[0][0],
                              16,
                              0,
                              1.6,
                              FontWeight.w500,
                              IdColors.textDefault,
                              TextAlign.left),
                        ),
                      ],
                    ),
                  )),
                  fieldDataBoardBody(
                      132,
                      85,
                      1,
                      1,
                      Center(
                        child: uiCommon.styledText(IdStrUtil.toMoneyUnitKr(NumberFormat('#,##0.00').format(totalAllPrice())), 16, 0, 1,
                            FontWeight.w500, IdColors.textDefault, TextAlign.left),
                      )),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  double totalM2() {
    double result = 0;
    if (fieldData.isNotEmpty) {
      for (var i = 0; i < fieldData.length; i++) {
        result = result + fieldData[i][1];
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  double totalPyong() {
    double result = 0;
    if (fieldData.isNotEmpty) {
      for (var i = 0; i < fieldData.length; i++) {
        result = result + fieldData[i][2];
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  String totalArea() {
    String result = '-';
    List<String> areaList = [];
    if (fieldData.isNotEmpty) {
      for (var i = 0; i < fieldData.length; i++) {
        areaList.add(fieldData[i][3]);
        bool allSame = areaList.toSet().length == 1;
        if (allSame) {
          result = fieldData[0][3];
        } else {
          result = '-';
        }
      }
    } else {
      result = '-';
    }
    return result;
  }

  int totalSellPrice() {
    int result = 0;
    String replace = '';
    if (fieldData.isNotEmpty) {
      for (var i = 0; i < fieldData.length; i++) {
        if (fieldData[i][8] != '') {
          replace = fieldData[i][8].toString().replaceAll(',', '');
          int replaceInt = int.tryParse(replace) ?? 0;

          result = result + replaceInt;
        } else {
          result = 0;
        }
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  int allPrice() {
    int result = 0;
    if (fieldData.isNotEmpty) {
      for (var i = 0; i < fieldData.length; i++) {
        result = int.tryParse((result + fieldData[i][4]).toString()) ?? 0;
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  double totalAllPrice() {
    double result = 0;
    if (fieldData.isNotEmpty) {
      for (var i = 0; i < fieldData.length; i++) {
        result = double.tryParse((result + fieldData[i][5]).toString()) ?? 0;
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  Future<void> dataToJson() async {
    //딜 마스터
    //타입
    dealMasterItem!.pnu = fieldData[0][11].toString();
    if (dealTypeStr == dealTypeList[0]) {
      dealMasterItem!.type = 'L';
    } else {
      dealMasterItem!.type = 'B';
    }
    //카테고리
    if (dealCategoryStr == dealCategoryList[0]) {
      dealMasterItem!.category = '1';
    } else {
      dealMasterItem!.category = '2';
    }
    //등록자
    if (registrantBoolList[0]) {
      dealMasterItem!.register = '1';
    } else if (registrantBoolList[1]) {
      dealMasterItem!.register = '2';
    } else if (registrantBoolList[2]) {
      dealMasterItem!.register = '3';
    } else {
      dealMasterItem!.register = '4';
    }
    dealMasterItem!.registerEtc = _registrantController.text;
    dealMasterItem!.address = '${_address1Controller.text} ${_address2Controller.text} ${_address3Controller.text}';
    dealMasterItem!.addressDtl = _address4Controller.text;
    dealMasterItem!.areaPos = areaPos;
    dealMasterItem!.stationName = fieldData[0][9];
    dealMasterItem!.stationDistance = fieldData[0][10];
    //lotList
    dealLotItems = [];
    for (var i = 0; i < fieldData.length; i++) {
      if (fieldData[i][0] != '') {
        dealLotItems.add(DealLotItem());
        dealLotItems[i].pnu = fieldData[i][11].toString();
        dealLotItems[i].address = fieldData[i][0];
        dealLotItems[i].lotArea = fieldData[i][1].toString();
        dealLotItems[i].lotAreaPy = fieldData[i][2].toString();
        dealLotItems[i].areaPurpose = fieldData[i][3];
        dealLotItems[i].officialLandPrice = (fieldData[i][4] * 10000).toString();
        dealLotItems[i].totalLandPrice = (fieldData[i][5] * 10000).toString();
        if (fieldData[i][6]) {
          dealLotItems[i].asking = '0';
        } else {
          dealLotItems[i].asking = ((double.tryParse(fieldData[i][8].toString().replaceAll(',', '')) ?? 0) * 100000000).toString();
        }
      }
    }
    dealLotResponse!.lotList = dealLotItems;

    GV.pStrg.putXXX('dealMasterJson', jsonEncode(dealMasterItem!.toJson()));
    GV.pStrg.putXXX('dealLotJson', jsonEncode(dealLotResponse!.toJson()));

    // print(GV.pStrg.getXXX('dealMasterJson'));
    // print(GV.pStrg.getXXX('dealLotJson'));

    uiCommon.IdMovePage(context, PAGE_DEAL_STEP_03_1_PAGE);
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
                                height: 310 + addHeight(),
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
                                              IdPageStep(stepDesc: stepDesc, pageNumber: 2)
                                            ],
                                          ),
                                          const IdSpace(spaceWidth: 84, spaceHeight: 0),
                                          //입력부분
                                          Stack(
                                            children: [
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
                                                    uiCommon.styledText('<fb2>Step 2.</fb2> 제안할 부동산의 기본 정보를 입력하세요.', 32, 0, 1.3,
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
                                                              uiCommon.styledText('Deal 종류', 18, 0, 1, FontWeight.w600,
                                                                  IdColors.textDefault, TextAlign.left),
                                                              const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                              (dealTypeStr == dealTypeList[0])
                                                                  ? radioWithLable(
                                                                      true, IdColors.green2, '신축부지', IdColors.textDefault, false)
                                                                  : radioWithLable(
                                                                      false, IdColors.green2, '신축부지', IdColors.textDisabled, true),
                                                              const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                              (dealTypeStr == dealTypeList[1])
                                                                  ? radioWithLable(true, IdColors.green2, '건물', IdColors.textDefault, false)
                                                                  : radioWithLable(
                                                                      false, IdColors.green2, '건물', IdColors.textDisabled, true),
                                                            ],
                                                          ),
                                                        ),
                                                        Positioned(
                                                          top: 0,
                                                          right: 0,
                                                          child: Row(
                                                            children: [
                                                              uiCommon.styledText('Deal 유형', 18, 0, 1, FontWeight.w600,
                                                                  IdColors.textDefault, TextAlign.left),
                                                              const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                              (dealCategoryStr == dealCategoryList[0])
                                                                  ? radioWithLable(true, IdColors.green2, '매각', IdColors.textDefault, false)
                                                                  : radioWithLable(
                                                                      false, IdColors.green2, '매각', IdColors.textDisabled, true),
                                                              const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                              (dealCategoryStr == dealCategoryList[1])
                                                                  ? radioWithLable(
                                                                      true, IdColors.green2, '위탁운영', IdColors.textDefault, false)
                                                                  : radioWithLable(
                                                                      false, IdColors.green2, '위탁운영', IdColors.textDisabled, true),
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
                                                    SizedBox(
                                                      height: 44,
                                                      child: uiCommon.styledText('<fb2>*</fb2> 등록자', 18, 0, 1.6, FontWeight.w600,
                                                          IdColors.textDefault, TextAlign.left),
                                                    ),
                                                    Row(
                                                      children: [
                                                        //라디오 버튼
                                                        Row(
                                                          children: List.generate(
                                                              registrantBoolList.length,
                                                              (index) => radioWithLable2(() {
                                                                    if (registrantBoolList[index]) {
                                                                      registrantBoolList = [false, false, false, false];
                                                                      registrantBoolList[index] = true;
                                                                    } else {
                                                                      registrantBoolList = [false, false, false, false];
                                                                      registrantBoolList[index] = true;
                                                                      if (index != 3) {
                                                                        _registrantController.text = '';
                                                                      }
                                                                    }
                                                                    setState(
                                                                      () {},
                                                                    );
                                                                  }, registrantBoolList[index], IdColors.green2, registrantList[index],
                                                                      IdColors.textDefault, true)),
                                                        ),
                                                        //인풋버튼1
                                                        IdInputValidation(
                                                            width: 258,
                                                            height: 44,
                                                            inputColor: registrantBoolList[3] ? IdColors.white : IdColors.backgroundDefault,
                                                            borderColor:
                                                                registrantBoolList[3] ? IdColors.borderDefault : IdColors.backgroundDefault,
                                                            round: 8,
                                                            controller: _registrantController,
                                                            textAlign: 'start',
                                                            hintText: '',
                                                            hintTextFontSize: 18,
                                                            hintTextfontWeight: FontWeight.w400,
                                                            hintTextFontColor: IdColors.textDefault,
                                                            keyboardType: 'text',
                                                            validationText: '',
                                                            validationVisible: false,
                                                            vlaidationCheck: false,
                                                            enabledBool: registrantBoolList[3])
                                                      ],
                                                    ),
                                                    const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                    SizedBox(
                                                      height: 44,
                                                      child: uiCommon.styledText('<fb2>*</fb2> 소재지', 18, 0, 1.6, FontWeight.w600,
                                                          IdColors.textDefault, TextAlign.left),
                                                    ),
                                                    Row(
                                                      children: [
                                                        textInput('특별시/광역시/도', _address1Controller, false, 'text'),
                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                        textInput('시/구', _address2Controller, false, 'text'),
                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                        textInput('읍/면/동', _address3Controller, false, 'text'),
                                                      ],
                                                    ),
                                                    const IdSpace(spaceWidth: 0, spaceHeight: 10),
                                                    //상세주소, 검색
                                                    Row(
                                                      children: [
                                                        textInput('상세 주소 입력', _address4Controller, false, 'text'),
                                                        const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                        IdNormalBtn(
                                                          onBtnPressed: () {
                                                            addressPopup = true;
                                                            rowNum2 = 0;
                                                            setState(() {});
                                                          },
                                                          childWidget: Container(
                                                            width: 74,
                                                            height: 44,
                                                            decoration: ShapeDecoration(
                                                              color: Colors.white.withOpacity(0),
                                                              shape: RoundedRectangleBorder(
                                                                side: const BorderSide(width: 1, color: IdColors.textDefault),
                                                                borderRadius: BorderRadius.circular(8),
                                                              ),
                                                            ),
                                                            child: Center(
                                                              child: uiCommon.styledText(
                                                                  '검색', 15, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    const IdSpace(spaceWidth: 0, spaceHeight: 22),
                                                    //직접입력 체크박스
                                                    Row(
                                                      children: [
                                                        IdNormalBtn(
                                                          onBtnPressed: () {
                                                            //
                                                            if (directInputBool) {
                                                              directInputBool = false;
                                                            } else {
                                                              directInputBool = true;
                                                            }
                                                            setState(() {});
                                                          },
                                                          childWidget: IdImageBox(
                                                              imagePath: directInputBool
                                                                  ? 'assets/img/icon_checkBox_checked.png'
                                                                  : 'assets/img/icon_checkBox_none.png',
                                                              imageWidth: 20,
                                                              imageHeight: 20,
                                                              imageFit: BoxFit.contain),
                                                        ),
                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                        uiCommon.styledText(
                                                            '직접입력', 18, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left)
                                                      ],
                                                    ),
                                                    Visibility(
                                                      visible: (searchingInt == 0) ? false : true,
                                                      child: Column(
                                                        children: [
                                                          const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                          (fieldData.isNotEmpty) ? fieldDataBoard() : const SizedBox(),
                                                        ],
                                                      ),
                                                    ),
                                                    const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                                    IdDealRegistBottomBtn(
                                                      beforeBtnFunction: () {
                                                        uiCommon.IdMovePage(context, PAGE_DEAL_STEP_01_PAGE);
                                                      },
                                                      btn1: '이전',
                                                      afterBtnFunction: () {
                                                        if (!registrantBoolList.contains(true)) {
                                                          activeToast('등록자를 선택해주세요.');
                                                        } else {
                                                          if (registrantBoolList[3] == true) {
                                                            if (_registrantController.text == '') {
                                                              activeToast('어떤 등록자인지 작성해 주세요.');
                                                            } else {
                                                              if (searchingInt == 0) {
                                                                activeToast('소재지를 넣어주세요.');
                                                              } else {
                                                                if (registrantBoolList[0]) {
                                                                  GV.pStrg.putXXX(Param_registrantType, registrantList[0]);
                                                                } else if (registrantBoolList[1]) {
                                                                  GV.pStrg.putXXX(Param_registrantType, registrantList[1]);
                                                                }
                                                                if (registrantBoolList[2]) {
                                                                  GV.pStrg.putXXX(Param_registrantType, registrantList[2]);
                                                                }
                                                                if (registrantBoolList[3]) {
                                                                  GV.pStrg.putXXX(Param_registrantType, _registrantController.text);
                                                                }
                                                                if (fieldData[0][8] == '') {
                                                                  activeToast('매도가를 입력해주세요.');
                                                                } else {
                                                                  dataToJson();
                                                                }
                                                              }
                                                            }
                                                          } else {
                                                            if (searchingInt == 0) {
                                                              activeToast('소재지를 넣어주세요.');
                                                            } else {
                                                              if (registrantBoolList[0]) {
                                                                GV.pStrg.putXXX(Param_registrantType, registrantList[0]);
                                                              } else if (registrantBoolList[1]) {
                                                                GV.pStrg.putXXX(Param_registrantType, registrantList[1]);
                                                              }
                                                              if (registrantBoolList[2]) {
                                                                GV.pStrg.putXXX(Param_registrantType, registrantList[2]);
                                                              }
                                                              if (registrantBoolList[3]) {
                                                                GV.pStrg.putXXX(Param_registrantType, _registrantController.text);
                                                              }
                                                              if (fieldData[0][8] == '') {
                                                                activeToast('매도가를 입력해주세요.');
                                                              } else {
                                                                dataToJson();
                                                              }
                                                            }
                                                          }
                                                        }
                                                      },
                                                      btn2: '다음',
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
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
                idCommonHeader(),
                idHeadToastWidget(),
                Visibility(
                  visible: addressPopup,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: IdColors.black8Per,
                      child: Center(
                        child: AddressPopup(
                          closeFuntion: () {
                            addressPopup = false;
                            setState(() {});
                          },
                          addressWidget: KakaoAddressWidget(
                            onComplete: (kakaoAddress) {
                              if (rowNum2 == 0) {
                                _address1Controller.text = kakaoAddress.jibunAddress.split(' ')[0];
                                _address2Controller.text = kakaoAddress.jibunAddress.split(' ')[1];
                                _address3Controller.text = kakaoAddress.jibunAddress.split(' ')[2];
                                _address4Controller.text = kakaoAddress.jibunAddress.split(' ')[3];
                                areaPos = kakaoAddress.postCode;
                              }
                              jibunAddress = kakaoAddress.jibunAddress;
                              fetchData();
                              if (searchingInt == 0) {
                                searchingInt = 1;
                              } else {
                                if (rowNum2 == 0) {
                                  searchingInt;
                                } else {
                                  searchingInt++;
                                }
                              }
                              setState(() {});
                            },
                            onClose: () {
                              addressPopup = false;
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: lotAreaPopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: lotAreaPopup(rowNum),
                  ),
                ),
                Visibility(
                  visible: lotAreaPyPopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: lotAreaPyPopup(rowNum),
                  ),
                ),
                Visibility(
                  visible: areaPurposePopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: areaPurposePopup(rowNum),
                  ),
                ),
                Visibility(
                  visible: sellPricePopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: sellPricePopup(rowNum),
                  ),
                ),
                Visibility(
                  visible: officialPricePopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: officialPricePopup(rowNum),
                  ),
                ),
                Visibility(
                  visible: totalPricePopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: totalPricePopup(rowNum),
                  ),
                ),
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
