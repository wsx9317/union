import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/common/utils.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDealRegistBottomBtn.dart';
import 'package:unionCDPP/id_widget/IdGrid.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageStep.dart';
import 'package:unionCDPP/id_widget/IdRadio.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/id_widget/KakaoAddress/kakao_address_widget.dart';
import 'package:unionCDPP/modelVO/dealBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealBuildingResponse.dart';
import 'package:unionCDPP/modelVO/dealMasterItem.dart';
import 'package:unionCDPP/popup/addressPopup.dart';
import 'package:unionCDPP/popup/alertPopup.dart';

class _BuildingList {
  DealBuildingResponse? data;
}

class DealStep02_2 extends StatefulWidget {
  const DealStep02_2({super.key});

  @override
  IdState<DealStep02_2> createState() => _DealStep02_2State();
}

class _DealStep02_2State extends IdState<DealStep02_2> {
  List<List<String>> _buildingSvcDS = [];
  List<_BuildingList> _buildingDs = [];
  DealMasterItem? dealMasterItem;
  // DealMasterSetting? dealMasterSetting;
  DealBuildingItem? dealBuildingItem;

  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  String dealTypeStr = '';
  String dealCategoryStr = '';

  List dealTypeList = ['newConstructionSite', 'building'];
  List dealCategoryList = ['forSale', 'consignmentOperation'];

  List registrantList = ['중개사', '소유주', '시행사', '기타'];
  List registrantBoolList = [false, false, false, false];

  bool directInputBool = false;

  bool addressPopup = false;
  bool alertPopup = false;

  bool selectBuildingInfoPopup = false;

  bool textNumber1Check = true;
  bool textNumber2Check = true;
  bool textNumber3Check = true;
  bool textNumber4Check = true;
  bool textNumber5Check = true;
  bool textNumber6Check = true;

  List boardBuildingNameList = [];
  List boardlotAreaList = [];
  List boardTotalFloorAreaList = [];
  List boardAeaPurposeList = [];
  List boardTotalFloorRatioList = [];
  List boardBdDistrictUnitPlanList = [];
  List boardBdCoverageRatioList = [];
  List boardMainPurposeList = [];
  List boardMainStructList = [];
  List boardCcdList = [];
  List boardUpperNumList = [];
  List boardLowerNumList = [];
  List boardElevatorList = [];
  List boardParkingNumList = [];
  List boardOfficialLandPriceList = [];
  List boardTotalLandPriceList = [];

  String jibunAddress = '';
  String bname = '';
  String postCd = '';
  String pnu = '';
  String station = '';
  String bdUniqueId = '';
  String subwayLine = '';
  String distance = '';

  double totalCnt = 0;

  TextEditingController _registrantController = TextEditingController();
  TextEditingController _address1Controller = TextEditingController();
  TextEditingController _address2Controller = TextEditingController();
  TextEditingController _address3Controller = TextEditingController();
  TextEditingController _address4Controller = TextEditingController();

  //건물 데이터 컨트롤러
  TextEditingController _building1Controller = TextEditingController(); //건물명
  TextEditingController _building2Controller = TextEditingController(); //대지면적
  TextEditingController _building3Controller = TextEditingController(); //연면적
  TextEditingController _building4Controller = TextEditingController(); //용도지역
  TextEditingController _building5Controller = TextEditingController(); //용적률
  TextEditingController _building6Controller = TextEditingController(); //지주단위계획구역
  TextEditingController _building7Controller = TextEditingController(); //건폐율
  TextEditingController _building8Controller = TextEditingController(); //주용도
  TextEditingController _building9Controller = TextEditingController(); //주구조
  TextEditingController _building10Controller = TextEditingController(); //준공연도
  TextEditingController _building11Controller = TextEditingController(); //지상
  TextEditingController _building12Controller = TextEditingController(); //지하
  TextEditingController _building13Controller = TextEditingController(); //승강기
  TextEditingController _building14Controller = TextEditingController(); //주차장
  TextEditingController _building15Controller = TextEditingController(); //공시지가
  TextEditingController _building16Controller = TextEditingController(); //공시지가 합계

  @override
  void initState() {
    super.initState();
    dealMasterItem = DealMasterItem();
    dealBuildingItem = DealBuildingItem();
    _buildingDs.add(_BuildingList());
    // dealMasterSetting = DealMasterSetting();
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

    String dealMasterItemStr = GV.pStrg.getXXX('dealMasterJson');
    String dealBuildingItemStr = GV.pStrg.getXXX('dealBuildingJson');
    if (dealMasterItemStr != '') {
      dealMasterItem = DealMasterItem.fromJson(jsonDecode(dealMasterItemStr));
      if (dealMasterItem != null) {
        if (dealMasterItem!.register == '1') {
          registrantBoolList = [true, false, false, false];
          _registrantController.text = '';
        } else if (dealMasterItem!.register == '2') {
          registrantBoolList = [false, true, false, false];
          _registrantController.text = '';
        } else if (dealMasterItem!.register == '3') {
          registrantBoolList = [false, false, true, false];
          _registrantController.text = '';
        } else {
          registrantBoolList = [false, false, false, true];
          _registrantController.text = dealMasterItem!.registerEtc!;
        }
      }
      _address1Controller.text = dealMasterItem!.address!.split(' ')[0];
      _address2Controller.text = dealMasterItem!.address!.split(' ')[1];
      _address3Controller.text = dealMasterItem!.address!.split(' ')[2];
      _address4Controller.text = dealMasterItem!.addressDtl!;
      station = dealMasterItem!.stationName!;
      distance = dealMasterItem!.stationDistance!;
      pnu = dealMasterItem!.pnu!;
      postCd = dealMasterItem!.areaPos!;
    }
    if (dealBuildingItemStr != '') {
      dealBuildingItem = DealBuildingItem.fromJson(jsonDecode(dealBuildingItemStr));
      _building1Controller.text = dealBuildingItem!.buildingName!;
      _building2Controller.text = dealBuildingItem!.lotArea!.replaceAll(',', '');
      _building3Controller.text = dealBuildingItem!.totalFloorArea!.replaceAll(',', '');
      _building4Controller.text = dealBuildingItem!.areaPurpose!;
      _building5Controller.text = dealBuildingItem!.totalFloorRatio!.replaceAll(',', '');
      _building6Controller.text = dealBuildingItem!.bdDistrictUnitPlan!;
      _building7Controller.text = dealBuildingItem!.bdCoverageRatio!.replaceAll(',', '');
      _building8Controller.text = dealBuildingItem!.mainPurpose!;
      _building9Controller.text = dealBuildingItem!.mainStruct!;
      _building10Controller.text = dealBuildingItem!.ccd!.replaceAll(',', '');
      _building11Controller.text = dealBuildingItem!.upperNum!.replaceAll(',', '');
      _building12Controller.text = 'B' + dealBuildingItem!.lowerNum!.replaceAll(',', '');
      _building13Controller.text = dealBuildingItem!.elevator!.replaceAll(',', '');
      _building14Controller.text = dealBuildingItem!.parkingNum!.replaceAll(',', '');
      _building15Controller.text =
          IdStrUtil.toMoneyUnitKr(((double.tryParse(dealBuildingItem!.officialLandPrice!) ?? 0) / 10000).toString());
      _building16Controller.text = IdStrUtil.toMoneyUnitKr(((double.tryParse(dealBuildingItem!.totalLandPrice!) ?? 0) / 10000).toString());
    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    final DealBuildingResponse? ret1 = await IdApi.getBuildingInfo(jibunAddress);
    if (ret1 != null) {
      totalCnt = double.tryParse(ret1.totalCnt!.toString()) ?? 0;
      _buildingDs[0].data = ret1;
      pnu = ret1.list![0].pnu!;
      station = ret1.subway!['stationName'];
      subwayLine = ret1.subway!['lineName'];
      distance = ret1.subway!['distance'];
      if (ret1.totalCnt == 1) {
        _building1Controller.text = ret1.list![0].buildingName!;
        _building2Controller.text = ret1.list![0].lotArea!;
        _building3Controller.text = ret1.list![0].totalFloorArea!;
        _building4Controller.text = ret1.list![0].areaPurpose!;
        if (ret1.list![0].totalFloorRatio == null) {
          _building5Controller.text = '0';
        } else {
          _building5Controller.text = ret1.list![0].totalFloorRatio!;
        }
        //TODO 지구단위계획구역, 건페율
        if (ret1.list![0].bdDistrictUnitPlan != null) {
          _building6Controller.text = ret1.list![0].bdDistrictUnitPlan!;
        } else {
          _building6Controller.text = '';
        }
        _building7Controller.text = ret1.list![0].bdCoverageRatio!.replaceAll(',', '');
        _building8Controller.text = ret1.list![0].mainPurpose!;
        _building9Controller.text = ret1.list![0].mainStruct!;
        _building10Controller.text = ret1.list![0].ccd!.replaceAll(',', '');
        _building11Controller.text = ret1.list![0].upperNum!.replaceAll(',', '');
        _building12Controller.text = 'B' + ret1.list![0].lowerNum!.replaceAll(',', '');
        _building13Controller.text = ret1.list![0].elevator!.replaceAll(',', '');
        _building14Controller.text = ret1.list![0].parkingNum!.replaceAll(',', '');
        _building15Controller.text =
            IdStrUtil.toMoneyUnitKr(((double.tryParse(ret1.list![0].officialLandPrice!) ?? 0) / 10000).toStringAsFixed(2));
        _building16Controller.text =
            IdStrUtil.toMoneyUnitKr(((double.tryParse(ret1.list![0].totalLandPrice!) ?? 0) / 10000).toStringAsFixed(2));
        bdUniqueId = ret1.list![0].bdUniqueId!;
        pnu = ret1.list![0].pnu!;
      } else {
        selectBuildingInfoPopup = true;
      }
    } else {
      _building1Controller.text = '';
      _building2Controller.text = '';
      _building3Controller.text = '';
      _building4Controller.text = '';
      _building5Controller.text = '';
      _building6Controller.text = '';
      _building7Controller.text = '';
      _building8Controller.text = '';
      _building9Controller.text = '';
      _building10Controller.text = '';
      _building11Controller.text = '';
      _building12Controller.text = '';
      _building13Controller.text = '';
      _building14Controller.text = '';
      _building15Controller.text = '';
      _building16Controller.text = '';
      alertPopup = true;
    }

    setState(() {});
  }

  List<List<String>> makeRows() {
    List<List<String>> results = [];
    boardBuildingNameList = [];
    boardlotAreaList = [];
    boardTotalFloorAreaList = [];
    boardAeaPurposeList = [];
    boardTotalFloorRatioList = [];
    boardBdDistrictUnitPlanList = [];
    boardBdCoverageRatioList = [];
    boardMainPurposeList = [];
    boardMainStructList = [];
    boardCcdList = [];
    boardUpperNumList = [];
    boardLowerNumList = [];
    boardElevatorList = [];
    boardParkingNumList = [];
    boardOfficialLandPriceList = [];
    boardTotalLandPriceList = [];
    if (totalCnt > 1) {
      // if (noticeList.isEmpty) return results;

      for (var i = 0; i < _buildingDs[0].data!.list!.length; i++) {
        List<String> row1 = [];
        var item1 = _buildingDs[0].data!.list![i];

        boardBuildingNameList.add(item1.buildingName!);
        boardlotAreaList.add(item1.lotArea!);
        boardTotalFloorAreaList.add(item1.totalFloorArea!);
        boardAeaPurposeList.add(item1.areaPurpose!);
        if (item1.totalFloorRatio != null) {
          boardTotalFloorRatioList.add(item1.totalFloorRatio!);
        } else {
          boardTotalFloorRatioList.add('0');
        }
        if (item1.bdDistrictUnitPlan != null) {
          boardBdDistrictUnitPlanList.add(item1.bdDistrictUnitPlan!);
        } else {
          boardBdDistrictUnitPlanList.add('');
        }
        boardBdCoverageRatioList.add(item1.bdCoverageRatio!);
        boardMainPurposeList.add(item1.mainPurpose!);
        boardMainStructList.add(item1.mainStruct!);
        boardCcdList.add(item1.ccd!);
        boardUpperNumList.add(item1.upperNum!);
        boardLowerNumList.add(item1.lowerNum!);
        boardElevatorList.add(item1.elevator!);
        boardParkingNumList.add(item1.parkingNum!);
        boardOfficialLandPriceList.add(IdStrUtil.toMoneyUnitKr(((double.tryParse(item1.officialLandPrice!) ?? 0) / 10000).toString()));
        boardTotalLandPriceList.add(IdStrUtil.toMoneyUnitKr(((double.tryParse(item1.totalLandPrice!) ?? 0) / 10000).toString()));

        //테이블
        row1.add(item1.mainPurpose!);
        row1.add(item1.lotArea!);
        row1.add(item1.mainStruct!);
        row1.add(IdStrUtil.toMoneyUnitKr(((double.tryParse(item1.officialLandPrice!) ?? 0) / 10000).toString()));
        row1.add(IdStrUtil.toMoneyUnitKr(((double.tryParse(item1.totalLandPrice!) ?? 0) / 10000).toString()));
        results.add(row1);
      }
    } else {
      results = [
        ['', '', '', '', '']
      ];
    }
    setState(() {});
    return results;
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

  Widget textInputWidget(double width, String hint, TextEditingController controller, String keyboarType, bool enabledBool) {
    return IdInputValidation(
        width: width,
        height: 44,
        inputColor: directInputBool ? IdColors.white : IdColors.backgroundDefault,
        borderColor: directInputBool ? IdColors.borderDefault : IdColors.backgroundDefault,
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

  Widget inputWithLable(String title, String hint, TextEditingController controller, String keyboardType, bool enabledBool) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(title),
        textInputWidget(double.infinity, hint.replaceAll(',', ''), controller, keyboardType, enabledBool),
      ],
    );
  }

  void validateInput(String input1, String input2, String input3, String input4, String input5, String input6) {
    try {
      double value = (double.tryParse(input1) ?? 0) +
          (double.tryParse(input2) ?? 0) +
          (double.tryParse(input3) ?? 0) +
          (double.tryParse(input4) ?? 0) +
          (double.tryParse(input5) ?? 0) +
          (double.tryParse(input6) ?? 0);
      dataToJson();
      // 유효한 숫자인 경우에 대한 처리를 여기에 추가하세요.
    } catch (e) {
      activeToast('숫자로만 표현하는 부분이 있습니다. 확인해주세요.');
      // 숫자가 아닌 경우에 대한 처리를 여기에 추가하세요.
    }
    setState(() {});
  }

  Future<void> dataToJson() async {
    dealMasterItem!.pnu = pnu; //pnu
    //타입
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
    dealMasterItem!.address = '${_address1Controller.text} ${_address2Controller.text} ${_address3Controller.text}'; //주소
    dealMasterItem!.addressDtl = _address4Controller.text; //상세주소
    dealMasterItem!.areaPos = postCd; //우편번호
    dealMasterItem!.stationDistance = distance; //역까지 거리
    dealMasterItem!.stationName = station; //역

    //건물 정보
    dealBuildingItem!.bdUniqueId = bdUniqueId;
    dealBuildingItem!.buildingName = _building1Controller.text; //빌딩명
    dealBuildingItem!.lotArea = _building2Controller.text; //대지면적
    dealBuildingItem!.totalFloorArea = _building3Controller.text; //용도지역
    dealBuildingItem!.areaPurpose = _building4Controller.text; //용도지역
    dealBuildingItem!.totalFloorRatio = _building5Controller.text.replaceAll(',', ''); //용적률
    dealBuildingItem!.bdDistrictUnitPlan = _building6Controller.text; //지구단위계획구역
    dealBuildingItem!.bdCoverageRatio = _building7Controller.text.replaceAll(',', ''); //건폐율
    dealBuildingItem!.mainPurpose = _building8Controller.text; //주용도
    dealBuildingItem!.mainStruct = _building9Controller.text; //주구조
    dealBuildingItem!.ccd = _building10Controller.text.replaceAll(',', ''); //준공연도
    dealBuildingItem!.upperNum = _building11Controller.text.replaceAll(',', ''); //지상
    dealBuildingItem!.lowerNum = _building12Controller.text.replaceAll(',', '').replaceAll('B', ''); //지하
    dealBuildingItem!.elevator = _building13Controller.text.replaceAll(',', ''); //승강기
    dealBuildingItem!.parkingNum = _building14Controller.text.replaceAll(',', ''); //주차장
    dealBuildingItem!.officialLandPrice =
        ((double.tryParse(_building15Controller.text.replaceAll(',', '').replaceAll('억 ', '')) ?? 0) * 10000).toString(); //공시지가
    dealBuildingItem!.totalLandPrice =
        ((double.tryParse(_building16Controller.text.replaceAll(',', '').replaceAll('억 ', '')) ?? 0) * 10000).toString(); //공시지가 합계

    GV.pStrg.putXXX('dealMasterJson', jsonEncode(dealMasterItem!.toJson()));
    GV.pStrg.putXXX('dealBuildingJson', jsonEncode(dealBuildingItem!.toJson()));

    // GV.d(GV.pStrg.getXXX('dealMasterJson'));
    // GV.d(GV.pStrg.getXXX('dealBuildingJson'));

    uiCommon.IdMovePage(context, PAGE_DEAL_STEP_03_2_PAGE);
  }

  @override
  Widget idBuild(BuildContext context) {
    _buildingSvcDS = makeRows();
    Widget boardGrid123 = _buildingSvcDS.isNotEmpty
        ? IdGrid(
            width: 600 - 80,
            internalGrid: false,
            headerColumns: const ['주용도', '연면적', '주구조', '공시지가', '공시지가 합계'],
            columnWidthsPercentages: const <double>[20, 20, 20, 20, 20],
            headerBorderColor: IdColors.borderDefault,
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 16,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 58,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 60,
            rowCnt: totalCnt,
            headerCellRenderer: (idx, content) {
              return SizedBox(
                height: 51,
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    content,
                    style:
                        const TextStyle(color: IdColors.textDefault, fontFamily: 'Pretendard', fontSize: 16, fontWeight: FontWeight.w600),
                    softWrap: true,
                  )
                ]),
              );
            },
            headerBodyInterval: 6,
            headerDecoration: const BoxDecoration(
              color: IdColors.backgroundDefault,
              border: BorderDirectional(
                top: BorderSide(width: 2, color: IdColors.borderSecondly),
                bottom: BorderSide(width: 1, color: IdColors.borderDefault),
              ),
            ),
            rowDecoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(width: 1, color: IdColors.borderDefault))),
            rowInterval: 6,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowColor: IdColors.white,
            hoverColor: IdColors.green5,
            rowsCellRenderer: (row, cell, content) {
              return SizedBox(
                height: 60,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(content,
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          style:
                              TextStyle(fontWeight: FontWeight.w400, fontFamily: 'Pretendard', color: IdColors.textDefault, fontSize: 14),
                          softWrap: true),
                    ),
                  ],
                ),
              );
            },
            noContentWidget: const SizedBox(), //Center(child: Container(width: 30, height: 30, child: CircularProgressIndicator())),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              _building1Controller.text = boardBuildingNameList[index];
              _building2Controller.text = boardlotAreaList[index];
              _building3Controller.text = boardTotalFloorAreaList[index];
              _building4Controller.text = boardAeaPurposeList[index];
              _building5Controller.text = boardTotalFloorRatioList[index];
              _building6Controller.text = boardBdDistrictUnitPlanList[index];
              _building7Controller.text = boardBdCoverageRatioList[index];
              _building8Controller.text = boardMainPurposeList[index];
              _building9Controller.text = boardMainStructList[index];
              _building10Controller.text = boardCcdList[index];
              _building11Controller.text = boardUpperNumList[index];
              _building12Controller.text = boardLowerNumList[index];
              _building13Controller.text = boardElevatorList[index];
              _building14Controller.text = boardParkingNumList[index];
              _building15Controller.text = boardOfficialLandPriceList[index];
              _building16Controller.text = boardTotalLandPriceList[index];
              selectBuildingInfoPopup = false;
              setState(() {});
            },
            data: _buildingSvcDS)
        : Container();

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
                                height: 1334,
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
                                                          uiCommon.styledText(
                                                              'Deal 종류', 18, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealTypeStr == dealTypeList[0])
                                                              ? radioWithLable(true, IdColors.green2, '신축부지', IdColors.textDefault, false)
                                                              : radioWithLable(false, IdColors.green2, '신축부지', IdColors.textDisabled, true),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealTypeStr == dealTypeList[1])
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
                                                          (dealCategoryStr == dealCategoryList[0])
                                                              ? radioWithLable(true, IdColors.green2, '매각', IdColors.textDefault, false)
                                                              : radioWithLable(false, IdColors.green2, '매각', IdColors.textDisabled, true),
                                                          const IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                          (dealCategoryStr == dealCategoryList[1])
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
                                                titleWidget('<fb2>*</fb2> 등록자'),
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
                                                titleWidget('<fb>*</fb> 소재지'),
                                                Row(
                                                  children: [
                                                    addressInput('특별시/광역시/도', _address1Controller),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    addressInput('시/구', _address2Controller),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    addressInput('읍/면/동', _address3Controller),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    IdNormalBtn(
                                                      onBtnPressed: () {
                                                        addressPopup = true;
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
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 10),
                                                //인풋버튼2
                                                Row(
                                                  children: [
                                                    IdInputValidation(
                                                        width: 580,
                                                        height: 44,
                                                        inputColor: IdColors.backgroundDefault,
                                                        round: 8,
                                                        controller: _address4Controller,
                                                        textAlign: 'start',
                                                        hintText: '',
                                                        hintTextFontSize: 16,
                                                        hintTextfontWeight: FontWeight.w500,
                                                        hintTextFontColor: IdColors.textTertiary,
                                                        keyboardType: 'text',
                                                        validationText: '',
                                                        validationVisible: false,
                                                        vlaidationCheck: false,
                                                        enabledBool: false),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
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
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                //건물 상세 내용
                                                inputWithLable('건물명', '', _building1Controller, 'text', directInputBool),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: inputWithLable(
                                                          '대지면적<unit>(㎡)</unit>', '', _building2Controller, 'number2', directInputBool),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: inputWithLable(
                                                          '연면적<unit>(㎡)</unit>', '', _building3Controller, 'number2', directInputBool),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: inputWithLable('용도지역', '', _building4Controller, 'text', directInputBool),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: inputWithLable(
                                                          '용적률<unit>(%)</unit>', '', _building5Controller, 'number2', directInputBool),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: inputWithLable('지구단위계획구역', '', _building6Controller, 'text', directInputBool),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: inputWithLable(
                                                          '건폐율<unit>(%)</unit>', '', _building7Controller, 'number2', directInputBool),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: inputWithLable('주용도', '', _building8Controller, 'text', directInputBool),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: inputWithLable('주구조', '', _building9Controller, 'text', directInputBool),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: inputWithLable('준공연도', '', _building10Controller, 'text', directInputBool),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          titleWidget('지상/지하'),
                                                          Row(
                                                            children: [
                                                              Expanded(
                                                                child: textInputWidget(
                                                                    double.infinity, '', _building11Controller, 'text', directInputBool),
                                                              ),
                                                              SizedBox(
                                                                width: 15,
                                                                child: Center(
                                                                  child: uiCommon.styledText('/', 18, 0, 1, FontWeight.w400,
                                                                      IdColors.textSecondly, TextAlign.left),
                                                                ),
                                                              ),
                                                              Expanded(
                                                                child: textInputWidget(
                                                                    double.infinity, '', _building12Controller, 'text', directInputBool),
                                                              ),
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
                                                      child: inputWithLable(
                                                          '승강기<unit>(대)</unit>', '', _building13Controller, 'text', directInputBool),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: inputWithLable(
                                                          '주차장<unit>(대)</unit>', '', _building14Controller, 'text', directInputBool),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Row(
                                                  children: [
                                                    Expanded(
                                                      child: inputWithLable(
                                                          '공시지가<unit>(만원)</unit>', '', _building15Controller, 'number2', directInputBool),
                                                    ),
                                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                    Expanded(
                                                      child: inputWithLable('공시지가 합계<unit>(만원)</unit>', '', _building16Controller,
                                                          'number2', directInputBool),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                                IdDealRegistBottomBtn(
                                                  beforeBtnFunction: () {
                                                    uiCommon.IdMovePage(context, PAGE_DEAL_STEP_01_PAGE);
                                                  },
                                                  btn1: '이전',
                                                  afterBtnFunction: () {
                                                    if (registrantBoolList.contains(true)) {
                                                      if (registrantBoolList[3] == true) {
                                                        if (_registrantController.text == '') {
                                                          activeToast('어떤 등록자인지 작성해 주세요.');
                                                        } else {
                                                          if (_address1Controller.text == '' ||
                                                              _address2Controller.text == '' ||
                                                              _address3Controller.text == '' ||
                                                              _address4Controller.text == '') {
                                                            activeToast('주소를 입력해 주세요.');
                                                          } else {
                                                            if (_building1Controller.text == '' &&
                                                                _building2Controller.text == '' &&
                                                                _building3Controller.text == '' &&
                                                                _building4Controller.text == '' &&
                                                                _building5Controller.text == '' &&
                                                                _building6Controller.text == '' &&
                                                                _building7Controller.text == '' &&
                                                                _building8Controller.text == '' &&
                                                                _building9Controller.text == '' &&
                                                                _building10Controller.text == '' &&
                                                                _building11Controller.text == '' &&
                                                                _building12Controller.text == '' &&
                                                                _building13Controller.text == '' &&
                                                                _building14Controller.text == '' &&
                                                                _building15Controller.text == '' &&
                                                                _building16Controller.text == '') {
                                                              activeToast('건물 데이터를 넣어주세요.');
                                                            } else {
                                                              dataToJson();
                                                            }
                                                          }
                                                        }
                                                      } else {
                                                        if (_address1Controller.text == '' ||
                                                            _address2Controller.text == '' ||
                                                            _address3Controller.text == '' ||
                                                            _address4Controller.text == '') {
                                                          activeToast('주소를 입력해 주세요.');
                                                        } else {
                                                          if (_building1Controller.text == '' &&
                                                              _building2Controller.text == '' &&
                                                              _building3Controller.text == '' &&
                                                              _building4Controller.text == '' &&
                                                              _building5Controller.text == '' &&
                                                              _building6Controller.text == '' &&
                                                              _building7Controller.text == '' &&
                                                              _building8Controller.text == '' &&
                                                              _building9Controller.text == '' &&
                                                              _building10Controller.text == '' &&
                                                              _building11Controller.text == '' &&
                                                              _building12Controller.text == '' &&
                                                              _building13Controller.text == '' &&
                                                              _building14Controller.text == '' &&
                                                              _building15Controller.text == '' &&
                                                              _building16Controller.text == '') {
                                                            activeToast('건물 데이터를 넣어주세요.');
                                                          } else {
                                                            validateInput(
                                                                _building2Controller.text,
                                                                _building3Controller.text,
                                                                _building5Controller.text,
                                                                _building7Controller.text,
                                                                _building15Controller.text,
                                                                _building16Controller.text);
                                                          }
                                                        }
                                                      }
                                                    } else {
                                                      activeToast('등록자를 선택해주세요.');
                                                    }
                                                  },
                                                  btn2: '다음',
                                                ),
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
                // Visibility(
                //   visible: toastVisible,
                //   child: Positioned(
                //     top: 0,
                //     left: 0,
                //     right: 0,
                //     child: IdTopToast(toastMessage: toastMessageStr),
                //   ),
                // ),
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
                              _address1Controller.text = kakaoAddress.jibunAddress.split(' ')[0];
                              _address2Controller.text = kakaoAddress.jibunAddress.split(' ')[1];
                              _address3Controller.text = kakaoAddress.jibunAddress.split(' ')[2];
                              _address4Controller.text = kakaoAddress.jibunAddress.split(' ')[3];
                              jibunAddress = kakaoAddress.jibunAddress;
                              bname = kakaoAddress.bname;
                              postCd = kakaoAddress.postCode;
                              setState(() {});
                              fetchData();
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
                  visible: selectBuildingInfoPopup,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: IdColors.black8Per,
                      child: Center(
                        child: Container(
                          width: 600,
                          height: 450,
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
                              )
                            ],
                          ),
                          child: SingleChildScrollView(
                            scrollDirection: Axis.vertical,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: uiCommon.styledText('주소 선택', 32, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                                    ),
                                    IdNormalBtn(
                                      onBtnPressed: () {
                                        selectBuildingInfoPopup = false;
                                        setState(() {});
                                      },
                                      childWidget: const IdImageBox(
                                          imagePath: 'assets/img/icon_close_big.png',
                                          imageWidth: 32,
                                          imageHeight: 32,
                                          imageFit: BoxFit.cover),
                                    ),
                                  ],
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                SizedBox(
                                  width: double.infinity,
                                  child: boardGrid123,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: alertPopup,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: Color.fromRGBO(0, 0, 0, 0),
                      child: Center(
                        child: AlertPopup(
                          alertBody: '해당 주소에 관한 데이터가 없습니다.',
                          onBtnPressedLeft: () {
                            alertPopup = false;
                            setState(() {});
                          },
                          onBtnPressedRight: () {
                            alertPopup = false;
                            setState(() {});
                          },
                        ),
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
