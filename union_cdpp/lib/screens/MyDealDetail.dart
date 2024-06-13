import 'dart:typed_data';
import 'package:croppy/croppy.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/common/utils.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdGrid.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdImageBox2.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageTopSection.dart';
import 'package:unionCDPP/id_widget/IdPagination.dart';
import 'package:unionCDPP/id_widget/IdPjtListDropdown.dart';
import 'package:unionCDPP/id_widget/IdRadio.dart';
import 'package:unionCDPP/id_widget/IdRentrollEditBoard.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdStatus.dart';
import 'package:unionCDPP/id_widget/IdSubNavigator.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/id_widget/IdWithMoreBtn.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:unionCDPP/id_widget/KakaoAddress/kakao_address_widget.dart';
import 'package:unionCDPP/modelVO/commonCdResponse.dart';
import 'package:unionCDPP/modelVO/dealBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealBuildingResponse.dart';
import 'package:unionCDPP/modelVO/dealLandItem.dart';
import 'package:unionCDPP/modelVO/dealLotResponse.dart';
import 'package:unionCDPP/modelVO/dealMasterItem.dart';
import 'package:unionCDPP/modelVO/dealNewBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealRentRollItem.dart';
import 'package:unionCDPP/modelVO/memoResponse.dart';
import 'package:unionCDPP/modelVO/myDealDetailBuildingItem.dart';
import 'package:unionCDPP/modelVO/myDealDetailLandItem.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';
import 'package:unionCDPP/popup/addressPopup.dart';
import 'package:unionCDPP/popup/mapPopup.dart';
import 'package:unionCDPP/popup/memoPopup.dart';

class _DummyList {
  MemoResponse? data;
}

class _CommonCdList {
  CommonCdResponse? data;
}

class MyDealDetail extends StatefulWidget {
  const MyDealDetail({super.key});

  @override
  IdState<MyDealDetail> createState() => _MyDealDetailState();
}

class _MyDealDetailState extends IdState<MyDealDetail> {
  List<List<String>> _memoSvcDS = [];
  List<_DummyList> _memoDs = [];
  List<_CommonCdList> _commonCd1Item = [];
  List<_CommonCdList> _commonCd2Item = [];
  List<DealRentRollItem> rentrollList = [];
  DealNewBuildingItem? dealNewBuildingItem;
  DealLotResponse? dealLotResponse;
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List submenuNameList = [];
  List submenuNavigatorLink = [];

  int totalPage = 0;
  int acturalPage = 1;

  int currentRowsCnt = 0;
  int totalRowsCnt = 0;

  double imgSize = 0;

  TextEditingController _memoController = TextEditingController();
  TextEditingController _fileController = TextEditingController();

  //공통 텍스트 컨트롤러(이미지)
  TextEditingController _additionalEtcController = TextEditingController();
  TextEditingController _img1DescController = TextEditingController();
  TextEditingController _img2DescController = TextEditingController();
  TextEditingController _img3DescController = TextEditingController();
  TextEditingController _img4DescController = TextEditingController();
  TextEditingController _img5DescController = TextEditingController();
  TextEditingController _img6DescController = TextEditingController();
  TextEditingController _img7DescController = TextEditingController();
  TextEditingController _img8DescController = TextEditingController();
  TextEditingController _img9DescController = TextEditingController();
  TextEditingController _img10DescController = TextEditingController();
  TextEditingController _TM_InfoController = TextEditingController(); //TM자료
  TextEditingController _floorPlanController = TextEditingController(); //도면
  TextEditingController _otherController = TextEditingController(); //기타

//공통2
  TextEditingController _addressController = TextEditingController(); //소재지
  TextEditingController _registrantController = TextEditingController(); //등록자
  TextEditingController _askingController = TextEditingController(); //희망매각가
  TextEditingController _evacuationPeriodController = TextEditingController(); //명도기간
  TextEditingController _stationController = TextEditingController(); //역이름
  TextEditingController _stationDistanceController = TextEditingController(); //역까지 거리

  //lotList Controller
  TextEditingController _lotAreaController = TextEditingController();
  TextEditingController _lotAreaPyController = TextEditingController();
  TextEditingController _areaPurpoesController = TextEditingController();
  TextEditingController _sellPriceController = TextEditingController();
  TextEditingController _officialLandPriceController = TextEditingController();
  TextEditingController _totalLandPriceController = TextEditingController();
  TextEditingController _totalSellPriceController = TextEditingController();

  //신축예상규모
  TextEditingController _landUseController = TextEditingController();
  TextEditingController _totalFloorRatioController = TextEditingController();
  TextEditingController _buildingCoverageController = TextEditingController();
  TextEditingController _buildingAreaController = TextEditingController();
  TextEditingController _totalFloorAreaController = TextEditingController();
  TextEditingController _upperFloorAreaController = TextEditingController();
  TextEditingController _upperNumController = TextEditingController();
  TextEditingController _lowerNumController = TextEditingController();
  TextEditingController _parkingNumController = TextEditingController();
  TextEditingController _elevatorController = TextEditingController();
  TextEditingController _NeBuildingEtcController = TextEditingController();

  //건물정보
  TextEditingController _buildingNameController = TextEditingController();
  TextEditingController _mainPurposeController = TextEditingController();
  TextEditingController _bdCoverageRatioController = TextEditingController();
  TextEditingController _bdDistrictUnitPlanController = TextEditingController();
  TextEditingController _mainStructController = TextEditingController();
  TextEditingController _ccdController = TextEditingController();
  TextEditingController _depositeController = TextEditingController();
  TextEditingController _monthlyController = TextEditingController();
  TextEditingController _rommNumController = TextEditingController();
  TextEditingController _remodellingController = TextEditingController();
  TextEditingController _buildingEtcController = TextEditingController();

//메모등록에 쓰는거
  bool memoPopupVisible = false; //메모 팝업 보여주는거
  Uint8List memoFile = Uint8List(0); //메모 파일첨부

//기본적으로 이게 있어야 이 페이지가 돌아감
  String userNo = GV.pStrg.getXXX(Param_commonUserNo);
  String dealNo = GV.pStrg.getXXX(Param_myDealNo);
  String type = GV.pStrg.getXXX(Param_dealType);

  //디테일 정보
  String pnu = '';
  String pageTitle = '';
  List pjtList = [];
  List pjtColorList = [];
  String masterAsking = '';
  String status1 = '';
  String status2 = '';
  String status3 = '';
  String category = '';
  String additional = '';
  String bdAdditional = '';
  String additionalEtc = '';
  String tmName = '';
  String floorPlanImgName = '';
  String otherImgname = '';
  String register = '';
  String address = '';
  String areapos = '';
  String dealLandNo = '';
  String buildingName = '';
  String lotArea = '';
  String totalFloorArea = '';
  String areaPurpose = '';
  String totalFloorRatio = '';
  String bdCoverageRatio = '';
  String bdDistrictUnitPlan = '';
  String mainPurpose = '';
  String mainStruct = '';
  String ccd = '';
  String lowerNum = '';
  String upperNum = '';
  String elevator = '';
  String parkingNum = '';
  String officialLandPrice = '';
  String totalLandPrice = '';
  String asking = '';
  String negotiationType = '';
  String assetStatus = '';
  String evacuationType = '';
  String evacuationPeriod = '';
  String evacuationChk = '';
  String owner = '';
  String deposit = '';
  String depositChk = '';
  String monthly = '';
  String monthlyChk = '';
  String loan = '';
  String roomNum = '';
  String reModel = '';
  String stationName = '';
  String stationDistance = '';
  String landUsage = '';
  String buildingCoverage = '';
  String buildingArea = '';
  String upperFloorArea = '';
  String landEtc = '';
  String latitude = '';
  String longitude = '';
//etc
  List lotInfoList = []; //lot리스트 초기화
  String lotInfoAskingInclude = ''; //lot 리스트 매도가격 포함인지 아닌지 확인하기 위한거
  List imgDescList = ['', '', ' ', '', '', '', '', '', '', '']; //10개 이미지의 이름 리스트
  List rentRollList = []; // 0-층, 1-업종, 2-면적, 3-보증금, 4-입대료, 5-비고
  List registrantList = ['중개사', '소유주', '시행사', '기타']; //등록자 리스트
  List registrantBoolList = [false, false, false, false]; //등록자 라디오 상태
  List ownerList = ['개인/법인', '시행사', '브릿지/PF']; //소유자 리스트
  List negotiateList = ['가능', '불가능', '협의']; //명도 리스트
  List dispossessList = ['전층책임명도', '일부책임명도', '불가능', '협의'];
  List assetList = ['명도예정/명도중', '공실', '나대지', '인허가/착공']; //자산 리스트

  int ownerINT = 0; //소유자 리스트 상태
  int negotiateINT = 0; //협의 리스트 상태
  int assetINT = 0; //자산 리스트 상태
  int dispossessINT = 0; //명도 리스트 상태
  int remodelInt = 0;
  String dropDownValue = '';

  String dealStatus = ''; //딜 상태 코드로

  bool mapPopupVisible = false;

  var _focusDropDown = FocusNode();
  bool changeDropdown = false;
  List<DropdownMenuItem> _items = [];

  Image? uploadImg1; //이미지 임시파일에 올린거 확인용 화면 뿌려주는 거

//TODO test끝날때까지는 true
  bool editAction = false; //수정 버튼 누른후 ACTION
  bool depositChkBool = false;
  bool evacuationChkBool = false;
  bool monthlyChkBool = false;

  List<int> areaNumList = []; //위치 특이사항 상태 리스트
  List<String> areaCDList = []; //위치 특이사항 코드 리스트
  List<String> areaList = []; //위치 특이사항 이름 리스트

  List<int> buildingNumList = []; //건물 특이사항 상태 리스트
  List<String> buildingCDList = []; //건물 특이사항 코드 리스트
  List<String> buildingList = []; //건물 특이사항 이름 리스트

//이미지, 파일 업로드에 필요한 파라미터
  List<RawImage?> imgList = [null, null, null, null, null, null, null, null, null, null, null, null, null];
  List<dynamic> fileList = [];
  List<int> fileNumList = [];
  int nullCount = 13;
  List<TextEditingController> imgDescControllerList = [];

  List realImgList = ['', '', '', '', '', '', '', '', '', '', '', '', ''];

//주소새로 하고 나서  필요한 파라미터
  int lotListNum = 0;
  int clickLotRowNum = 0;
  bool addressPopup = false;
  String jibunAddress = '';
  String popupTitle = '';
  bool lotAreaPopupVisible = false;
  bool lotAreaPyPopupVisible = false;
  bool areaPurposePopupVisible = false;
  bool sellPricePopupVisible = false;
  bool officialPricePopupVisible = false;
  bool totalPricePopupVisible = false;

  List<dynamic> lotListTojson = [];
  List<dynamic> rentRollListTojson = [];
  List<IdRentRollEditBoard> rentRolls = [IdRentRollEditBoard(text1: '', text2: '', text3: '', text4: '', text5: '', text6: '')];
  List rentRollsList = [];

  bool dealStatusSelectVisible = false;

  @override
  void initState() {
    super.initState();

    _memoDs.add(_DummyList());
    _commonCd1Item.add(_CommonCdList());
    _commonCd2Item.add(_CommonCdList());
    dealLotResponse = DealLotResponse();
    menuNavigator = ['home', 'My Page', '내가 등록한 딜'];
    menuNavigatorLink = [
      () {
        // uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
      },
      () {
        // uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
      }
    ];
    submenuNameList = ['내 정보', '내가 등록한 딜', '알림'];
    submenuNavigatorLink = [
      () {
        uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
      },
      () {
        uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
      },
      () {
        uiCommon.IdMovePage(context, PAGE_MYALARM_PAGE);
      }
    ];

    imgDescControllerList = [
      _img1DescController,
      _img2DescController,
      _img3DescController,
      _img4DescController,
      _img5DescController,
      _img6DescController,
      _img7DescController,
      _img8DescController,
      _img9DescController,
      _img10DescController,
      _TM_InfoController,
      _floorPlanController,
      _otherController
    ];
    itemList();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _memoController.dispose();
    _fileController.dispose();
    _additionalEtcController.dispose();
    _registrantController.dispose();
  }

  Future<void> fetchData() async {
    //공통코드
    final CommonCdResponse ret3 = await IdApi.getCommonCd1();
    final CommonCdResponse ret4 = await IdApi.getCommonCd2();
    if (ret3 != null) {
      _commonCd1Item[0].data = ret3;
      for (var i = 0; i < _commonCd1Item[0].data!.list!.length; i++) {
        areaCDList.add(_commonCd1Item[0].data!.list![i].cd!);
        areaList.add(_commonCd1Item[0].data!.list![i].cdName!);
        areaNumList.add(0);
      }
    }
    if (ret4 != null) {
      _commonCd2Item[0].data = ret4;
      for (var i = 0; i < _commonCd2Item[0].data!.list!.length; i++) {
        buildingCDList.add(_commonCd2Item[0].data!.list![i].cd!);
        buildingList.add(_commonCd2Item[0].data!.list![i].cdName!);
        buildingNumList.add(0);
      }
    }
    if (type == "L") {
      final MyDealDetailLandItem? ret1 = await IdApi.getMydaelDetail(userNo, dealNo, type);
      if (ret1 != null) {
        latitude = ret1.dealMaster!.latitude!;
        longitude = ret1.dealMaster!.longitude!;
        pnu = ret1.lotList![0].pnu!;
        pageTitle = ret1.dealMaster!.title!;
        status1 = ret1.dealMaster!.gubun!;
        if (ret1.dealMaster!.dealStatus == '1') {
          status2 = '거래중';
          dealStatus = '1';
        } else if (ret1.dealMaster!.dealStatus == '2') {
          status2 = '거래완료';
          dealStatus = '2';
        } else {
          status2 = '보류';
          dealStatus = '0';
        }
        category = ret1.dealMaster!.category!;

        additional = ret1.dealMaster!.additional!
            .replaceAll('ROADSIDE', '대로변')
            .replaceAll('STATION_DISTRICT', '역세권')
            .replaceAll('UNIVERSITY_AREA', '대학가')
            .replaceAll('COMMERCIAL_DISTRICT', '상권')
            .replaceAll('TOURIST_AREA', '관광지역')
            .replaceAll('LARGE_PARK', '대형공원');

        if (ret1.dealMaster!.additional!.contains('ROADSIDE')) {
          areaNumList[0] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('STATION_DISTRICT')) {
          areaNumList[1] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('UNIVERSITY_AREA')) {
          areaNumList[2] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('COMMERCIAL_DISTRICT')) {
          areaNumList[3] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('TOURIST_AREA')) {
          areaNumList[4] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('LARGE_PARK')) {
          areaNumList[5] = 1;
        }

        if (ret1.dealMaster!.additionalEtc! == '') {
          additionalEtc = '-';
        } else {
          additionalEtc = ret1.dealMaster!.additionalEtc!;
        }
        _additionalEtcController.text = additionalEtc;

        if (ret1.fileList!.isNotEmpty) {
          for (var i = 0; i < ret1.fileList!.length; i++) {
            int imgNum = (int.tryParse(ret1.fileList![i].fileOrder!) ?? (i + 1)) - 1;
            if (imgNum == 0) {
              imgDescList[imgNum] = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 1 || imgNum == 2 || imgNum == 3) {
              imgDescList[imgNum] = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 4 || imgNum == 5 || imgNum == 6 || imgNum == 7 || imgNum == 8 || imgNum == 9) {
              imgDescList[imgNum] = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 10) {
              tmName = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 11) {
              floorPlanImgName = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 12) {
              otherImgname = ret1.fileList![i].fileDoc!;
            }
            realImgList[(int.tryParse(ret1.fileList![i].fileOrder!) ?? (i + 1)) - 1] = '${ret1.fileList![i].s3FileUrl!}';
          }
        }
        //10개 이미지 텍스트박스 컨트롤러에 넣기
        _img1DescController.text = imgDescList[0];
        _img2DescController.text = imgDescList[1];
        _img3DescController.text = imgDescList[2];
        _img4DescController.text = imgDescList[3];
        _img5DescController.text = imgDescList[4];
        _img6DescController.text = imgDescList[5];
        _img7DescController.text = imgDescList[6];
        _img8DescController.text = imgDescList[7];
        _img9DescController.text = imgDescList[8];
        _img10DescController.text = imgDescList[9];
        _TM_InfoController.text = tmName;
        _floorPlanController.text = floorPlanImgName;
        _otherController.text = otherImgname;

        if (ret1.dealMaster!.register! == '1') {
          register = '중개사';
          registrantBoolList[0] = true;
        } else if (ret1.dealMaster!.register! == '2') {
          register = '소유주';
          registrantBoolList[1] = true;
        } else if (ret1.dealMaster!.register! == '3') {
          register = '시행사';
          registrantBoolList[2] = true;
        } else {
          registrantBoolList[3] = true;
          register = ret1.dealMaster!.registerEtc!;
          _registrantController.text = register;
        }
        address = '${ret1.dealMaster!.address!} ${ret1.dealMaster!.addressDtl!}';
        _addressController.text = address;

        areapos = ret1.dealMaster!.areaPos!;

        lotInfoList = [];
        for (var i = 0; i < ret1.lotList!.length; i++) {
          if (i == 0) {
            if (ret1.lotList![0].asking == null) {
              lotInfoList.add([
                ret1.lotList![0].address,
                double.tryParse(ret1.lotList![0].lotArea!) ?? 0,
                double.tryParse(ret1.lotList![0].lotAreaPy!) ?? 0,
                ret1.lotList![0].areaPurpose,
                (double.tryParse(ret1.lotList![0].officialLandPrice!) ?? 0) / 10000,
                (double.tryParse(ret1.lotList![0].totalLandPrice!) ?? 0) / 10000,
                0,
              ]);
            } else {
              lotInfoList.add([
                ret1.lotList![0].address,
                double.tryParse(ret1.lotList![0].lotArea!) ?? 0,
                double.tryParse(ret1.lotList![0].lotAreaPy!) ?? 0,
                ret1.lotList![0].areaPurpose,
                (double.tryParse(ret1.lotList![0].officialLandPrice!) ?? 0) / 10000,
                (double.tryParse(ret1.lotList![0].totalLandPrice!) ?? 0) / 10000,
                (double.tryParse(ret1.lotList![0].asking!) ?? 0) / 100000000,
              ]);
            }
            lotInfoAskingInclude = '포함';
          } else {
            if (ret1.lotList![i].asking == null || ret1.lotList![i].asking == '0') {
              lotInfoList.add([
                ret1.lotList![i].address,
                double.tryParse(ret1.lotList![i].lotArea!) ?? 0,
                double.tryParse(ret1.lotList![i].lotAreaPy!) ?? 0,
                ret1.lotList![i].areaPurpose,
                (double.tryParse(ret1.lotList![i].officialLandPrice!) ?? 0) / 10000,
                (double.tryParse(ret1.lotList![i].totalLandPrice!) ?? 0) / 10000,
                0,
              ]);
              lotInfoAskingInclude = '포함';
            } else {
              lotInfoList.add([
                ret1.lotList![i].address,
                double.tryParse(ret1.lotList![i].lotArea!) ?? 0,
                double.tryParse(ret1.lotList![i].lotAreaPy!) ?? 0,
                ret1.lotList![i].areaPurpose,
                (double.tryParse(ret1.lotList![i].officialLandPrice!) ?? 0) / 10000,
                (double.tryParse(ret1.lotList![i].totalLandPrice!) ?? 0) / 10000,
                (double.tryParse(ret1.lotList![0].asking!) ?? 0) / 100000000,
              ]);
              lotInfoAskingInclude = '별도';
            }
          }
        }
        if (ret1.dealMaster!.asking == null) {
          masterAsking = '0';
        } else {
          masterAsking = ((double.tryParse(ret1.dealMaster!.asking!) ?? 0) / 100000000).toString();
        }
        _askingController.text = masterAsking;

        if (ret1.dealMaster!.negotiationType == '1') {
          negotiationType = '가능';
          negotiateINT = 1;
        } else if (ret1.dealMaster!.negotiationType == '2') {
          negotiationType = '불가능';
          negotiateINT = 2;
        } else {
          negotiationType = '협의';
          negotiateINT = 3;
        }

        if (ret1.dealMaster!.evacuationType == '0') {
          evacuationType = '0';
        } else if (ret1.dealMaster!.evacuationType == '1') {
          evacuationType = '1';
        } else if (ret1.dealMaster!.evacuationType == '2') {
          evacuationType = '2';
        } else if (ret1.dealMaster!.evacuationType == '3') {
          evacuationType = '3';
        } else if (ret1.dealMaster!.evacuationType == '4') {
          evacuationType = '4';
        } else {
          evacuationType = '0';
        }

        if (ret1.dealMaster!.assetStatus == '1') {
          assetStatus = '명도예정/명도중';
          assetINT = 1;
        } else if (ret1.dealMaster!.assetStatus == '2') {
          assetStatus = '공실';
          assetINT = 2;
        } else if (ret1.dealMaster!.assetStatus == '3') {
          assetStatus = '나대지';
          assetINT = 3;
        } else if (ret1.dealMaster!.assetStatus == '4') {
          assetStatus = '인허가/착공';
          assetINT = 4;
        } else {
          assetStatus = '-';
          assetINT = 0;
        }
        evacuationPeriod = ret1.dealMaster!.evacuationPeriod!;
        _evacuationPeriodController.text = evacuationPeriod;

        evacuationChk = ret1.dealMaster!.evacuationChk!;
        if (evacuationChk == "N") {
          evacuationChkBool = false;
        } else {
          evacuationChkBool = true;
        }

        if (ret1.dealMaster!.owner == null && ret1.land!.owner == null) {
          owner = '-';
        } else {
          if (ret1.dealMaster!.owner == '1' || ret1.land!.owner == '1') {
            owner = '개인/법인';
            ownerINT = 1;
          } else if (ret1.dealMaster!.owner == '2' || ret1.land!.owner == '2') {
            owner = '시행사';
            ownerINT = 2;
          } else if (ret1.dealMaster!.owner == '3' || ret1.land!.owner == '3') {
            owner = '브릿지/PF';
            ownerINT = 3;
          }
        }

        stationName = ret1.dealMaster!.stationName!;
        _stationController.text = stationName;

        stationDistance = ret1.dealMaster!.stationDistance!;
        _stationDistanceController.text = stationDistance;

        dealLandNo = ret1.land!.dealLandNo!;

        landUsage = ret1.land!.landUsage!;
        _landUseController.text = landUsage;

        totalFloorRatio = ret1.land!.totalFloorRatio!;
        _totalFloorRatioController.text = totalFloorRatio;

        buildingCoverage = ret1.land!.buildingCoverage!;
        _buildingCoverageController.text = buildingCoverage;

        buildingArea = ret1.land!.buildingArea!;
        _buildingAreaController.text = buildingArea;

        totalFloorArea = ret1.land!.totalFloorArea!;
        _totalFloorAreaController.text = totalFloorArea;

        upperFloorArea = ret1.land!.upperFloorArea!;
        _upperFloorAreaController.text = upperFloorArea;

        upperNum = ret1.land!.upperNum!;
        _upperNumController.text = upperNum;

        lowerNum = ret1.land!.lowerNum!;
        _lowerNumController.text = lowerNum;

        parkingNum = ret1.land!.parkingNum!;
        _parkingNumController.text = parkingNum;
        elevator = ret1.land!.elevator!;
        _elevatorController.text = elevator;

        landEtc = ret1.land!.etc!;
        _NeBuildingEtcController.text = landEtc;

        lotListTojson = ret1.lotList!;
        fileList = ret1.fileList!;

        for (var i = 0; i < ret1.fileList!.length; i++) {
          fileNumList.add(int.tryParse(ret1.fileList![i].fileOrder!) ?? (i + 1));
        }

        if (ret1.dealMaster!.labelList != null) {
          for (var i = 0; i < ret1.dealMaster!.labelList!.length; i++) {
            pjtList.add(ret1.dealMaster!.labelList![i].label!);
            pjtColorList.add(ret1.dealMaster!.labelList![i].labelColor!);
          }
        }
      }
    } else {
      final MyDealDetailBuildingItem? ret1 = await IdApi.getMydaelDetail(userNo, dealNo, type);

      if (ret1 != null) {
        latitude = ret1.dealMaster!.latitude!;
        longitude = ret1.dealMaster!.longitude!;
        pageTitle = ret1.dealMaster!.title!;
        status1 = ret1.dealMaster!.gubun!;

        if (ret1.dealMaster!.dealStatus == '1') {
          status2 = '거래중';
          dealStatus = '1';
        } else if (ret1.dealMaster!.dealStatus == '2') {
          status2 = '거래완료';
          dealStatus = '2';
        } else {
          status2 = '보류';
          dealStatus = '0';
        }

        category = ret1.dealMaster!.category!;

        additional = ret1.dealMaster!.additional!
            .replaceAll('ROADSIDE', '대로변')
            .replaceAll('STATION_DISTRICT', '역세권')
            .replaceAll('UNIVERSITY_AREA', '대학가')
            .replaceAll('COMMERCIAL_DISTRICT', '상권')
            .replaceAll('TOURIST_AREA', '관광지역')
            .replaceAll('LARGE_PARK', '대형공원');
        if (ret1.dealMaster!.additional!.contains('ROADSIDE')) {
          areaNumList[0] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('STATION_DISTRICT')) {
          areaNumList[1] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('UNIVERSITY_AREA')) {
          areaNumList[2] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('COMMERCIAL_DISTRICT')) {
          areaNumList[3] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('TOURIST_AREA')) {
          areaNumList[4] = 1;
        }
        if (ret1.dealMaster!.additional!.contains('LARGE_PARK')) {
          areaNumList[5] = 1;
        }
        if (ret1.dealMaster!.additionalEtc! == '') {
          additionalEtc = '-';
          _additionalEtcController.text = '-';
        } else {
          additionalEtc = ret1.dealMaster!.additionalEtc!;
          _additionalEtcController.text = ret1.dealMaster!.additionalEtc!;
        }

        if (ret1.fileList!.isNotEmpty) {
          for (var i = 0; i < ret1.fileList!.length; i++) {
            int imgNum = (int.tryParse(ret1.fileList![i].fileOrder!) ?? (i + 1)) - 1;
            if (imgNum == 0) {
              imgDescList[imgNum] = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 1 || imgNum == 2 || imgNum == 3) {
              imgDescList[imgNum] = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 4 || imgNum == 5 || imgNum == 6 || imgNum == 7 || imgNum == 8 || imgNum == 9) {
              imgDescList[imgNum] = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 10) {
              tmName = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 11) {
              floorPlanImgName = ret1.fileList![i].fileDoc!;
            } else if (imgNum == 12) {
              otherImgname = ret1.fileList![i].fileDoc!;
            }
            realImgList[(int.tryParse(ret1.fileList![i].fileOrder!) ?? (i + 1)) - 1] = '${ret1.fileList![i].s3FileUrl!}';
          }
        }

        //10개 이미지 텍스트박스 컨트롤러에 넣기
        _img1DescController.text = imgDescList[0];
        _img2DescController.text = imgDescList[1];
        _img3DescController.text = imgDescList[2];
        _img4DescController.text = imgDescList[3];
        _img5DescController.text = imgDescList[4];
        _img6DescController.text = imgDescList[5];
        _img7DescController.text = imgDescList[6];
        _img8DescController.text = imgDescList[7];
        _img9DescController.text = imgDescList[8];
        _img10DescController.text = imgDescList[9];
        _TM_InfoController.text = tmName;
        _floorPlanController.text = floorPlanImgName;
        _otherController.text = otherImgname;

        if (ret1.dealMaster!.register! == '1') {
          register = '중개사';
          registrantBoolList[0] = true;
        } else if (ret1.dealMaster!.register! == '2') {
          register = '소유주';
          registrantBoolList[1] = true;
        } else if (ret1.dealMaster!.register! == '3') {
          register = '시행사';
          registrantBoolList[2] = true;
        } else {
          register = ret1.dealMaster!.registerEtc!;
          registrantBoolList[3] = true;
          _registrantController.text = ret1.dealMaster!.registerEtc!;
        }

        address = '${ret1.dealMaster!.address!} ${ret1.dealMaster!.addressDtl!}';
        _addressController.text = '${ret1.dealMaster!.address!} ${ret1.dealMaster!.addressDtl!}';

        if (ret1.dealMaster!.asking == null) {
          masterAsking = '0';
        } else {
          masterAsking = ((double.tryParse(ret1.dealMaster!.asking!) ?? 0) / 100000000).toString();
          _askingController.text = masterAsking;
        }

        if (ret1.building!.pnu != null) {
          pnu = ret1.building!.pnu!;
        } else {
          pnu = '';
          fetchData2();
        }

        bdAdditional = ret1.building!.bdAdditional!
            .replaceAll('NEW_BUILD', '신축')
            .replaceAll('HIGH_VIS', '가시성')
            .replaceAll('MANY_WINDOWS', '창문 많음')
            .replaceAll('URGENT_SALE', '급매');

        buildingName = ret1.building!.buildingName!;
        _buildingNameController.text = ret1.building!.buildingName!;

        lotArea = ret1.building!.lotArea!;
        _lotAreaController.text = ret1.building!.lotArea!;

        totalFloorArea = ret1.building!.totalFloorArea!;
        _totalFloorAreaController.text = ret1.building!.totalFloorArea!;

        areaPurpose = ret1.building!.areaPurpose!;
        _areaPurpoesController.text = ret1.building!.areaPurpose!;

        totalFloorRatio = ret1.building!.totalFloorRatio!;
        _totalFloorRatioController.text = ret1.building!.totalFloorRatio!;

        if (ret1.building!.bdCoverageRatio != null) {
          bdCoverageRatio = ret1.building!.bdCoverageRatio!;
          _bdCoverageRatioController.text = ret1.building!.bdCoverageRatio!;
        } else {
          bdCoverageRatio = '0';
          _bdCoverageRatioController.text = '0';
        }

        if (ret1.building!.bdDistrictUnitPlan != null) {
          bdDistrictUnitPlan = ret1.building!.bdDistrictUnitPlan!;
        } else {
          bdDistrictUnitPlan = '';
        }

        mainPurpose = ret1.building!.mainPurpose!;
        _mainPurposeController.text = ret1.building!.mainPurpose!;

        mainStruct = ret1.building!.mainStruct!;
        _mainStructController.text = ret1.building!.mainStruct!;

        ccd = ret1.building!.ccd!;
        _ccdController.text = ret1.building!.ccd!;

        lowerNum = ret1.building!.lowerNum!;
        _lowerNumController.text = ret1.building!.lowerNum!;

        upperNum = ret1.building!.upperNum!;
        _upperNumController.text = ret1.building!.upperNum!;

        elevator = ret1.building!.elevator!;
        _elevatorController.text = ret1.building!.elevator!;

        parkingNum = ret1.building!.parkingNum!;
        _parkingNumController.text = ret1.building!.parkingNum!;

        officialLandPrice = ((double.tryParse(ret1.building!.officialLandPrice!) ?? 0) / 10000).toString();
        _officialLandPriceController.text = ((double.tryParse(ret1.building!.officialLandPrice!) ?? 0) / 10000).toString();

        totalLandPrice = ((double.tryParse(ret1.building!.totalLandPrice!) ?? 0) / 10000).toString();
        _totalLandPriceController.text = ((double.tryParse(ret1.building!.totalLandPrice!) ?? 0) / 10000).toString();

        if (ret1.dealMaster!.negotiationType == '1') {
          negotiationType = '가능';
          negotiateINT = 1;
        } else if (ret1.dealMaster!.negotiationType == '2') {
          negotiationType = '불가능';
          negotiateINT = 2;
        } else {
          negotiationType = '협의';
          negotiateINT = 3;
        }

        if (ret1.dealMaster!.evacuationType == '0') {
          evacuationType = '';
          dispossessINT = 0;
        } else if (ret1.dealMaster!.evacuationType == '1') {
          evacuationType = '전층책임명도';
          dispossessINT = 1;
        } else if (ret1.dealMaster!.evacuationType == '2') {
          evacuationType = '일부책임명도';
          dispossessINT = 2;
        } else if (ret1.dealMaster!.evacuationType == '3') {
          evacuationType = '불가능';
          dispossessINT = 3;
        } else if (ret1.dealMaster!.evacuationType == '4') {
          evacuationType = '협의';
          dispossessINT = 4;
        } else {
          evacuationType = '0';
          dispossessINT = 0;
        }

        evacuationPeriod = ret1.dealMaster!.evacuationPeriod!;
        _evacuationPeriodController.text = ret1.dealMaster!.evacuationPeriod!;

        evacuationChk = ret1.dealMaster!.evacuationChk!;

        deposit = ((double.tryParse(ret1.building!.deposit!) ?? 0) / 10000).toString();
        _depositeController.text = ((double.tryParse(ret1.building!.deposit!) ?? 0) / 10000).toString();

        depositChk = ret1.building!.depositChk!;
        if (ret1.building!.depositChk != "N") {
          depositChkBool = true;
        } else {
          depositChkBool = false;
        }

        monthly = ((double.tryParse(ret1.building!.monthly!) ?? 0) / 10000).toString();
        _monthlyController.text = ((double.tryParse(ret1.building!.monthly!) ?? 0) / 10000).toString();

        if (ret1.building!.loan != null) {
          loan = ret1.building!.loan!;
        } else {
          loan = '';
        }

        monthlyChk = ret1.building!.monthlyChk!;
        if (ret1.building!.monthlyChk != "N") {
          monthlyChkBool = true;
        } else {
          monthlyChkBool = false;
        }

        if (ret1.building!.loan! == '0') {
          loan = '없음';
        } else {
          loan = ret1.building!.loan!;
        }

        roomNum = ret1.building!.roomNum!;
        _rommNumController.text = ret1.building!.roomNum!;

        reModel = ret1.building!.reModel!;

        if (reModel == '-1') {
          remodelInt = 2;
          _remodellingController.text = '0';
        } else if (reModel == '0') {
          remodelInt = 3;
          _remodellingController.text = '0';
        } else {
          remodelInt = 1;
          _remodellingController.text = ret1.building!.reModel!;
        }

        stationName = ret1.dealMaster!.stationName!;
        _stationController.text = ret1.dealMaster!.stationName!;

        stationDistance = ret1.dealMaster!.stationDistance!;
        _stationDistanceController.text = ret1.dealMaster!.stationDistance!;

        rentRollList = [];
        rentRolls = [];
        for (var i = 0; i < ret1.rentrollList!.length; i++) {
          rentRollList.add([
            ret1.rentrollList![i].floor!,
            ret1.rentrollList![i].sectors!,
            ret1.rentrollList![i].area!,
            ((double.tryParse(ret1.rentrollList![i].deposit!) ?? 0) / 10000).toString(),
            ((double.tryParse(ret1.rentrollList![i].rent!) ?? 0) / 10000).toString(),
            ret1.rentrollList![i].etc!,
          ]);
          rentRolls.add(IdRentRollEditBoard(
              text1: ret1.rentrollList![i].floor!,
              text2: ret1.rentrollList![i].sectors!,
              text3: ret1.rentrollList![i].area!,
              text4: ((double.tryParse(ret1.rentrollList![i].deposit!) ?? 0) / 10000).toString(),
              text5: ((double.tryParse(ret1.rentrollList![i].rent!) ?? 0) / 10000).toString(),
              text6: ret1.rentrollList![i].etc!));
        }

        for (var i = 0; i < ret1.fileList!.length; i++) {
          fileNumList.add(int.tryParse(ret1.fileList![i].fileOrder!) ?? (i + 1));
        }

        if (ret1.dealMaster!.labelList != null) {
          for (var i = 0; i < ret1.dealMaster!.labelList!.length; i++) {
            pjtList.add(ret1.dealMaster!.labelList![i].label!);
            pjtColorList.add(ret1.dealMaster!.labelList![i].labelColor!);
          }
        }
      }
    }

    //메모 리스트
    final dynamic ret2 = await IdApi.getMemo(dealNo, SearchOptionItme(page: acturalPage, rowSize: 5));

    if (ret2 != null) {
      _memoDs[0].data = ret2;
      Map<String, dynamic> commonInfo = _memoDs[0].data!.commonInfo!;
      totalRowsCnt = commonInfo['totalCnt'];
      if (totalRowsCnt % 5 == 0) {
        totalPage = int.tryParse((totalRowsCnt / 5).toString()) ?? 1;
      } else {
        totalPage = (int.tryParse((totalRowsCnt / 5).toString().split('.')[0]) ?? 1) + 1;
      }
    } else {
      _memoDs[0].data = MemoResponse(list: [], commonInfo: {});
    }

    setState(() {});
  }

  List<List<String>> makeRows() {
    List<List<String>> results = [];
    for (var i = 0; i < _memoDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _memoDs[0].data!.list![i];
      row1.add((i + 1).toString());
      row1.add(item1.creator!);
      if (item1.fileName != null) {
        row1.add('${item1.memo!} - ${item1.fileName!}');
      } else {
        row1.add(item1.memo!);
      }
      row1.add(item1.createDate!);
      results.add(row1);
    }
    setState(() {});
    return results;
  }

  Future<bool> setMemo() async {
    try {
      final result = await IdApi.setDealMemo(dealNo, userNo, _memoController.text, memoFile, _fileController.text);
      if (result == null) return false;
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<void> fetchData2() async {
    if (pnu == '') {
      if (type == 'L') {
        final dynamic ret1 = await IdApi.getLandInfo(address);
        DealLandItem data = ret1;
        pnu = data.pnu!;
      } else {
        final DealBuildingResponse? ret1 = await IdApi.getBuildingInfo(address);
        if (ret1 != null) pnu = ret1!.list![0].pnu!;
      }
    } else {
      if (type == 'L') {
        final dynamic ret1 = await IdApi.getLandInfo(jibunAddress);
        DealLandItem data = ret1;
        if (lotListNum == 0) {
          _addressController.text = jibunAddress;
          _stationController.text = data.stationName!;
          _stationDistanceController.text = data.distance!;
        }
        lotInfoList[lotListNum][0] = data.address!;
        lotInfoList[lotListNum][1] = double.tryParse(data.lotArea!) ?? 0;
        lotInfoList[lotListNum][2] = double.tryParse(data.lotAreaPy!) ?? 0;
        lotInfoList[lotListNum][3] = data.areaPurpose!;
        lotInfoList[lotListNum][4] = double.tryParse(((double.tryParse(data.officialLandPrice!) ?? 0) / 10000).toStringAsFixed(2)) ?? 0;
        lotInfoList[lotListNum][5] = double.tryParse(((double.tryParse(data.totalLandPrice!) ?? 0) / 10000).toStringAsFixed(2)) ?? 0;
        lotInfoList[lotListNum][6] = 0;
      } else {
        final DealBuildingResponse? ret1 = await IdApi.getBuildingInfo(jibunAddress);
        _addressController.text = jibunAddress;
        _stationController.text = ret1!.subway!['stationName'];
        _stationDistanceController.text = ret1.subway!['distance'];
        _buildingNameController.text = ret1.list![0].buildingName!;
        _lotAreaController.text = ret1.list![0].lotArea!;
        _areaPurpoesController.text = ret1.list![0].areaPurpose!;
        if (ret1.list![0].totalFloorRatio != null) {
          _totalFloorRatioController.text = ret1.list![0].totalFloorRatio!;
        } else {
          _totalFloorRatioController.text = '0';
        }
        _bdCoverageRatioController.text = ret1.list![0].bdCoverageRatio!;
        _bdDistrictUnitPlanController.text = ret1.list![0].bdDistrictUnitPlan!;
        _mainPurposeController.text = ret1.list![0].mainPurpose!;
        _mainStructController.text = ret1.list![0].mainStruct!;
        _ccdController.text = ret1.list![0].ccd!;
        _upperNumController.text = ret1.list![0].upperNum!;
        _lowerNumController.text = ret1.list![0].lowerNum!;
        _upperNumController.text = ret1.list![0].upperNum!;
        _parkingNumController.text = ret1.list![0].parkingNum!;
        _officialLandPriceController.text = ((double.tryParse(ret1.list![0].officialLandPrice!) ?? 0) / 10000).toStringAsFixed(2);
        _totalLandPriceController.text = ((double.tryParse(ret1.list![0].totalLandPrice!) ?? 0) / 10000).toStringAsFixed(2);
      }
      setState(() {});
    }
  }

  Future<bool> updateDeal() async {
    int registerantInt = 0; //등록자
    lotListTojson = [];
    List additionalList = [];
    List bdAdditionalList = [];
    String additionalEtcStr = '';
    String remodelStr = '';
    String askingStr = '';
    rentRollsList = [];
    rentRollListTojson = [];

    for (var i = 0; i < lotInfoList.length; i++) {
      String officialLandPriceStr = ((double.tryParse(lotInfoList[i][4].toString()) ?? 0) * 10000).toString();
      String totalLandPriceStr = ((double.tryParse(lotInfoList[i][5].toString()) ?? 0) * 10000).toString();
      String askingStr = ((double.tryParse(lotInfoList[i][6].toString()) ?? 0) * 100000000).toString();
      if (lotInfoList[i][4].toString() == '') {
        officialLandPriceStr = '';
        totalLandPriceStr = '';
        askingStr = '';
      } else {
        officialLandPriceStr = ((double.tryParse(lotInfoList[i][4].toString()) ?? 0) * 10000).toString();
        totalLandPriceStr = ((double.tryParse(lotInfoList[i][5].toString()) ?? 0) * 10000).toString();
        askingStr = ((double.tryParse(lotInfoList[i][6].toString()) ?? 0) * 100000000).toString();
      }

      lotListTojson.add({
        "address": "${lotInfoList[i][0]}",
        "lotArea": "${lotInfoList[i][1]}",
        "lotAreaPy": "${lotInfoList[i][2]}",
        "areaPurpose": "${lotInfoList[i][3]}",
        "officialLandPrice": "$officialLandPriceStr",
        "totalLandPrice": "$totalLandPriceStr",
        "asking": "$askingStr"
      });
    }

    rentRolls.forEach((element) {
      rentRollsList.add([element.rent1(), element.rent2(), element.rent3(), element.rent4(), element.rent5(), element.rent6()]);
    });
    for (var i = 0; i < rentRollsList.length; i++) {
      String depositStr = '';
      String rentStr = '';
      if (rentRollsList[i][3] == '') {
        depositStr = '';
        rentStr = '';
      } else {
        depositStr = ((double.tryParse(rentRollsList[i][3]) ?? 0) * 10000).toString();
        rentStr = ((double.tryParse(rentRollsList[i][4]) ?? 0) * 10000).toString();
      }

      rentRollListTojson.add({
        "floor": "${rentRollsList[i][0]}",
        "sectors": "${rentRollsList[i][1]}",
        "area": "${rentRollsList[i][2]}",
        "deposit": "$depositStr",
        "rent": "$rentStr",
        "etc": "${rentRollsList[i][5]}"
      });
    }
    fileList = [];

    for (var i = 0; i < fileNumList.length; i++) {
      fileList.add('{"fileDoc":"${imgDescControllerList[fileNumList[i] - 1].text}", "fileOrder":"${fileNumList[i]}"}');
    }

    if (registrantBoolList[0]) {
      registerantInt = 1;
    } else if (registrantBoolList[1]) {
      registerantInt = 2;
    } else if (registrantBoolList[2]) {
      registerantInt = 3;
    } else {
      registerantInt = 4;
    }
    for (var i = 0; i < areaList.length; i++) {
      if (areaNumList[i] == 1) {
        additionalList.add(areaCDList[i]);
      }
    }
    for (var i = 0; i < buildingList.length; i++) {
      if (buildingNumList[i] == 1) {
        bdAdditionalList.add(buildingCDList[i]);
      }
    }
    if (_additionalEtcController.text == '-') {
      additionalEtcStr = '';
    } else {
      additionalEtcStr = _additionalEtcController.text;
    }
    if (evacuationChkBool) {
      evacuationChk = 'Y';
    } else {
      evacuationChk = 'N';
    }
    if (type == "B") {
      if (remodelInt == 2) {
        remodelStr = '-1';
      } else if (remodelInt == 3) {
        remodelStr = '0';
      } else {
        remodelStr = ((double.tryParse(_remodellingController.text) ?? 0) * 10000).toString();
      }
    }

    if (_askingController.text != '' || _askingController.text != '0') {
      askingStr = ((double.tryParse(_askingController.text) ?? 0) * 100000000).toString();
    } else {
      askingStr = '0';
    }

    if (type == 'L') {
      final result = await IdApi.updateDealLand(
        dealNo,
        userNo,
        pnu,
        DealMasterItem(
          pnu: pnu,
          type: type,
          title: pageTitle,
          dealStatus: dealStatus,
          category: category,
          register: registerantInt.toString(),
          registerEtc: _registrantController.text,
          address:
              '${_addressController.text.split(' ')[0]} ${_addressController.text.split(' ')[1]} ${_addressController.text.split(' ')[2]}',
          addressDtl: _addressController.text.split(' ')[3],
          areaPos: areapos,
          asking: askingStr,
          negotiationType: negotiateINT.toString(),
          assetStatus: assetINT.toString(),
          evacuationType: dispossessINT.toString(),
          evacuationPeriod: evacuationPeriod,
          evacuationChk: evacuationChk,
          owner: ownerINT.toString(),
          stationDistance: _stationDistanceController.text,
          stationName: _stationController.text,
          additional: additionalList.toString().replaceAll('[', '').replaceAll(']', ''),
          additionalEtc: additionalEtcStr,
        ),
        DealNewBuildingItem(
          dealLandNo: dealLandNo,
          dealNo: dealNo,
          landUsage: _landUseController.text,
          buildingArea: _buildingAreaController.text,
          totalFloorArea: _totalFloorAreaController.text,
          totalFloorRatio: _totalFloorRatioController.text,
          buildingCoverage: _buildingCoverageController.text,
          parkingNum: _parkingNumController.text,
          elevator: _elevatorController.text,
          lowerFloorArea: '0',
          upperFloorArea: _upperFloorAreaController.text,
          lowerNum: _lowerNumController.text,
          upperNum: _upperNumController.text,
          etc: _NeBuildingEtcController.text,
          owner: ownerINT.toString(),
        ),
        lotListTojson,
        fileList,
      );
      if (result == null) return false;
    } else {
      final result = await IdApi.updatDealBuilding(
        dealNo,
        userNo,
        pnu,
        DealMasterItem(
          pnu: pnu,
          type: type,
          title: pageTitle,
          dealStatus: dealStatus,
          category: category,
          register: registerantInt.toString(),
          registerEtc: _registrantController.text,
          address:
              '${_addressController.text.split(' ')[0]} ${_addressController.text.split(' ')[1]} ${_addressController.text.split(' ')[2]}',
          addressDtl: _addressController.text.split(' ')[3],
          areaPos: areapos,
          asking: askingStr,
          negotiationType: negotiateINT.toString(),
          assetStatus: assetINT.toString(),
          evacuationType: dispossessINT.toString(),
          evacuationPeriod: evacuationPeriod,
          evacuationChk: evacuationChk,
          owner: ownerINT.toString(),
          stationDistance: _stationDistanceController.text,
          stationName: _stationController.text,
          additional: additionalList.toString().replaceAll('[', '').replaceAll(']', ''),
          additionalEtc: additionalEtcStr,
        ),
        DealBuildingItem(
          buildingName: _buildingNameController.text,
          lotArea: _lotAreaController.text,
          totalFloorArea: _totalFloorAreaController.text,
          areaPurpose: _areaPurpoesController.text,
          totalFloorRatio: _totalFloorRatioController.text,
          mainPurpose: _mainPurposeController.text,
          mainStruct: _mainStructController.text,
          ccd: _ccdController.text,
          lowerNum: _lowerNumController.text,
          upperNum: _upperNumController.text,
          elevator: _elevatorController.text,
          parkingNum: _parkingNumController.text,
          officialLandPrice: ((double.tryParse(_officialLandPriceController.text) ?? 0) * 10000).toString(),
          totalLandPrice: ((double.tryParse(_totalLandPriceController.text) ?? 0) * 10000).toString(),
          deposit: ((double.tryParse(_depositeController.text) ?? 0) * 10000).toString(),
          depositChk: depositChk,
          monthly: ((double.tryParse(_monthlyController.text) ?? 0) * 10000).toString(),
          monthlyChk: monthlyChk,
          loan: loan,
          roomNum: _rommNumController.text,
          reModel: remodelStr,
          bdAdditional: bdAdditionalList.toString().replaceAll('[', '').replaceAll(']', ''),
        ),
        rentRollListTojson,
        fileList,
      );
      if (result == null) return false;
    }
    return true;
  }

  Future<bool> imgFetchData(Uint8List imgData, String userNo1, String fileName, String fileOrder, String dealNo1) async {
    final result = await IdApi.updatgeTempFile(imgData, userNo1, fileName, fileOrder, dealNo1);
    if (result == null) return false;

    return true;
  }

  Future<void> otherUploadFile(int fileInt) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.any);

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;

      if (await imgFetchData(fileBytes!, userNo, fileName, fileInt.toString(), dealNo)) {
        GV.d('파일 등록에 성공했습니다.');

        nullCount = 0;

        if (fileInt == 11) {
          _TM_InfoController.text = fileName;
        } else if (fileInt == 12) {
          _floorPlanController.text = fileName;
        } else if (fileInt == 13) {
          _otherController.text = fileName;
        }
      } else {
        imgList[fileInt - 1] = null;
        GV.d('파일 등록에 실패했습니다.');
      }
    }
  }

  // 1개의 파일 업로드
  Future<void> memoUploadFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image);

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = result.files.first.name;
      final fileSize = result.files.first.size;

      memoFile = fileBytes!;
      _fileController.text = fileName;
      imgSize = ((double.tryParse(fileSize.toString()) ?? 0) / 1000).roundToDouble();
      setState(() {});

      uploadImg1 = Image.memory(
        fileBytes as Uint8List,
        width: 520,
        height: 289.45,
        fit: BoxFit.contain,
        alignment: Alignment.center,
      );
    } else {}
  }

//수정에 쓸 이미지 업로드
  Future<void> cropFile(int imgNumber) async {
    // file picker를 통해 파일 선택
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.image, withData: true);

    if (result != null && result.files.isNotEmpty) {
      final fileBytes = result.files.first.bytes;
      final fileName = '${result.files.first.name.split('.')[0]}.jpg';
      final fileSize = result.files.first.size;

      if (fileSize > 10000000) {
        activeToast('10MB 이하의 이미지를 넣어주세요.');
      } else {
        Image? uploadImg1 = Image.memory(
          fileBytes as Uint8List,
          //TODO 사이즈 맞추기
          width: (imgNumber == 1) ? 432 : 208,
          height: (imgNumber == 1) ? 529 : 143,
          fit: BoxFit.fitWidth,
          alignment: Alignment.center,
        );

        // ignore: use_build_context_synchronously
        showCupertinoImageCropper(context,
            imageProvider: uploadImg1.image,
            cropPathFn: aabbCropShapeFn,
            enabledTransformations: Transformation.values,
            shouldPopAfterCrop: true,
            allowedAspectRatios: [CropAspectRatio(width: (imgNumber == 1) ? 9 : 11, height: (imgNumber == 1) ? 11 : 7)],
            postProcessFn: (result) async {
          var croppedImg1 = RawImage(image: result.uiImage);
          // var d123 = await result.uiImage.toByteData(); //(format: ui.ImageByteFormat.png);
          var toJpg = await uiCommon.convertImageToJpg(result.uiImage);
          // var d123 = await result.uiImage.toByteData(); //(format: ui.ImageByteFormat.png);
          //d123!.buffer.asUint8List();

          if (toJpg == null) {
            imgList[imgNumber - 1] = null;
          } else {
            imgList[imgNumber - 1] = croppedImg1;
            //TODO 이미지 API 돌리기

            if (await imgFetchData(toJpg, userNo, fileName, imgNumber.toString(), dealNo)) {
              GV.d('이미지 등록에 성공했습니다.');

              nullCount = 0;

              for (var element in imgList) {
                if (element == null) {
                  nullCount++;
                }
              }
              fileNumList.add(imgNumber);
              if (imgNumber == 1) {
                _img1DescController.text = '대표사진';
              } else if (imgNumber == 2) {
                _img2DescController.text = '외관사진 1';
              } else if (imgNumber == 3) {
                _img3DescController.text = '외관사진 2';
              } else if (imgNumber == 4) {
                _img4DescController.text = '외관사진 3';
              } else if (imgNumber == 5) {
                _img5DescController.text = '내부사진 1';
              } else if (imgNumber == 6) {
                _img6DescController.text = '내부사진 2';
              } else if (imgNumber == 7) {
                _img7DescController.text = '내부사진 3';
              } else if (imgNumber == 8) {
                _img8DescController.text = '내부사진 4';
              } else if (imgNumber == 9) {
                _img9DescController.text = '내부사진 5';
              } else if (imgNumber == 10) {
                _img10DescController.text = '내부사진 6';
              }
            } else {
              imgList[imgNumber - 1] = null;
              GV.d('이미지 등록에 실패했습니다.');
            }
          }
          setState(() {});

          return result;
        });
      }
    } else {
      // 아무런 파일도 선택되지 않음.
    }
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

  Widget radioWithLable1(Function() onBntPressed, bool checkBool, Color radioColor, String lable, Color lableColor, bool enable) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 9, 0, 9),
      child: Row(
        children: [
          IdRadio(
            onBtnPressed: onBntPressed,
            checkBool: checkBool,
            radioColor: radioColor,
            enabled: enable,
            radioSize: 'small',
          ),
          const IdSpace(spaceWidth: 8, spaceHeight: 0),
          uiCommon.styledText(lable, 14, 0, 1, FontWeight.w600, lableColor, TextAlign.left)
        ],
      ),
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
        const IdSpace(spaceWidth: 20, spaceHeight: 0),
      ],
    );
  }

  Widget checkboxWithLable(Function() onBtnPressed, int checkYN, String title) {
    return SizedBox(
      height: 44,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IdNormalBtn(
            onBtnPressed: onBtnPressed,
            childWidget: IdImageBox(
                imagePath: (checkYN == 0) ? 'assets/img/icon_checkBox_none.png' : 'assets/img/icon_checkBox_green.png',
                imageWidth: 20,
                imageHeight: 20,
                imageFit: BoxFit.cover),
          ),
          const IdSpace(spaceWidth: 8, spaceHeight: 0),
          uiCommon.styledText(title, 18, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
          const IdSpace(spaceWidth: 32, spaceHeight: 0),
        ],
      ),
    );
  }

  Widget textInput(String hint, TextEditingController controller, String keyboadType, double width, bool enabledBool) {
    return IdInputValidation(
        width: width,
        height: 44,
        inputColor: IdColors.backgroundDefault,
        round: 8,
        controller: controller,
        textAlign: 'start',
        hintText: hint,
        hintTextFontSize: 16,
        hintTextfontWeight: FontWeight.w500,
        hintTextFontColor: IdColors.textTertiary,
        keyboardType: keyboadType,
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: enabledBool);
  }

  Widget lotTextInput(double width, double height, String text) {
    return Container(
      width: width,
      height: height,
      padding: EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      decoration: BoxDecoration(
        color: IdColors.backgroundDefault,
        borderRadius: BorderRadius.circular(8),
      ),
      child: uiCommon.styledText(text, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
    );
  }

  Widget checkBox(List checkBoxName, List checkBoxStatus, int length) {
    return Row(
      children: List.generate(
          length,
          (index) => checkboxWithLable(() {
                if (checkBoxStatus[index] == 0) {
                  checkBoxStatus[index] = 1;
                } else {
                  checkBoxStatus[index] = 0;
                }
                setState(() {});
              }, checkBoxStatus[index], checkBoxName[index])),
    );
  }

  Widget rowContents(
    String title,
    FontWeight titleWeigth,
    String content,
    FontWeight contentWeigth,
  ) {
    return Row(
      children: [
        SizedBox(
          width: 130,
          child: uiCommon.styledText(title, 16, 0, 1.6, titleWeigth, IdColors.textDefault, TextAlign.left),
        ),
        const IdSpace(spaceWidth: 40, spaceHeight: 0),
        uiCommon.styledText(content, 16, 0, 1.6, contentWeigth, IdColors.textDefault, TextAlign.left),
      ],
    );
  }

  Widget rowContentsEdit(String title, FontWeight titleWeigth, Widget editWidget) {
    return Row(
      children: [
        SizedBox(
          width: 130,
          child: uiCommon.styledText(title, 16, 0, 1.6, titleWeigth, IdColors.textDefault, TextAlign.left),
        ),
        const IdSpace(spaceWidth: 40, spaceHeight: 0),
        editWidget,
      ],
    );
  }

  Widget contentsRow(
    String leftTitle,
    FontWeight leftTitleWeigth,
    String leftContent,
    FontWeight leftContentWeigth,
    String rightTitle,
    FontWeight rightTitleWeigth,
    String rightContent,
    FontWeight rightContentWeigth,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: rowContents(leftTitle, leftTitleWeigth, leftContent, leftContentWeigth)),
          Expanded(child: rowContents(rightTitle, rightTitleWeigth, rightContent, rightContentWeigth))
        ],
      ),
    );
  }

  Widget contentsRowEdit1(
    String leftTitle,
    Widget leftEditWidget,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: rowContentsEdit(leftTitle, FontWeight.w400, leftEditWidget)),
        ],
      ),
    );
  }

  Widget contentsRowEdit2(
    String leftTitle,
    Widget leftEditWidget,
    String rightTitle,
    Widget rightEditWidget,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: Row(
        children: [
          Expanded(child: rowContentsEdit(leftTitle, FontWeight.w400, leftEditWidget)),
          Expanded(child: rowContentsEdit(rightTitle, FontWeight.w400, rightEditWidget))
        ],
      ),
    );
  }

  Widget subContents(String leftTitle, String leftContent, String rightTitle, String rightContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 382,
            child: rowContents(leftTitle, FontWeight.w500, leftContent, FontWeight.w500),
          ),
          rowContents(rightTitle, FontWeight.w500, rightContent, FontWeight.w500)
        ],
      ),
    );
  }

  Widget subContentsEdit(String leftTitle, Widget leftContent, String rightTitle, Widget rightContent) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 382,
            child: rowContentsEdit(leftTitle, FontWeight.w500, leftContent),
          ),
          rowContentsEdit(rightTitle, FontWeight.w500, rightContent)
        ],
      ),
    );
  }

  Widget dropDown1(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown) {
    return Container(
      width: 250,
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

  Widget contentsTitle(String title, Widget childWidget) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: IdColors.black),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: uiCommon.styledText(title, 20, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.left),
            ),
          ),
          //TODO 지도관련사항
          childWidget
        ],
      ),
    );
  }

  Widget infoTableHeader1(
      double cellWidth, double topBorder, double leftBorder, double rightBorder, double bottoBorder, String contentsStr) {
    return Container(
      width: cellWidth,
      height: 60,
      decoration: BoxDecoration(
        color: IdColors.backgroundDefault,
        border: Border(
          top: BorderSide(width: topBorder, color: IdColors.borderDefault),
          left: BorderSide(width: leftBorder, color: IdColors.borderDefault),
          right: BorderSide(width: rightBorder, color: IdColors.borderDefault),
          bottom: BorderSide(width: bottoBorder, color: IdColors.borderDefault),
        ),
      ),
      child: Center(
        child: uiCommon.styledText(contentsStr, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
      ),
    );
  }

  Widget infoTableHeader2(double topBorder, double leftBorder, double rightBorder, double bottoBorder, String contentsStr) {
    return Container(
      width: double.infinity,
      height: 30,
      decoration: BoxDecoration(
        color: IdColors.backgroundDefault,
        border: Border(
          top: BorderSide(width: topBorder, color: IdColors.borderDefault),
          left: BorderSide(width: leftBorder, color: IdColors.borderDefault),
          right: BorderSide(width: rightBorder, color: IdColors.borderDefault),
          bottom: BorderSide(width: bottoBorder, color: IdColors.borderDefault),
        ),
      ),
      child: Center(
        child: uiCommon.styledText(contentsStr, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
      ),
    );
  }

  Widget infoTableBody(double cellWidth, double cellHeight, double leftBorder, double rightBorder, Widget childWidget) {
    return Container(
      width: cellWidth,
      height: cellHeight,
      decoration: BoxDecoration(
        color: IdColors.white,
        border: Border(
          left: BorderSide(width: leftBorder, color: IdColors.borderDefault),
          right: BorderSide(width: rightBorder, color: IdColors.borderDefault),
          bottom: const BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: childWidget,
    );
  }

  Widget lotInfoTable(String infoNo, double m2, double pyong, String area, String address, double construction, double constrcutinoTotal,
      double sellingPrice) {
    return Row(
      children: [
        infoTableBody(
          80,
          96,
          1,
          0,
          Center(
            child: uiCommon.styledText(infoNo.toString(), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  infoTableBody(
                      120,
                      48,
                      1,
                      0,
                      Center(
                        child: (editAction)
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      clickLotRowNum = int.tryParse(infoNo) ?? 0;
                                      lotAreaPopupVisible = true;
                                      popupTitle = '㎡';
                                      setState(() {});
                                    },
                                    child: lotTextInput(85, 38, (m2.toString().contains('.')) ? m2.toStringAsFixed(2) : m2.toString()),
                                  ),
                                  uiCommon.styledText('㎡', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center)
                                ],
                              )
                            : uiCommon.styledText((m2.toString().contains('.')) ? '${m2.toStringAsFixed(2)}㎡' : '$m2㎡', 16, 0, 1,
                                FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      )),
                  Expanded(
                      child: infoTableBody(
                          120,
                          48,
                          1,
                          0,
                          Center(
                            child: (editAction)
                                ? Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () {
                                          clickLotRowNum = int.tryParse(infoNo) ?? 0;
                                          lotAreaPyPopupVisible = true;
                                          popupTitle = '평';
                                          setState(() {});
                                        },
                                        child: lotTextInput(
                                            85, 38, (pyong.toString().contains('.')) ? pyong.toStringAsFixed(2) : pyong.toString()),
                                      ),
                                      uiCommon.styledText('py', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center)
                                    ],
                                  )
                                : uiCommon.styledText((pyong.toString().contains('.')) ? '${pyong.toStringAsFixed(2)}py' : '${pyong}py', 16,
                                    0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                          ))),
                  infoTableBody(
                      248,
                      48,
                      1,
                      0,
                      Center(
                        child: (editAction)
                            ? GestureDetector(
                                onTap: () {
                                  clickLotRowNum = int.tryParse(infoNo) ?? 0;
                                  areaPurposePopupVisible = true;
                                  popupTitle = '용도지역';
                                  setState(() {});
                                },
                                child: lotTextInput(238, 38, area),
                              )
                            : uiCommon.styledText(area, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      )),
                ],
              ),
              Row(
                children: [
                  infoTableBody(
                      120,
                      48,
                      1,
                      0,
                      Center(
                        child: uiCommon.styledText('주소', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      )),
                  Expanded(
                    child: infoTableBody(
                        double.infinity,
                        48,
                        1,
                        0,
                        Center(
                          child: Row(
                            children: [
                              const IdSpace(spaceWidth: 16, spaceHeight: 0),
                              (editAction)
                                  ? Row(
                                      children: [
                                        lotTextInput(200, 38, address),
                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                        IdNormalBtn(
                                          onBtnPressed: () {
                                            lotListNum = (int.tryParse(infoNo) ?? 1) - 1;
                                            addressPopup = true;
                                            setState(() {});
                                          },
                                          childWidget: Container(
                                            width: 74,
                                            height: 38,
                                            decoration: BoxDecoration(
                                              color: IdColors.white,
                                              border: Border.all(width: 1, color: IdColors.textDefault),
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: uiCommon.styledText(
                                                  '검색', 15, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.center),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : uiCommon.styledText(address, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                            ],
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        infoTableBody(
            164,
            96,
            1,
            0,
            Center(
              child: (editAction)
                  ? GestureDetector(
                      onTap: () {
                        clickLotRowNum = int.tryParse(infoNo) ?? 0;
                        officialPricePopupVisible = true;
                        popupTitle = '공시지가';
                        setState(() {});
                      },
                      child: lotTextInput(154, 38, NumberFormat('#,##0.00').format(construction)),
                    )
                  : uiCommon.styledText(
                      NumberFormat('#,##0.00').format(construction), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
        infoTableBody(
            170,
            96,
            1,
            0,
            Center(
              child: (editAction)
                  ? GestureDetector(
                      onTap: () {
                        clickLotRowNum = int.tryParse(infoNo) ?? 0;
                        totalPricePopupVisible = true;
                        popupTitle = '공시지가';
                        setState(() {});
                      },
                      child: lotTextInput(160, 38, NumberFormat('#,##0.00').format(constrcutinoTotal)),
                    )
                  : uiCommon.styledText(NumberFormat('#,##0.00').format(constrcutinoTotal), 16, 0, 1, FontWeight.w500, IdColors.textDefault,
                      TextAlign.center),
            )),
        infoTableBody(
            206,
            96,
            1,
            0,
            Center(
              child: (editAction)
                  ? GestureDetector(
                      onTap: () {
                        clickLotRowNum = int.tryParse(infoNo) ?? 0;
                        sellPricePopupVisible = true;
                        popupTitle = '매도가격';
                        setState(() {});
                      },
                      child: lotTextInput(196, 38, NumberFormat('#,##0.00').format(sellingPrice)),
                    )
                  : uiCommon.styledText(
                      NumberFormat('#,##0.00').format(sellingPrice), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
      ],
    );
  }

  Widget lotInfoTable2(String infoNo, double m2, double pyong, String area, String address, double construction, double constrcutinoTotal,
      double sellingPrice) {
    return Row(
      children: [
        infoTableBody(
          80,
          96,
          1,
          0,
          Center(
            child: uiCommon.styledText(infoNo.toString(), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
          ),
        ),
        Expanded(
          child: Column(
            children: [
              Row(
                children: [
                  infoTableBody(
                      120,
                      48,
                      1,
                      0,
                      Center(
                        child: uiCommon.styledText((m2.toString().contains('.')) ? '${m2.toStringAsFixed(2)}㎡' : '$m2㎡', 16, 0, 1,
                            FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      )),
                  Expanded(
                      child: infoTableBody(
                          120,
                          48,
                          1,
                          0,
                          Center(
                            child: uiCommon.styledText((pyong.toString().contains('.')) ? '${pyong.toStringAsFixed(2)}py' : '${pyong}py',
                                16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                          ))),
                  infoTableBody(
                      248,
                      48,
                      1,
                      0,
                      Center(
                        child: uiCommon.styledText(area, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      )),
                ],
              ),
              Row(
                children: [
                  infoTableBody(
                      120,
                      48,
                      1,
                      0,
                      Center(
                        child: uiCommon.styledText('주소', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      )),
                  Expanded(
                    child: infoTableBody(
                        double.infinity,
                        48,
                        1,
                        0,
                        Center(
                          child: Row(
                            children: [
                              const IdSpace(spaceWidth: 16, spaceHeight: 0),
                              uiCommon.styledText(address, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                            ],
                          ),
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
        infoTableBody(
            164,
            96,
            1,
            0,
            Center(
              child: uiCommon.styledText(
                  NumberFormat('#,##0.00').format(construction), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
        infoTableBody(
            170,
            96,
            1,
            0,
            Center(
              child: uiCommon.styledText(
                  NumberFormat('#,##0.00').format(constrcutinoTotal), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
        infoTableBody(
            206,
            96,
            1,
            0,
            Center(
              child: uiCommon.styledText(
                  NumberFormat('#,##0.00').format(sellingPrice), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
      ],
    );
  }

  Widget infoTable() {
    return Column(
      children: [
        //헤더
        Row(
          children: [
            infoTableHeader1(80, 1, 1, 0, 1, 'NO'),
            Expanded(
              child: Column(
                children: [
                  infoTableHeader2(1, 1, 0, 1, '대지면적'),
                  Row(
                    children: [
                      Expanded(child: infoTableHeader2(1, 1, 0, 1, '㎡')),
                      Expanded(child: infoTableHeader2(1, 1, 0, 1, '평 ')),
                    ],
                  )
                ],
              ),
            ),
            infoTableHeader1(248, 1, 1, 0, 1, '용도지역'),
            infoTableHeader1(164, 1, 1, 0, 1, '개별공사지가'),
            infoTableHeader1(170, 1, 1, 0, 1, '공사지가합계'),
            infoTableHeader1(206, 1, 1, 1, 1, '매도가격($lotInfoAskingInclude)'),
          ],
        ),
        //각필지 정보
        Column(
          children: List.generate(
            lotInfoList.length,
            (index) => lotInfoTable(
              '${index + 1}',
              lotInfoList[index][1],
              lotInfoList[index][2],
              lotInfoList[index][3],
              lotInfoList[index][0],
              lotInfoList[index][4],
              lotInfoList[index][5],
              lotInfoList[index][6],
            ),
          ),
        ),
        //합계
        lotInfoTable2(
            '합계', totalM2(), totalPy(), totalArea(), totalAddress(), totalconstructPrice(), totalAllPrice(), totalAllSellingPrice()),
      ],
    );
  }

  double totalM2() {
    double result = 0;
    if (lotInfoList.isNotEmpty) {
      for (var i = 0; i < lotInfoList.length; i++) {
        result = result + lotInfoList[i][1];
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  double totalPy() {
    double result = 0;
    if (lotInfoList.isNotEmpty) {
      for (var i = 0; i < lotInfoList.length; i++) {
        result = result + lotInfoList[i][2];
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
    if (lotInfoList.isNotEmpty) {
      for (var i = 0; i < lotInfoList.length; i++) {
        areaList.add(lotInfoList[i][3]);
        bool allSame = areaList.toSet().length == 1;
        if (allSame) {
          result = lotInfoList[0][3];
        } else {
          result = '-';
        }
      }
    } else {
      result = '-';
    }
    return result;
  }

  String totalAddress() {
    String result = '';
    if (lotInfoList.isNotEmpty) {
      if (lotInfoList.length > 1) {
        result = lotInfoList[0][0] + ' 외 ' + (lotInfoList.length - 1).toString() + '개 필지';
      } else {
        result = lotInfoList[0][0];
      }
    } else {
      result = '-';
    }
    return result;
  }

  double totalconstructPrice() {
    double result = 0;
    if (lotInfoList.isNotEmpty) {
      for (var i = 0; i < lotInfoList.length; i++) {
        result = double.tryParse((result + lotInfoList[i][4]).toString()) ?? 0;
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  double totalAllPrice() {
    double result = 0;
    if (lotInfoList.isNotEmpty) {
      for (var i = 0; i < lotInfoList.length; i++) {
        result = double.tryParse((result + lotInfoList[i][5]).toString()) ?? 0;
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  double totalAllSellingPrice() {
    double result = 0;
    if (lotInfoList.isNotEmpty) {
      for (var i = 0; i < lotInfoList.length; i++) {
        result = double.tryParse((result + lotInfoList[i][6]).toString()) ?? 0;
      }
    } else {
      result = 0;
    }
    setState(() {});
    return result;
  }

  Widget imgGridRow(List imgList, List imgDescList, int addInt, List imgDescControllerList) {
    return Row(
      children: List.generate(
        3,
        (index) => Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                (editAction)
                    ? IdNormalBtn(
                        onBtnPressed: () {
                          if (index + addInt + 1 == 3) {
                            if (imgList[1] == null && realImgList[1] == '') {
                              activeToast('외관 첫번째 사진을 넣어주세요.');
                            } else {
                              cropFile(index + addInt + 1);
                            }
                          } else if (index + addInt + 1 == 4) {
                            if (imgList[1] == null && realImgList[1] == '') {
                              activeToast('외관 첫번째 사진을 넣어주세요.');
                            } else if (imgList[2] == null && realImgList[2] == '') {
                              activeToast('외관 두번째 사진을 넣어주세요.');
                            } else {
                              cropFile(index + addInt + 1);
                            }
                          } else if (index + addInt + 1 == 6) {
                            if (imgList[4] == null && realImgList[4] == '') {
                              activeToast('내부 첫번째 사진을 넣어주세요.');
                            } else {
                              cropFile(index + addInt + 1);
                            }
                          } else if (index + addInt + 1 == 7) {
                            if (imgList[4] == null && realImgList[4] == '') {
                              activeToast('내부 첫번째 사진을 넣어주세요.');
                            } else if (imgList[5] == null && realImgList[5] == '') {
                              activeToast('내부 두번째 사진을 넣어주세요.');
                            } else {
                              cropFile(index + addInt + 1);
                            }
                          } else if (index + addInt + 1 == 8) {
                            if (imgList[4] == null && realImgList[4] == '') {
                              activeToast('내부 첫번째 사진을 넣어주세요.');
                            } else if (imgList[5] == null && realImgList[5] == '') {
                              activeToast('내부 두번째 사진을 넣어주세요.');
                            } else if (imgList[6] == null && realImgList[6] == '') {
                              activeToast('내부 세번째 사진을 넣어주세요.');
                            } else {
                              cropFile(index + addInt + 1);
                            }
                          } else if (index + addInt + 1 == 9) {
                            if (imgList[4] == null && realImgList[4] == '') {
                              activeToast('내부 첫번째 사진을 넣어주세요.');
                            } else if (imgList[5] == null && realImgList[5] == '') {
                              activeToast('내부 두번째 사진을 넣어주세요.');
                            } else if (imgList[6] == null && realImgList[6] == '') {
                              activeToast('내부 세번째 사진을 넣어주세요.');
                            } else if (imgList[7] == null && realImgList[7] == '') {
                              activeToast('내부 네번째 사진을 넣어주세요.');
                            } else {
                              cropFile(index + addInt + 1);
                            }
                          } else if (index + addInt + 1 == 10) {
                            if (imgList[4] == null && realImgList[4] == '') {
                              activeToast('내부 첫번째 사진을 넣어주세요.');
                            } else if (imgList[5] == null && realImgList[5] == '') {
                              activeToast('내부 두번째 사진을 넣어주세요.');
                            } else if (imgList[6] == null && realImgList[6] == '') {
                              activeToast('내부 세번째 사진을 넣어주세요.');
                            } else if (imgList[7] == null && realImgList[7] == '') {
                              activeToast('내부 네번째 사진을 넣어주세요.');
                            } else if (imgList[8] == null && realImgList[8] == '') {
                              activeToast('내부 다섯번째 사진을 넣어주세요.');
                            } else {
                              cropFile(index + addInt + 1);
                            }
                          } else {
                            cropFile(index + addInt + 1);
                          }
                        },
                        childWidget: (realImgList[index + addInt] == '')
                            ? (imgList[index + addInt] == null)
                                ? Container(
                                    width: 208,
                                    height: 143,
                                    decoration: BoxDecoration(
                                        color: IdColors.green5,
                                        borderRadius: BorderRadius.circular(8),
                                        border: Border.all(width: 1, color: IdColors.green2)),
                                    child: Center(
                                        child: uiCommon.styledText(
                                            '이미지를 넣어주세요.', 20, 0, 1.6, FontWeight.w700, IdColors.green2, TextAlign.center)),
                                  )
                                : SizedBox(width: 208, height: 143, child: imgList[index + addInt])
                            : (imgList[index + addInt] == null)
                                ? IdImageBox2(
                                    imagePath: realImgList[index + addInt],
                                    imageWidth: 208,
                                    imageHeight: 143,
                                    round: 8,
                                    imageFit: BoxFit.cover)
                                : SizedBox(width: 208, height: 143, child: imgList[index + addInt]),
                      )
                    : (realImgList[index + addInt] == '')
                        ? Container(
                            width: 208,
                            height: 143,
                            decoration: BoxDecoration(
                              color: IdColors.backgroundDefault,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                                child: uiCommon.styledText(
                                    '이미지가 없습니다.', 20, 0, 1.6, FontWeight.w700, IdColors.textSecondly, TextAlign.center)),
                          )
                        : IdImageBox2(
                            imagePath: realImgList[index + addInt], imageWidth: 208, imageHeight: 143, round: 8, imageFit: BoxFit.cover),
                const IdSpace(spaceWidth: 0, spaceHeight: 8),
                (editAction)
                    ? textInput('', imgDescControllerList[index + addInt], 'text', 208,
                        (imgList[index + addInt] == null && realImgList[index + addInt] == '') ? false : true)
                    : uiCommon.styledText(
                        (imgDescList[index + addInt].length > 18)
                            ? '${imgDescList[index + addInt].toString().substring(0, 18)}...'
                            : imgDescList[index + addInt],
                        16,
                        0,
                        1.6,
                        FontWeight.w400,
                        IdColors.textSecondly,
                        TextAlign.left)
              ],
            ),
            (index == 2) ? const SizedBox() : const IdSpace(spaceWidth: 16, spaceHeight: 0)
          ],
        ),
      ),
    );
  }

  Widget rentRollContent(String title, String content) {
    return Row(
      children: [
        uiCommon.styledText(title, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
        const IdSpace(spaceWidth: 16, spaceHeight: 0),
        uiCommon.styledText(content, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
      ],
    );
  }

  Widget rentRoll(List rentRollList) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: uiCommon.styledText('Rent Roll', 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          ),
          Column(
            children: List.generate(
              rentRollList.length,
              (index) => (editAction)
                  ? rentRolls[index]
                  : Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: Row(
                            children: [
                              rentRollContent('층', rentRollList[index][0]),
                              const Expanded(child: SizedBox()),
                              rentRollContent('업종', rentRollList[index][1]),
                              const Expanded(child: SizedBox()),
                              rentRollContent('면적(㎡)', '${rentRollList[index][2]}㎡'),
                              const Expanded(child: SizedBox()),
                              rentRollContent(
                                  '보증금(만원)', '${NumberFormat('#,##0.00').format(double.tryParse(rentRollList[index][3]) ?? 0)}만원'),
                              const Expanded(child: SizedBox()),
                              rentRollContent(
                                  '임대료(만원)', '${NumberFormat('#,##0.00').format(double.tryParse(rentRollList[index][4]) ?? 0)}만원'),
                              const Expanded(child: SizedBox()),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          child: rentRollContent('비고', rentRollList[index][5]),
                        ),
                        (index + 1 == rentRollList.length)
                            ? const SizedBox()
                            : Container(
                                width: double.infinity,
                                height: 1,
                                color: IdColors.borderDefault,
                              )
                      ],
                    ),
            ),
          )
        ],
      ),
    );
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
              textInput('', controller, keyboardType, double.infinity, true),
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
      'text',
      () {
        lotInfoList[rowNum - 1][1] = double.tryParse(_lotAreaController.text) ?? 0;
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
      'text',
      () {
        lotInfoList[rowNum - 1][2] = double.tryParse(_lotAreaPyController.text) ?? 0;
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
        lotInfoList[rowNum - 1][3] = _areaPurpoesController.text;
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
      'number',
      () {
        lotInfoList[rowNum - 1][6] = int.tryParse(_sellPriceController.text.replaceAll(',', '')) ?? 0;
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
      'number',
      () {
        lotInfoList[rowNum - 1][4] = double.tryParse(_officialLandPriceController.text.replaceAll(',', '')) ?? 0;
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
      'number',
      () {
        lotInfoList[rowNum - 1][5] = double.tryParse(_totalLandPriceController.text.replaceAll(',', '')) ?? 0;
        totalPricePopupVisible = false;
        setState(() {});
      },
    );
  }

  @override
  Widget idBuild(BuildContext context) {
    if (_memoDs[0].data == null) {
      return const Scaffold(
          backgroundColor: IdColors.white,
          body: GradientProgressIndicator(
              curveType: Curves.decelerate,
              radius: 50,
              duration: 1,
              strokeWidth: 1.5,
              gradientStops: [0.2, 0.8],
              gradientColors: [Colors.white70, Colors.grey],
              child: Text('Loading..', style: TextStyle(color: Colors.white70, fontSize: 10))));
    }
    _memoSvcDS = makeRows();

    var pages = _memoSvcDS.isNotEmpty
        ? IdPaginationWidget(
            buttonColor: Color.fromRGBO(0, 0, 0, 0),
            buttonTextColor: IdColors.black,
            buttonFontSize: 18,
            actualPage: acturalPage,
            countToDisplay: 5,
            totalPages: totalPage,
            onPageChange: (page) async {
              acturalPage = page;
              // clickNumber = 0;
              // ListIndex = 0;
              // _constructReportCheckDS.data!.list. = page;
              fetchData();
            },
            moveToBefore: (page) async {
              acturalPage - 1;
              fetchData();
            },
            moveToNext: (page) async {
              acturalPage + 1;
              fetchData();
            },
          )
        : const SizedBox();

    Widget boardGrid123 = _memoSvcDS.isNotEmpty
        ? IdGrid(
            width: 1224,
            internalGrid: false,
            headerColumns: const ['NO', '작성자', '메모', '일시'],
            columnWidthsPercentages: const <double>[4, 30, 54, 12],
            headerBorderColor: IdColors.borderDefault,
            headerStyle: IdGrid.baseHeaderStyle
                .copyWith(fontSize: 16, color: IdColors.textDefault, fontFamily: 'Pretendard', fontWeight: FontWeight.w600), //header font
            headerInternalGrid: false,
            headerHeight: 58,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 102,
            rowCnt: double.tryParse(_memoDs.length.toString()) ?? 1,
            headerCellRenderer: (idx, content) {
              return Container(
                height: 58,
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
              ),
            ),
            rowDecoration: const BoxDecoration(border: BorderDirectional(bottom: BorderSide(width: 1, color: IdColors.borderDefault))),
            rowInterval: 6,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowColor: IdColors.white,
            hoverColor: IdColors.green5,
            hoverStatus: 'basic',
            rowsCellRenderer: (row, cell, content) {
              return SizedBox(
                height: 102,
                // color: IdColors.green5,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: (cell == 1)
                            ? uiCommon.styledText(content, 18, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.center)
                            : (cell == 2)
                                ? (content.toString().contains(' - ') == true)
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(content.toString().split(' - ')[0],
                                              textAlign: TextAlign.start,
                                              maxLines: 2,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w400,
                                                color: IdColors.textDefault,
                                                fontSize: (cell == 0) ? 18 : 16,
                                              ),
                                              softWrap: true),
                                          const IdSpace(spaceWidth: 0, spaceHeight: 4),
                                          Row(
                                            children: [
                                              const IdImageBox(
                                                  imagePath: 'assets/img/icon_file.png',
                                                  imageWidth: 24,
                                                  imageHeight: 24,
                                                  imageFit: BoxFit.cover),
                                              const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                              uiCommon.styledText(content.toString().split(' - ')[1], 16, 0, 1, FontWeight.w400,
                                                  IdColors.textTertiary, TextAlign.left)
                                            ],
                                          )
                                        ],
                                      )
                                    : (content.toString().length >= 54)
                                        ? IdWithMoreBtn(
                                            content: content,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400,
                                            textColor: IdColors.textDefault,
                                            cell: cell)
                                        : Text(content,
                                            textAlign: (cell == 0 || cell == 3) ? TextAlign.center : TextAlign.start,
                                            maxLines: 2,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              color: (cell == 0 || cell == 3) ? IdColors.textTertiary : IdColors.textDefault,
                                              fontSize: (cell == 0) ? 18 : 16,
                                            ),
                                            softWrap: true)
                                : Text(content,
                                    textAlign: (cell == 0 || cell == 3) ? TextAlign.center : TextAlign.start,
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontWeight: FontWeight.w400,
                                      fontFamily: 'Pretendard',
                                      color: (cell == 0 || cell == 3) ? IdColors.textTertiary : IdColors.textDefault,
                                      fontSize: (cell == 0) ? 18 : 16,
                                    ),
                                    softWrap: true),
                      ),
                    ],
                  ),
                ),
              );
            },
            noContentWidget: const SizedBox(), //Center(child: Container(width: 30, height: 30, child: CircularProgressIndicator())),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              setState(() {});
            },
            data: _memoSvcDS)
        : Container(
            width: 1224,
            height: 400,
            decoration: const BoxDecoration(
              border: Border(
                top: BorderSide(width: 1, color: IdColors.borderDefault),
                bottom: BorderSide(width: 1, color: IdColors.borderDefault),
              ),
            ),
            child: Center(
              child: uiCommon.styledText('게시물이 존재하지 않습니다.', 16, 0, 1.6, FontWeight.w400, IdColors.textTertiary, TextAlign.center),
            ),
          );

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
                      //상단
                      Container(
                        width: double.infinity,
                        height: 500,
                        // color: IdColors.pageTopBackground,
                        color: IdColors.green2,
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 1224,
                            ),
                            child: Column(
                              children: [
                                IdTopNavigator(navigatorMenu: menuNavigator, navigatorLink: menuNavigatorLink),
                                IdPageTopSection(
                                  menuName: '마이페이지',
                                  pageDesc: 'My Page',
                                  imgBoxWidget: const IdImageBox(
                                      imagePath: 'assets/img/img_myDeal.png', imageWidth: 420, imageHeight: 315.99, imageFit: BoxFit.cover),
                                  navigator:
                                      IdSubNavigator(pageName: '내가 등록한 딜', subMenu: submenuNameList, subMenuLink: submenuNavigatorLink),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //섹션
                      Container(
                        width: double.infinity,
                        color: IdColors.white,
                        child: Column(
                          children: [
                            const IdSpace(spaceWidth: 0, spaceHeight: 100),
                            Column(
                              children: [
                                Container(
                                  constraints: const BoxConstraints(maxWidth: 1224),
                                  child: Column(
                                    children: [
                                      Stack(
                                        children: [
                                          Container(
                                            width: double.infinity,
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
                                              children: [
                                                Row(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    Expanded(
                                                      child: Padding(
                                                        padding: const EdgeInsets.only(top: 45.5),
                                                        child: Row(
                                                          crossAxisAlignment: CrossAxisAlignment.center,
                                                          children: [
                                                            uiCommon.styledText(pageTitle, 32, 0, 1, FontWeight.w700, IdColors.textDefault,
                                                                TextAlign.start),
                                                            const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                            (editAction)
                                                                ? IdNormalBtn(
                                                                    onBtnPressed: () {
                                                                      if (dealStatusSelectVisible) {
                                                                        dealStatusSelectVisible = false;
                                                                      } else {
                                                                        dealStatusSelectVisible = true;
                                                                      }
                                                                      setState(() {});
                                                                    },
                                                                    childWidget: IdStatus(status: status2),
                                                                  )
                                                                : IdStatus(status: status2),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    Row(
                                                      children: [
                                                        (status1 == '2')
                                                            ? IdNormalBtn(
                                                                onBtnPressed: () {
                                                                  GV.pStrg.putXXX(Param_pdfStatus, 'cref');
                                                                  uiCommon.IdMovePage(context, PAGE_CERT_PDF_PAGE);
                                                                },
                                                                childWidget: Container(
                                                                  width: 178,
                                                                  height: 48,
                                                                  decoration: BoxDecoration(
                                                                    color: IdColors.certification,
                                                                    borderRadius: BorderRadius.circular(40),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      const IdImageBox(
                                                                          imagePath: 'assets/img/icon_certification.png',
                                                                          imageWidth: 24,
                                                                          imageHeight: 24,
                                                                          imageFit: BoxFit.cover),
                                                                      const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                      uiCommon.styledText('인증서 보기', 18, 0, 1, FontWeight.w700,
                                                                          IdColors.white, TextAlign.center)
                                                                    ],
                                                                  ),
                                                                ),
                                                              )
                                                            : IdNormalBtn(
                                                                onBtnPressed: () {
                                                                  GV.pStrg.putXXX(Param_dealAddress, address);
                                                                  GV.pStrg.putXXX(Param_newDealNo, dealNo);
                                                                  uiCommon.IdMovePage(context, PAGE_DEAL_STEP_04_3_PAGE);
                                                                },
                                                                childWidget: Container(
                                                                  width: 159,
                                                                  height: 48,
                                                                  decoration: BoxDecoration(
                                                                    color: IdColors.orange1,
                                                                    borderRadius: BorderRadius.circular(40),
                                                                  ),
                                                                  child: Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      const IdImageBox(
                                                                          imagePath: 'assets/img/icon_shild_white.png',
                                                                          imageWidth: 24,
                                                                          imageHeight: 24,
                                                                          imageFit: BoxFit.cover),
                                                                      const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                      uiCommon.styledText('안심중개권 신청', 18, -1, 1, FontWeight.w700,
                                                                          IdColors.white, TextAlign.center)
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                        IdNormalBtn(
                                                          onBtnPressed: () {
                                                            GV.pStrg.putXXX(Param_pdfStatus, 'tm');
                                                            uiCommon.IdMovePage(context, PAGE_TM_PDF_PAGE);
                                                          },
                                                          childWidget: Container(
                                                            width: 155,
                                                            height: 48,
                                                            decoration: BoxDecoration(
                                                              color: IdColors.green2,
                                                              borderRadius: BorderRadius.circular(40),
                                                            ),
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: [
                                                                const IdImageBox(
                                                                    imagePath: 'assets/img/icon_download_white.png',
                                                                    imageWidth: 24,
                                                                    imageHeight: 24,
                                                                    imageFit: BoxFit.cover),
                                                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                uiCommon.styledText(
                                                                    'TM추출', 18, 0, 1, FontWeight.w700, IdColors.white, TextAlign.center)
                                                              ],
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Row(
                                                  children: [
                                                    SizedBox(
                                                      child: Row(
                                                        children: [
                                                          Row(
                                                            children: [
                                                              IdImageBox(
                                                                  imagePath: (type == 'L')
                                                                      ? 'assets/img/icon_mydeal_01.png'
                                                                      : 'assets/img/icon_mydeal_02.png',
                                                                  imageHeight: 24,
                                                                  imageWidth: 24,
                                                                  imageFit: BoxFit.cover),
                                                              const IdSpace(spaceWidth: 10, spaceHeight: 0),
                                                              uiCommon.styledText((type == 'L') ? '신축부지' : '건물', 18, 0, 1, FontWeight.w600,
                                                                  IdColors.textDefault, TextAlign.left)
                                                            ],
                                                          ),
                                                          Row(
                                                            children: [
                                                              const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                              Row(
                                                                children: [
                                                                  IdImageBox(
                                                                      imagePath: (category == '1')
                                                                          ? 'assets/img/icon_target.png'
                                                                          : 'assets/img/icon_mydeal_04.png',
                                                                      imageHeight: 24,
                                                                      imageWidth: 24,
                                                                      imageFit: BoxFit.cover),
                                                                  const IdSpace(spaceWidth: 10, spaceHeight: 0),
                                                                  uiCommon.styledText((category == '1') ? '매각' : '위탁운영', 18, 0, 1,
                                                                      FontWeight.w600, IdColors.textDefault, TextAlign.left)
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                //기타 정보
                                                Container(
                                                  decoration: const BoxDecoration(
                                                    border: Border(
                                                      top: BorderSide(width: 2, color: IdColors.black),
                                                    ),
                                                  ),
                                                  child: Column(
                                                    children: [
                                                      contentsTitle(
                                                        '기타 정보',
                                                        const SizedBox(),
                                                      ),
                                                      (type == 'L')
                                                          ? (editAction)
                                                              ? contentsRowEdit1(
                                                                  '위치 특이사항',
                                                                  checkBox(areaList, areaNumList, 6),
                                                                )
                                                              : contentsRow(
                                                                  '위치 특이사항',
                                                                  FontWeight.w400,
                                                                  additional,
                                                                  FontWeight.w600,
                                                                  '',
                                                                  FontWeight.w400,
                                                                  '',
                                                                  FontWeight.w600,
                                                                )
                                                          : (editAction)
                                                              ? Column(
                                                                  children: [
                                                                    contentsRowEdit1(
                                                                      '위치 특이사항',
                                                                      checkBox(areaList, areaNumList, 6),
                                                                    ),
                                                                    contentsRowEdit1(
                                                                      '물건 특이사항',
                                                                      checkBox(buildingList, buildingNumList, 4),
                                                                    ),
                                                                  ],
                                                                )
                                                              : contentsRow(
                                                                  '위치 특이사항',
                                                                  FontWeight.w400,
                                                                  additional,
                                                                  FontWeight.w600,
                                                                  '물건 특이사항',
                                                                  FontWeight.w400,
                                                                  bdAdditional,
                                                                  FontWeight.w600,
                                                                ),
                                                      (editAction)
                                                          ? contentsRowEdit1(
                                                              '기타 특이사항',
                                                              textInput('', _additionalEtcController, 'text', 800, true),
                                                            )
                                                          : contentsRow(
                                                              '기타 특이사항',
                                                              FontWeight.w400,
                                                              additionalEtc,
                                                              FontWeight.w600,
                                                              '',
                                                              FontWeight.w400,
                                                              '',
                                                              FontWeight.w600,
                                                            ),
                                                      //사진
                                                      const IdSpace(spaceWidth: 0, spaceHeight: 24),
                                                      SizedBox(
                                                        width: double.infinity,
                                                        height: (editAction) ? 617 : 563,
                                                        child: Row(
                                                          children: [
                                                            SizedBox(
                                                              width: 432,
                                                              height: double.infinity,
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(
                                                                    child: (editAction)
                                                                        ? IdNormalBtn(
                                                                            onBtnPressed: () {
                                                                              cropFile(1);
                                                                            },
                                                                            childWidget: (realImgList[0] == '')
                                                                                ? Container(
                                                                                    width: double.infinity,
                                                                                    height: double.infinity,
                                                                                    decoration: BoxDecoration(
                                                                                        color: IdColors.green5,
                                                                                        borderRadius: BorderRadius.circular(8),
                                                                                        border:
                                                                                            Border.all(width: 1, color: IdColors.green2)),
                                                                                    child: Center(
                                                                                        child: uiCommon.styledText(
                                                                                            '이미지를 넣어주세요.',
                                                                                            20,
                                                                                            0,
                                                                                            1.6,
                                                                                            FontWeight.w700,
                                                                                            IdColors.green2,
                                                                                            TextAlign.center)),
                                                                                  )
                                                                                : (imgList[0] == null)
                                                                                    ? IdImageBox2(
                                                                                        imagePath: realImgList[0],
                                                                                        imageWidth: 432,
                                                                                        imageHeight: double.infinity,
                                                                                        round: 8,
                                                                                        imageFit: BoxFit.cover)
                                                                                    : SizedBox(
                                                                                        width: 432,
                                                                                        height: double.infinity,
                                                                                        child: imgList[0]),
                                                                          )
                                                                        : (realImgList[0] == '')
                                                                            ? Container(
                                                                                width: double.infinity,
                                                                                height: double.infinity,
                                                                                decoration: BoxDecoration(
                                                                                  color: IdColors.backgroundDefault,
                                                                                  borderRadius: BorderRadius.circular(8),
                                                                                ),
                                                                                child: Center(
                                                                                    child: uiCommon.styledText(
                                                                                        '이미지가 없습니다.',
                                                                                        20,
                                                                                        0,
                                                                                        1.6,
                                                                                        FontWeight.w700,
                                                                                        IdColors.textSecondly,
                                                                                        TextAlign.center)),
                                                                              )
                                                                            : IdImageBox2(
                                                                                imagePath: realImgList[0],
                                                                                imageWidth: 432,
                                                                                imageHeight: double.infinity,
                                                                                round: 8,
                                                                                imageFit: BoxFit.cover),
                                                                  ),
                                                                  const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                                                  (editAction)
                                                                      ? textInput('', imgDescControllerList[0], 'text', 432, true)
                                                                      : uiCommon.styledText(imgDescList[0], 16, 0, 1.6, FontWeight.w400,
                                                                          IdColors.textSecondly, TextAlign.left)
                                                                ],
                                                              ),
                                                            ),
                                                            const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                            Column(
                                                              children: [
                                                                imgGridRow(imgList, imgDescList, 1, imgDescControllerList),
                                                                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                                imgGridRow(imgList, imgDescList, 4, imgDescControllerList),
                                                                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                                imgGridRow(imgList, imgDescList, 7, imgDescControllerList),
                                                              ],
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      const IdSpace(spaceWidth: 0, spaceHeight: 24),

                                                      //기타 자료등록
                                                      SizedBox(
                                                        width: double.infinity,
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                            uiCommon.styledText('기타 자료등록<unit2>(TM 자료)</unit2>', 18, 0, 1.6,
                                                                FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                                            (editAction)
                                                                ? contentsRowEdit1(
                                                                    'TM 자료 이름',
                                                                    Row(
                                                                      children: [
                                                                        textInput('', _TM_InfoController, 'text', 300, false),
                                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                        IdNormalBtn(
                                                                          onBtnPressed: () {
                                                                            // cropFile(11);
                                                                            otherUploadFile(11);
                                                                          },
                                                                          childWidget: Container(
                                                                            width: 97,
                                                                            height: 44,
                                                                            decoration: BoxDecoration(
                                                                              color: IdColors.green2,
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                            child: Center(
                                                                              child: uiCommon.styledText('파일찾기', 16, 0, 1, FontWeight.w700,
                                                                                  IdColors.white, TextAlign.center),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ))
                                                                : contentsRow(
                                                                    'TM 자료 이름',
                                                                    FontWeight.w400,
                                                                    tmName,
                                                                    FontWeight.w600,
                                                                    '',
                                                                    FontWeight.w400,
                                                                    '',
                                                                    FontWeight.w600,
                                                                  ),
                                                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                                            (editAction)
                                                                ? contentsRowEdit1(
                                                                    '도면이름',
                                                                    Row(
                                                                      children: [
                                                                        textInput('', _floorPlanController, 'text', 300, false),
                                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                        IdNormalBtn(
                                                                          onBtnPressed: () {
                                                                            otherUploadFile(12);
                                                                          },
                                                                          childWidget: Container(
                                                                            width: 97,
                                                                            height: 44,
                                                                            decoration: BoxDecoration(
                                                                              color: IdColors.green2,
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                            child: Center(
                                                                              child: uiCommon.styledText('파일찾기', 16, 0, 1, FontWeight.w700,
                                                                                  IdColors.white, TextAlign.center),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ))
                                                                : contentsRow(
                                                                    '도면이름',
                                                                    FontWeight.w400,
                                                                    floorPlanImgName,
                                                                    FontWeight.w600,
                                                                    '',
                                                                    FontWeight.w400,
                                                                    '',
                                                                    FontWeight.w600,
                                                                  ),
                                                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                                            (editAction)
                                                                ? contentsRowEdit1(
                                                                    '기타자료 이름',
                                                                    Row(
                                                                      children: [
                                                                        textInput('', _otherController, 'text', 300, false),
                                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                        IdNormalBtn(
                                                                          onBtnPressed: () {
                                                                            otherUploadFile(13);
                                                                          },
                                                                          childWidget: Container(
                                                                            width: 97,
                                                                            height: 44,
                                                                            decoration: BoxDecoration(
                                                                              color: IdColors.green2,
                                                                              borderRadius: BorderRadius.circular(8),
                                                                            ),
                                                                            child: Center(
                                                                              child: uiCommon.styledText('파일찾기', 16, 0, 1, FontWeight.w700,
                                                                                  IdColors.white, TextAlign.center),
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ))
                                                                : contentsRow(
                                                                    '기타자료 이름',
                                                                    FontWeight.w400,
                                                                    otherImgname,
                                                                    FontWeight.w600,
                                                                    '',
                                                                    FontWeight.w400,
                                                                    '',
                                                                    FontWeight.w600,
                                                                  ),
                                                          ],
                                                        ),
                                                      ),
                                                      const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                    ],
                                                  ),
                                                ),
                                                Column(
                                                  children: [
                                                    //제안할 부동산 기본 정보
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(width: 2, color: IdColors.black),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          contentsTitle(
                                                            '제안할 부동산 기본 정보',
                                                            IdNormalBtn(
                                                              onBtnPressed: () {
                                                                mapPopupVisible = true;
                                                                setState(() {});
                                                              },
                                                              childWidget: Container(
                                                                width: 97,
                                                                height: 38,
                                                                decoration: BoxDecoration(
                                                                  color: IdColors.backgroundDefault,
                                                                  borderRadius: BorderRadius.circular(8),
                                                                ),
                                                                child: Center(
                                                                  child: uiCommon.styledText('지도보기', 14, 0, 1, FontWeight.w600,
                                                                      IdColors.textTertiary, TextAlign.center),
                                                                ),
                                                              ),
                                                            ),
                                                          ),
                                                          (type == 'L')
                                                              ? Column(
                                                                  children: [
                                                                    (editAction)
                                                                        ? Column(
                                                                            children: [
                                                                              contentsRowEdit1(
                                                                                '등록자',
                                                                                Row(
                                                                                  children: [
                                                                                    Row(
                                                                                      children: List.generate(
                                                                                          registrantBoolList.length,
                                                                                          (index) => radioWithLable2(() {
                                                                                                if (registrantBoolList[index]) {
                                                                                                  registrantBoolList = [
                                                                                                    false,
                                                                                                    false,
                                                                                                    false,
                                                                                                    false
                                                                                                  ];
                                                                                                  registrantBoolList[index] = true;
                                                                                                } else {
                                                                                                  registrantBoolList = [
                                                                                                    false,
                                                                                                    false,
                                                                                                    false,
                                                                                                    false
                                                                                                  ];
                                                                                                  registrantBoolList[index] = true;
                                                                                                  if (index != 3) {
                                                                                                    _registrantController.text = '';
                                                                                                  }
                                                                                                }
                                                                                                setState(
                                                                                                  () {},
                                                                                                );
                                                                                              },
                                                                                                  registrantBoolList[index],
                                                                                                  IdColors.green2,
                                                                                                  registrantList[index],
                                                                                                  IdColors.textDefault,
                                                                                                  true)),
                                                                                    ),
                                                                                    textInput('', _registrantController, 'text', 200,
                                                                                        registrantBoolList[3])
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              contentsRowEdit1(
                                                                                  '소재지',
                                                                                  Row(
                                                                                    children: [
                                                                                      textInput(_addressController.text, _addressController,
                                                                                          'text', 300, false),
                                                                                      const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                                                      IdNormalBtn(
                                                                                        onBtnPressed: () {
                                                                                          lotListNum = 0;
                                                                                          addressPopup = true;
                                                                                          setState(() {});
                                                                                        },
                                                                                        childWidget: Container(
                                                                                          width: 74,
                                                                                          height: 44,
                                                                                          decoration: ShapeDecoration(
                                                                                            color: Colors.white.withOpacity(0),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              side: const BorderSide(
                                                                                                  width: 1, color: IdColors.textDefault),
                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                            ),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: uiCommon.styledText(
                                                                                                '검색',
                                                                                                15,
                                                                                                0,
                                                                                                1,
                                                                                                FontWeight.w600,
                                                                                                IdColors.textDefault,
                                                                                                TextAlign.left),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )),
                                                                            ],
                                                                          )
                                                                        : contentsRow(
                                                                            '등록자',
                                                                            FontWeight.w400,
                                                                            register,
                                                                            FontWeight.w600,
                                                                            '소재지',
                                                                            FontWeight.w400,
                                                                            address,
                                                                            FontWeight.w600,
                                                                          ),
                                                                    Container(
                                                                      width: double.infinity,
                                                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                                                      child: uiCommon.styledText('필지정보', 16, 0, 1.6, FontWeight.w400,
                                                                          IdColors.textDefault, TextAlign.left),
                                                                    ),
                                                                    //TODO 필지정보 테이블
                                                                    infoTable(),
                                                                  ],
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    (editAction)
                                                                        ? Column(
                                                                            children: [
                                                                              contentsRowEdit1(
                                                                                '등록자',
                                                                                Row(
                                                                                  children: [
                                                                                    Row(
                                                                                      children: List.generate(
                                                                                          registrantBoolList.length,
                                                                                          (index) => radioWithLable2(() {
                                                                                                if (registrantBoolList[index]) {
                                                                                                  registrantBoolList = [
                                                                                                    false,
                                                                                                    false,
                                                                                                    false,
                                                                                                    false
                                                                                                  ];
                                                                                                  registrantBoolList[index] = true;
                                                                                                } else {
                                                                                                  registrantBoolList = [
                                                                                                    false,
                                                                                                    false,
                                                                                                    false,
                                                                                                    false
                                                                                                  ];
                                                                                                  registrantBoolList[index] = true;
                                                                                                  if (index != 3) {
                                                                                                    _registrantController.text = '';
                                                                                                  }
                                                                                                }
                                                                                                setState(
                                                                                                  () {},
                                                                                                );
                                                                                              },
                                                                                                  registrantBoolList[index],
                                                                                                  IdColors.green2,
                                                                                                  registrantList[index],
                                                                                                  IdColors.textDefault,
                                                                                                  true)),
                                                                                    ),
                                                                                    textInput('', _registrantController, 'text', 200,
                                                                                        registrantBoolList[3])
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              contentsRowEdit1(
                                                                                  '소재지',
                                                                                  Row(
                                                                                    children: [
                                                                                      textInput(_addressController.text, _addressController,
                                                                                          'text', 300, false),
                                                                                      const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                                                      IdNormalBtn(
                                                                                        onBtnPressed: () {
                                                                                          lotListNum = 0;
                                                                                          addressPopup = true;
                                                                                          setState(() {});
                                                                                        },
                                                                                        childWidget: Container(
                                                                                          width: 74,
                                                                                          height: 44,
                                                                                          decoration: ShapeDecoration(
                                                                                            color: Colors.white.withOpacity(0),
                                                                                            shape: RoundedRectangleBorder(
                                                                                              side: const BorderSide(
                                                                                                  width: 1, color: IdColors.textDefault),
                                                                                              borderRadius: BorderRadius.circular(8),
                                                                                            ),
                                                                                          ),
                                                                                          child: Center(
                                                                                            child: uiCommon.styledText(
                                                                                                '검색',
                                                                                                15,
                                                                                                0,
                                                                                                1,
                                                                                                FontWeight.w600,
                                                                                                IdColors.textDefault,
                                                                                                TextAlign.left),
                                                                                          ),
                                                                                        ),
                                                                                      ),
                                                                                    ],
                                                                                  )),
                                                                            ],
                                                                          )
                                                                        : contentsRow(
                                                                            '등록자',
                                                                            FontWeight.w400,
                                                                            register,
                                                                            FontWeight.w600,
                                                                            '소재지',
                                                                            FontWeight.w400,
                                                                            address,
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '건물명',
                                                                            textInput(_buildingNameController.text, _buildingNameController,
                                                                                'text', 250, true),
                                                                            '대지면적(㎡)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_lotAreaController.text, _lotAreaController,
                                                                                    'text', 250, true),
                                                                                uiCommon.styledText('㎡', 16, 0, 1.6, FontWeight.w600,
                                                                                    IdColors.textDefault, TextAlign.left)
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : contentsRow(
                                                                            '건물명',
                                                                            FontWeight.w400,
                                                                            buildingName,
                                                                            FontWeight.w600,
                                                                            '대지면적(㎡)',
                                                                            FontWeight.w400,
                                                                            NumberFormat('#,##0.00').format(double.tryParse(lotArea) ?? 0) +
                                                                                '㎡',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '연면적(㎡)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_totalFloorAreaController.text,
                                                                                    _totalFloorAreaController, 'text', 250, true),
                                                                                uiCommon.styledText('㎡', 16, 0, 1.6, FontWeight.w600,
                                                                                    IdColors.textDefault, TextAlign.left)
                                                                              ],
                                                                            ),
                                                                            '용도지역',
                                                                            textInput(_areaPurpoesController.text, _areaPurpoesController,
                                                                                'text', 250, true),
                                                                          )
                                                                        : contentsRow(
                                                                            '연면적(㎡)',
                                                                            FontWeight.w400,
                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(totalFloorArea) ?? 0)}㎡',
                                                                            FontWeight.w600,
                                                                            '용도지역',
                                                                            FontWeight.w400,
                                                                            areaPurpose,
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '용적률(%)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_totalFloorRatioController.text,
                                                                                    _totalFloorRatioController, 'text', 250, true),
                                                                                uiCommon.styledText('%', 16, 0, 1.6, FontWeight.w600,
                                                                                    IdColors.textDefault, TextAlign.left)
                                                                              ],
                                                                            ),
                                                                            '건폐율',
                                                                            textInput(_bdCoverageRatioController.text,
                                                                                _bdCoverageRatioController, 'text', 250, true),
                                                                          )
                                                                        : contentsRow(
                                                                            '용적률(%)',
                                                                            FontWeight.w400,
                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(totalFloorRatio) ?? 0)}%',
                                                                            FontWeight.w600,
                                                                            '건폐율(%)',
                                                                            FontWeight.w400,
                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(bdCoverageRatio) ?? 0)}%',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '지구단위계획구역',
                                                                            textInput(_bdDistrictUnitPlanController.text,
                                                                                _bdDistrictUnitPlanController, 'text', 250, true),
                                                                            '주용도',
                                                                            textInput(_mainPurposeController.text, _mainPurposeController,
                                                                                'text', 250, true),
                                                                          )
                                                                        : contentsRow(
                                                                            '지구단위계획구역',
                                                                            FontWeight.w400,
                                                                            bdDistrictUnitPlan,
                                                                            FontWeight.w600,
                                                                            '주용도',
                                                                            FontWeight.w400,
                                                                            mainPurpose,
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '주구조',
                                                                            textInput(_mainStructController.text, _mainStructController,
                                                                                'text', 250, true),
                                                                            '준공연도',
                                                                            textInput(
                                                                                _ccdController.text, _ccdController, 'text', 250, true),
                                                                          )
                                                                        : contentsRow(
                                                                            '주구조',
                                                                            FontWeight.w400,
                                                                            mainStruct,
                                                                            FontWeight.w600,
                                                                            '준공연도',
                                                                            FontWeight.w400,
                                                                            ccd,
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '지상/지하',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_upperNumController.text, _upperNumController,
                                                                                    'text', 118, true),
                                                                                uiCommon.styledText(' / ', 16, 0, 1.6, FontWeight.w600,
                                                                                    IdColors.textDefault, TextAlign.left),
                                                                                textInput(_lowerNumController.text, _lowerNumController,
                                                                                    'text', 118, true),
                                                                              ],
                                                                            ),
                                                                            '승강기(대)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_elevatorController.text, _elevatorController,
                                                                                    'text', 250, true),
                                                                                uiCommon.styledText('대', 16, 0, 1.6, FontWeight.w600,
                                                                                    IdColors.textDefault, TextAlign.left)
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : contentsRow(
                                                                            '지상/지하',
                                                                            FontWeight.w400,
                                                                            '${NumberFormat('#,###').format(double.tryParse(upperNum) ?? 0)}/${NumberFormat('#,###').format(double.tryParse(lowerNum) ?? 0)}',
                                                                            FontWeight.w600,
                                                                            '승강기(대)',
                                                                            FontWeight.w400,
                                                                            '${NumberFormat('#,###').format(double.tryParse(elevator) ?? 0)}대',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '주차장(대)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_parkingNumController.text, _parkingNumController,
                                                                                    'text', 250, true),
                                                                                uiCommon.styledText('대', 16, 0, 1.6, FontWeight.w600,
                                                                                    IdColors.textDefault, TextAlign.left)
                                                                              ],
                                                                            ),
                                                                            '공시지가(만원)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_officialLandPriceController.text,
                                                                                    _officialLandPriceController, 'text', 250, true),
                                                                                uiCommon.styledText('만원', 16, 0, 1.6, FontWeight.w600,
                                                                                    IdColors.textDefault, TextAlign.left)
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : contentsRow(
                                                                            '주차장(대)',
                                                                            FontWeight.w400,
                                                                            '${NumberFormat('#,###').format(double.tryParse(parkingNum) ?? 0)}대',
                                                                            FontWeight.w600,
                                                                            '공시지가(만원)',
                                                                            FontWeight.w400,
                                                                            IdStrUtil.toMoneyUnitKr(NumberFormat('#,##0.00')
                                                                                    .format(double.tryParse(officialLandPrice) ?? 0)) +
                                                                                '만원',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '공시지가 합계(만원)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_totalLandPriceController.text,
                                                                                    _totalLandPriceController, 'text', 250, true),
                                                                                uiCommon.styledText('만원', 16, 0, 1.6, FontWeight.w600,
                                                                                    IdColors.textDefault, TextAlign.left)
                                                                              ],
                                                                            ),
                                                                            '',
                                                                            SizedBox())
                                                                        : contentsRow(
                                                                            '공시지가 합계(만원)',
                                                                            FontWeight.w400,
                                                                            IdStrUtil.toMoneyUnitKr(NumberFormat('#,##0.00')
                                                                                    .format(double.tryParse(totalLandPrice) ?? 0)) +
                                                                                '만원',
                                                                            FontWeight.w600,
                                                                            '',
                                                                            FontWeight.w400,
                                                                            '',
                                                                            FontWeight.w600,
                                                                          ),
                                                                  ],
                                                                ),
                                                          const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                        ],
                                                      ),
                                                    ),
                                                    //제안할 부동산 거래 정보
                                                    Container(
                                                      decoration: const BoxDecoration(
                                                        border: Border(
                                                          top: BorderSide(width: 2, color: IdColors.black),
                                                        ),
                                                      ),
                                                      child: Column(
                                                        children: [
                                                          contentsTitle(
                                                            '제안할 부동산 거래 정보',
                                                            const SizedBox(),
                                                          ),
                                                          (type == 'L')
                                                              ? Column(
                                                                  children: [
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '희망매각가(억원)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_askingController.text, _askingController, 'text',
                                                                                    250, true)
                                                                              ],
                                                                            ),
                                                                            '가격협의',
                                                                            Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: List.generate(
                                                                                  negotiateList.length,
                                                                                  (index) => radioWithLable2(() {
                                                                                    negotiateINT = index + 1;
                                                                                    setState(() {});
                                                                                  },
                                                                                      (negotiateINT == index + 1) ? true : false,
                                                                                      IdColors.green2,
                                                                                      negotiateList[index],
                                                                                      IdColors.textDefault,
                                                                                      true),
                                                                                )))
                                                                        : contentsRow(
                                                                            '희망매각가(억원)',
                                                                            FontWeight.w400,
                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(masterAsking) ?? 0)}억원',
                                                                            FontWeight.w600,
                                                                            '가격협의',
                                                                            FontWeight.w400,
                                                                            negotiationType,
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? Column(
                                                                            children: [
                                                                              contentsRowEdit1(
                                                                                '자산현황',
                                                                                Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: List.generate(
                                                                                      assetList.length,
                                                                                      (index) => radioWithLable2(() {
                                                                                        assetINT = index + 1;
                                                                                        setState(() {});
                                                                                      },
                                                                                          (assetINT == index + 1) ? true : false,
                                                                                          IdColors.green2,
                                                                                          assetList[index],
                                                                                          IdColors.textDefault,
                                                                                          true),
                                                                                    )),
                                                                              ),
                                                                              contentsRowEdit1(
                                                                                '예상명도기간(개월)',
                                                                                Row(
                                                                                  children: [
                                                                                    textInput(_evacuationPeriodController.text,
                                                                                        _evacuationPeriodController, 'number', 250, true),
                                                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                                    Row(
                                                                                      children: [
                                                                                        IdNormalBtn(
                                                                                          onBtnPressed: () {
                                                                                            //
                                                                                            if (evacuationChkBool) {
                                                                                              evacuationChkBool = false;
                                                                                            } else {
                                                                                              evacuationChkBool = true;
                                                                                            }
                                                                                            setState(() {});
                                                                                          },
                                                                                          childWidget: IdImageBox(
                                                                                              imagePath: evacuationChkBool
                                                                                                  ? 'assets/img/icon_checkBox_checked.png'
                                                                                                  : 'assets/img/icon_checkBox_none.png',
                                                                                              imageWidth: 20,
                                                                                              imageHeight: 20,
                                                                                              imageFit: BoxFit.contain),
                                                                                        ),
                                                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                                        uiCommon.styledText('협의', 18, 0, 1, FontWeight.w500,
                                                                                            IdColors.textDefault, TextAlign.left)
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : contentsRow(
                                                                            '자산현황',
                                                                            FontWeight.w400,
                                                                            assetStatus,
                                                                            FontWeight.w600,
                                                                            '예상명도기간(개월)',
                                                                            FontWeight.w400,
                                                                            (evacuationPeriod != '0')
                                                                                ? (evacuationChk == 'N')
                                                                                    ? '$evacuationPeriod개월'
                                                                                    : '$evacuationPeriod개월 (협의)'
                                                                                : '즉시가능',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? Column(
                                                                            children: [
                                                                              contentsRowEdit1(
                                                                                '소유자',
                                                                                Row(
                                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                                    children: List.generate(
                                                                                      ownerList.length,
                                                                                      (index) => radioWithLable2(() {
                                                                                        ownerINT = index + 1;
                                                                                        setState(() {});
                                                                                      },
                                                                                          (ownerINT == index + 1) ? true : false,
                                                                                          IdColors.green2,
                                                                                          ownerList[index],
                                                                                          IdColors.textDefault,
                                                                                          true),
                                                                                    )),
                                                                              ),
                                                                              contentsRowEdit1(
                                                                                '인근 지하철/거리',
                                                                                Row(
                                                                                  children: [
                                                                                    textInput(_stationController.text, _stationController,
                                                                                        'text', 200, true),
                                                                                    uiCommon.styledText(' / ', 16, 0, 1.6, FontWeight.w600,
                                                                                        IdColors.textDefault, TextAlign.center),
                                                                                    textInput(_stationDistanceController.text,
                                                                                        _stationDistanceController, 'text', 200, true),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : contentsRow(
                                                                            '소유자',
                                                                            FontWeight.w400,
                                                                            owner,
                                                                            FontWeight.w600,
                                                                            '인근 지하철/거리',
                                                                            FontWeight.w400,
                                                                            '$stationName/$stationDistance',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    Container(
                                                                      padding: const EdgeInsets.symmetric(vertical: 16),
                                                                      decoration: const BoxDecoration(
                                                                        border: Border(
                                                                          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
                                                                        ),
                                                                      ),
                                                                      child: Row(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          SizedBox(
                                                                            width: 130,
                                                                            child: uiCommon.styledText('신축예상규모\n(인허가/착공)', 16, 0, 1.6,
                                                                                FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                                          ),
                                                                          const IdSpace(spaceWidth: 40, spaceHeight: 0),
                                                                          Expanded(
                                                                            child: SizedBox(
                                                                              width: double.infinity,
                                                                              child: (editAction)
                                                                                  ? Column(
                                                                                      children: [
                                                                                        subContentsEdit(
                                                                                          '용도',
                                                                                          textInput(_landUseController.text,
                                                                                              _landUseController, 'text', 150, true),
                                                                                          '용적률',
                                                                                          Row(
                                                                                            children: [
                                                                                              textInput(
                                                                                                  _totalFloorRatioController.text,
                                                                                                  _totalFloorRatioController,
                                                                                                  'text',
                                                                                                  150,
                                                                                                  true),
                                                                                              uiCommon.styledText(
                                                                                                  '%',
                                                                                                  16,
                                                                                                  0,
                                                                                                  1.6,
                                                                                                  FontWeight.w500,
                                                                                                  IdColors.textDefault,
                                                                                                  TextAlign.left)
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        subContentsEdit(
                                                                                          '건폐율',
                                                                                          Row(
                                                                                            children: [
                                                                                              textInput(
                                                                                                  _bdCoverageRatioController.text,
                                                                                                  _bdCoverageRatioController,
                                                                                                  'text',
                                                                                                  150,
                                                                                                  true),
                                                                                              uiCommon.styledText(
                                                                                                  '%',
                                                                                                  16,
                                                                                                  0,
                                                                                                  1.6,
                                                                                                  FontWeight.w500,
                                                                                                  IdColors.textDefault,
                                                                                                  TextAlign.left)
                                                                                            ],
                                                                                          ),
                                                                                          '건축면적',
                                                                                          Row(
                                                                                            children: [
                                                                                              textInput(
                                                                                                  _buildingAreaController.text,
                                                                                                  _buildingAreaController,
                                                                                                  'text',
                                                                                                  150,
                                                                                                  true),
                                                                                              uiCommon.styledText(
                                                                                                  '㎡',
                                                                                                  16,
                                                                                                  0,
                                                                                                  1.6,
                                                                                                  FontWeight.w500,
                                                                                                  IdColors.textDefault,
                                                                                                  TextAlign.left)
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        subContentsEdit(
                                                                                          '연면적',
                                                                                          Row(
                                                                                            children: [
                                                                                              textInput(
                                                                                                  _totalFloorAreaController.text,
                                                                                                  _totalFloorAreaController,
                                                                                                  'text',
                                                                                                  150,
                                                                                                  true),
                                                                                              uiCommon.styledText(
                                                                                                  '㎡',
                                                                                                  16,
                                                                                                  0,
                                                                                                  1.6,
                                                                                                  FontWeight.w500,
                                                                                                  IdColors.textDefault,
                                                                                                  TextAlign.left)
                                                                                            ],
                                                                                          ),
                                                                                          '지상 연면적',
                                                                                          Row(
                                                                                            children: [
                                                                                              textInput(
                                                                                                  _upperFloorAreaController.text,
                                                                                                  _upperFloorAreaController,
                                                                                                  'text',
                                                                                                  150,
                                                                                                  true),
                                                                                              uiCommon.styledText(
                                                                                                  '㎡',
                                                                                                  16,
                                                                                                  0,
                                                                                                  1.6,
                                                                                                  FontWeight.w500,
                                                                                                  IdColors.textDefault,
                                                                                                  TextAlign.left)
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        subContentsEdit(
                                                                                          '지상/지하',
                                                                                          Row(
                                                                                            children: [
                                                                                              textInput(_upperNumController.text,
                                                                                                  _upperNumController, 'text', 70, true),
                                                                                              uiCommon.styledText(
                                                                                                  '/',
                                                                                                  16,
                                                                                                  0,
                                                                                                  1.6,
                                                                                                  FontWeight.w500,
                                                                                                  IdColors.textDefault,
                                                                                                  TextAlign.left),
                                                                                              textInput(_lowerNumController.text,
                                                                                                  _lowerNumController, 'text', 70, true),
                                                                                            ],
                                                                                          ),
                                                                                          '주차대수',
                                                                                          Row(
                                                                                            children: [
                                                                                              textInput(_parkingNumController.text,
                                                                                                  _parkingNumController, 'text', 150, true),
                                                                                              uiCommon.styledText(
                                                                                                  '대',
                                                                                                  16,
                                                                                                  0,
                                                                                                  1.6,
                                                                                                  FontWeight.w500,
                                                                                                  IdColors.textDefault,
                                                                                                  TextAlign.left)
                                                                                            ],
                                                                                          ),
                                                                                        ),
                                                                                        subContentsEdit(
                                                                                          '승강기',
                                                                                          Row(
                                                                                            children: [
                                                                                              textInput(_elevatorController.text,
                                                                                                  _elevatorController, 'text', 150, true),
                                                                                              uiCommon.styledText(
                                                                                                  '대',
                                                                                                  16,
                                                                                                  0,
                                                                                                  1.6,
                                                                                                  FontWeight.w500,
                                                                                                  IdColors.textDefault,
                                                                                                  TextAlign.left),
                                                                                            ],
                                                                                          ),
                                                                                          '',
                                                                                          const SizedBox(),
                                                                                        ),
                                                                                        subContentsEdit(
                                                                                          '기타사항',
                                                                                          textInput(_NeBuildingEtcController.text,
                                                                                              _NeBuildingEtcController, 'text', 150, true),
                                                                                          '',
                                                                                          const SizedBox(),
                                                                                        ),
                                                                                      ],
                                                                                    )
                                                                                  : Column(
                                                                                      children: [
                                                                                        subContents('용도', landUsage, '용적률',
                                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(totalFloorRatio) ?? 0)}%'),
                                                                                        subContents(
                                                                                            '건폐율',
                                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(buildingCoverage) ?? 0)}%',
                                                                                            '건축면적',
                                                                                            '$buildingArea ㎡'),
                                                                                        subContents(
                                                                                            '연면적',
                                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(totalFloorArea) ?? 0)}㎡',
                                                                                            '지상 연면적',
                                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(upperFloorArea) ?? 0)}㎡'),
                                                                                        subContents(
                                                                                            '지상/지하',
                                                                                            '${NumberFormat('#,###').format(double.tryParse(upperNum) ?? 0)}/${NumberFormat('#,###').format(double.tryParse(lowerNum) ?? 0)}',
                                                                                            '주차대수',
                                                                                            '${NumberFormat('#,###').format(double.tryParse(parkingNum) ?? 0)}대'),
                                                                                        subContents(
                                                                                            '승강기',
                                                                                            '${NumberFormat('#,###').format(double.tryParse(elevator) ?? 0)}대',
                                                                                            '',
                                                                                            ''),
                                                                                        subContents('기타사항', landEtc, '', ''),
                                                                                      ],
                                                                                    ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                )
                                                              : Column(
                                                                  children: [
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '희망매각가(억원)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_askingController.text, _askingController, 'text',
                                                                                    250, true)
                                                                              ],
                                                                            ),
                                                                            '가격협의',
                                                                            Row(
                                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                                children: List.generate(
                                                                                  negotiateList.length,
                                                                                  (index) => radioWithLable2(() {
                                                                                    negotiateINT = index + 1;
                                                                                    setState(() {});
                                                                                  },
                                                                                      (negotiateINT == index + 1) ? true : false,
                                                                                      IdColors.green2,
                                                                                      negotiateList[index],
                                                                                      IdColors.textDefault,
                                                                                      true),
                                                                                )))
                                                                        : contentsRow(
                                                                            '희망매각가(억원)',
                                                                            FontWeight.w400,
                                                                            '${NumberFormat('#,##0.00').format(double.tryParse(masterAsking) ?? 0)}억원',
                                                                            FontWeight.w600,
                                                                            '가격협의',
                                                                            FontWeight.w400,
                                                                            negotiationType,
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? Column(
                                                                            children: [
                                                                              contentsRowEdit1(
                                                                                '명도',
                                                                                Row(
                                                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                                                  children: List.generate(
                                                                                    dispossessList.length,
                                                                                    (index) => radioWithLable2(() {
                                                                                      dispossessINT = index + 1;
                                                                                      setState(() {});
                                                                                    },
                                                                                        (dispossessINT == index + 1) ? true : false,
                                                                                        IdColors.green2,
                                                                                        dispossessList[index],
                                                                                        IdColors.textDefault,
                                                                                        true),
                                                                                  ),
                                                                                ),
                                                                              ),
                                                                              contentsRowEdit1(
                                                                                '예상명도기간(개월)',
                                                                                Row(
                                                                                  children: [
                                                                                    textInput(_evacuationPeriodController.text,
                                                                                        _evacuationPeriodController, 'number', 250, true),
                                                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                                    Row(
                                                                                      children: [
                                                                                        IdNormalBtn(
                                                                                          onBtnPressed: () {
                                                                                            //
                                                                                            if (evacuationChkBool) {
                                                                                              evacuationChkBool = false;
                                                                                            } else {
                                                                                              evacuationChkBool = true;
                                                                                            }
                                                                                            setState(() {});
                                                                                          },
                                                                                          childWidget: IdImageBox(
                                                                                              imagePath: evacuationChkBool
                                                                                                  ? 'assets/img/icon_checkBox_checked.png'
                                                                                                  : 'assets/img/icon_checkBox_none.png',
                                                                                              imageWidth: 20,
                                                                                              imageHeight: 20,
                                                                                              imageFit: BoxFit.contain),
                                                                                        ),
                                                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                                        uiCommon.styledText('협의', 18, 0, 1, FontWeight.w500,
                                                                                            IdColors.textDefault, TextAlign.left)
                                                                                      ],
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                            ],
                                                                          )
                                                                        : contentsRow(
                                                                            '명도',
                                                                            FontWeight.w400,
                                                                            evacuationType,
                                                                            FontWeight.w600,
                                                                            '예상명도기간(개월)',
                                                                            FontWeight.w400,
                                                                            (evacuationPeriod != '0')
                                                                                ? (evacuationChk == 'N')
                                                                                    ? evacuationPeriod
                                                                                    : '$evacuationPeriod개월 (협의)'
                                                                                : '즉시가능',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '보증금(만원)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_depositeController.text, _depositeController,
                                                                                    'number2', 250, true),
                                                                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                                Row(
                                                                                  children: [
                                                                                    IdNormalBtn(
                                                                                      onBtnPressed: () {
                                                                                        //
                                                                                        if (depositChkBool) {
                                                                                          depositChkBool = false;
                                                                                        } else {
                                                                                          depositChkBool = true;
                                                                                          _depositeController.text = '';
                                                                                        }
                                                                                        setState(() {});
                                                                                      },
                                                                                      childWidget: IdImageBox(
                                                                                          imagePath: depositChkBool
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
                                                                            '월세(만원)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_monthlyController.text, _monthlyController,
                                                                                    'number2', 250, true),
                                                                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                                Row(
                                                                                  children: [
                                                                                    IdNormalBtn(
                                                                                      onBtnPressed: () {
                                                                                        //
                                                                                        if (monthlyChkBool) {
                                                                                          monthlyChkBool = false;
                                                                                        } else {
                                                                                          monthlyChkBool = true;
                                                                                          _monthlyController.text = '';
                                                                                        }
                                                                                        setState(() {});
                                                                                      },
                                                                                      childWidget: IdImageBox(
                                                                                          imagePath: monthlyChkBool
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
                                                                          )
                                                                        : contentsRow(
                                                                            '보증금(만원)',
                                                                            FontWeight.w400,
                                                                            (depositChk == 'N')
                                                                                ? '${NumberFormat('#,###').format(double.tryParse(deposit) ?? 0)}만원'
                                                                                : '${NumberFormat('#,###').format(double.tryParse(deposit) ?? 0)}만원 (확인중)',
                                                                            FontWeight.w600,
                                                                            '월세(만원)',
                                                                            FontWeight.w400,
                                                                            (monthlyChk == 'N')
                                                                                ? '${NumberFormat('#,###').format(double.tryParse(monthly) ?? 0)}만원'
                                                                                : '${NumberFormat('#,###').format(double.tryParse(monthly) ?? 0)}만원 (확인중)',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? contentsRowEdit2(
                                                                            '융자여부',
                                                                            // SizedBox(),
                                                                            dropDown1(
                                                                                _focusDropDown,
                                                                                (loan == '')
                                                                                    ? '선택하세요'
                                                                                    : (loan == 'Y')
                                                                                        ? '있음'
                                                                                        : '없음',
                                                                                _items,
                                                                                changeDropdown),
                                                                            '객실 수(개)',
                                                                            Row(
                                                                              children: [
                                                                                textInput(_rommNumController.text, _rommNumController,
                                                                                    'text', 250, true),
                                                                                uiCommon.styledText('개', 16, 0, 1.6, FontWeight.w500,
                                                                                    IdColors.textDefault, TextAlign.left),
                                                                              ],
                                                                            ),
                                                                          )
                                                                        : contentsRow(
                                                                            '융자여부',
                                                                            FontWeight.w400,
                                                                            (loan == '')
                                                                                ? '-'
                                                                                : (loan == 'Y')
                                                                                    ? '있음'
                                                                                    : '없음',
                                                                            FontWeight.w600,
                                                                            '객실 수(개)',
                                                                            FontWeight.w400,
                                                                            roomNum,
                                                                            FontWeight.w600,
                                                                          ),
                                                                    (editAction)
                                                                        ? Column(
                                                                            children: [
                                                                              contentsRowEdit1(
                                                                                '리모델링',
                                                                                Row(
                                                                                  children: [
                                                                                    Row(
                                                                                      children: [
                                                                                        IdRadio(
                                                                                            onBtnPressed: () {
                                                                                              remodelInt = 1;
                                                                                              setState(() {});
                                                                                            },
                                                                                            checkBool: (remodelInt == 1) ? true : false,
                                                                                            radioColor: IdColors.green2,
                                                                                            enabled: true),
                                                                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                                                        textInput(
                                                                                            _remodellingController.text,
                                                                                            _remodellingController,
                                                                                            'number',
                                                                                            250,
                                                                                            (remodelInt == 1) ? true : false),
                                                                                      ],
                                                                                    ),
                                                                                    IdSpace(spaceWidth: 32, spaceHeight: 0),
                                                                                    radioWithLable2(() {
                                                                                      remodelInt = 2;
                                                                                      _remodellingController.text = '';
                                                                                      setState(() {});
                                                                                    }, (remodelInt == 2) ? true : false, IdColors.green2,
                                                                                        '확인중', IdColors.textDefault, true),
                                                                                    radioWithLable2(() {
                                                                                      remodelInt = 3;
                                                                                      _remodellingController.text = '';
                                                                                      setState(() {});
                                                                                    }, (remodelInt == 3) ? true : false, IdColors.green2,
                                                                                        '없음', IdColors.textDefault, true),
                                                                                  ],
                                                                                ),
                                                                              ),
                                                                              contentsRowEdit1(
                                                                                '인근 지하철/거리',
                                                                                Row(
                                                                                  children: [
                                                                                    textInput(_stationController.text, _stationController,
                                                                                        'text', 200, false),
                                                                                    uiCommon.styledText(' / ', 16, 0, 1.6, FontWeight.w600,
                                                                                        IdColors.textDefault, TextAlign.center),
                                                                                    textInput(_stationDistanceController.text,
                                                                                        _stationDistanceController, 'text', 200, false),
                                                                                  ],
                                                                                ),
                                                                              )
                                                                            ],
                                                                          )
                                                                        : contentsRow(
                                                                            '리모델링',
                                                                            FontWeight.w400,
                                                                            (remodelInt == 2)
                                                                                ? '확인중'
                                                                                : (remodelInt == 3)
                                                                                    ? '없음'
                                                                                    : _remodellingController.text,
                                                                            FontWeight.w600,
                                                                            '인근 지하철/거리',
                                                                            FontWeight.w400,
                                                                            // negosiatChk,
                                                                            '$stationName/$stationDistance',
                                                                            FontWeight.w600,
                                                                          ),
                                                                    //렌트롤 리스트
                                                                    rentRoll(rentRollList),
                                                                  ],
                                                                ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: (status1 == '2') ? true : false,
                                            child: Positioned(
                                              top: 0,
                                              left: 0,
                                              child: IdImageBox(
                                                  imagePath: 'assets/img/icon_shild_ribon_big.png',
                                                  imageWidth: 92,
                                                  imageHeight: 92,
                                                  imageFit: BoxFit.cover),
                                            ),
                                          ),
                                          //TODO PJT 라벨 부분
                                          Positioned(
                                            top: 63.5,
                                            left: 60,
                                            child: Row(
                                              children: [
                                                IdPjtDropdown(pjtDataList: pjtList, pjtDataColorList: pjtColorList, pageName: 'MyDeal'),
                                              ],
                                            ),
                                          ),
                                          Visibility(
                                            visible: dealStatusSelectVisible,
                                            child: Positioned(
                                              left: 60,
                                              top: 154,
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                children: [
                                                  uiCommon.styledText(
                                                      pageTitle, 32, 0, 1, FontWeight.w700, IdColors.invisiable, TextAlign.start),
                                                  const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                  Container(
                                                    width: 112,
                                                    height: 118,
                                                    padding: EdgeInsets.all(8),
                                                    decoration: BoxDecoration(
                                                        color: IdColors.white,
                                                        borderRadius: BorderRadius.circular(8),
                                                        boxShadow: const [
                                                          BoxShadow(
                                                              offset: Offset(0, 0),
                                                              blurRadius: 12,
                                                              spreadRadius: 0,
                                                              color: IdColors.black8Per),
                                                        ]),
                                                    child: Column(
                                                      children: [
                                                        radioWithLable1(() {
                                                          dealStatus = '1';
                                                          status2 = '거래중';
                                                          setState(() {});
                                                        }, (dealStatus == '1') ? true : false, IdColors.green2, '거래중', IdColors.textDefault,
                                                            true),
                                                        radioWithLable1(() {
                                                          dealStatus = '0';
                                                          status2 = '보류';
                                                          setState(() {});
                                                        }, (dealStatus == '0') ? true : false, IdColors.green2, '보류', IdColors.textDefault,
                                                            true),
                                                        radioWithLable1(() {
                                                          dealStatus = '2';
                                                          status2 = '거래완료';
                                                          setState(() {});
                                                        }, (dealStatus == '2') ? true : false, IdColors.green2, '거래완료',
                                                            IdColors.textDefault, true),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                      // 목록/수정
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                            ),
                                          ),
                                          Row(
                                            children: [
                                              IdNormalBtn(
                                                onBtnPressed: () {
                                                  uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
                                                },
                                                childWidget: Container(
                                                  width: 74,
                                                  height: 44,
                                                  decoration: ShapeDecoration(
                                                    color: IdColors.white,
                                                    shape: RoundedRectangleBorder(
                                                      side: const BorderSide(
                                                        width: 1,
                                                        color: IdColors.textDisabled,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                  ),
                                                  child: Center(
                                                    child: uiCommon.styledText(
                                                        '목록', 15, 0, 1, FontWeight.w600, IdColors.textTertiary, TextAlign.center),
                                                  ),
                                                ),
                                              ),
                                              const IdSpace(spaceWidth: 10, spaceHeight: 0),
                                              (editAction)
                                                  ? IdNormalBtn(
                                                      onBtnPressed: () async {
                                                        dealStatusSelectVisible = false;
                                                        if (realImgList[0] != '' && imgDescControllerList[0].text == '') {
                                                          activeToast('사진의 설명이 없습니다.');
                                                        } else {
                                                          if (realImgList[1] != '' && imgDescControllerList[1].text == '') {
                                                            activeToast('사진의 설명이 없습니다.');
                                                          } else {
                                                            if (realImgList[2] != '' && imgDescControllerList[2].text == '') {
                                                              activeToast('사진의 설명이 없습니다.');
                                                            } else {
                                                              if (realImgList[3] != '' && imgDescControllerList[3].text == '') {
                                                                activeToast('사진의 설명이 없습니다.');
                                                              } else {
                                                                if (realImgList[4] != '' && imgDescControllerList[4].text == '') {
                                                                  activeToast('사진의 설명이 없습니다.');
                                                                } else {
                                                                  if (realImgList[5] != '' && imgDescControllerList[5].text == '') {
                                                                    activeToast('사진의 설명이 없습니다.');
                                                                  } else {
                                                                    if (realImgList[6] != '' && imgDescControllerList[6].text == '') {
                                                                      activeToast('사진의 설명이 없습니다.');
                                                                    } else {
                                                                      if (realImgList[7] != '' && imgDescControllerList[7].text == '') {
                                                                        activeToast('사진의 설명이 없습니다.');
                                                                      } else {
                                                                        if (realImgList[8] != '' && imgDescControllerList[8].text == '') {
                                                                          activeToast('사진의 설명이 없습니다.');
                                                                        } else {
                                                                          if (realImgList[9] != '' && imgDescControllerList[9].text == '') {
                                                                            activeToast('사진의 설명이 없습니다.');
                                                                          } else {
                                                                            if (await updateDeal()) {
                                                                              editAction = false;

                                                                              setState(() {});
                                                                              fetchData();
                                                                            } else {
                                                                              GV.d('실패');
                                                                            }
                                                                          }
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
                                                      childWidget: Container(
                                                        width: 74,
                                                        height: 44,
                                                        decoration: ShapeDecoration(
                                                          color: IdColors.green2,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: uiCommon.styledText(
                                                              '저장', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
                                                        ),
                                                      ),
                                                    )
                                                  : IdNormalBtn(
                                                      onBtnPressed: () {
                                                        editAction = true;
                                                        setState(() {});
                                                      },
                                                      childWidget: Container(
                                                        width: 74,
                                                        height: 44,
                                                        decoration: ShapeDecoration(
                                                          color: IdColors.textDefault,
                                                          shape: RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.circular(8),
                                                          ),
                                                        ),
                                                        child: Center(
                                                          child: uiCommon.styledText(
                                                              '수정', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
                                                        ),
                                                      ),
                                                    ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                      //메모 리스트
                                      SizedBox(
                                        width: double.infinity,
                                        child: boardGrid123,
                                      ),
                                      const IdSpace(spaceWidth: 0, spaceHeight: 24),
                                      Row(
                                        children: [
                                          const Expanded(
                                            child: SizedBox(
                                              width: double.infinity,
                                            ),
                                          ),
                                          IdNormalBtn(
                                            onBtnPressed: () {
                                              memoPopupVisible = true;
                                              setState(() {});
                                            },
                                            childWidget: Container(
                                              width: 91,
                                              height: 44,
                                              decoration: BoxDecoration(
                                                color: IdColors.green2,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: uiCommon.styledText(
                                                    '새 메모', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const IdSpace(spaceWidth: 0, spaceHeight: 24),
                                      //페이지
                                      Container(
                                        width: double.infinity,
                                        padding: const EdgeInsets.symmetric(vertical: 40),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: [
                                            pages,
                                          ],
                                        ),
                                      ),
                                      const IdSpace(spaceWidth: 0, spaceHeight: 200)
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      //푸터
                      idCommonFooter(),
                    ],
                  ),
                ),
                idCommonHeader(),
                idHeadToastWidget(),

                Visibility(
                  visible: mapPopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: Container(
                      color: IdColors.black8Per,
                      child: Center(
                          child: MapPopup(
                        onlyCloseFunction: () {
                          mapPopupVisible = false;
                          setState(() {});
                        },
                        latitude: latitude,
                        longitude: longitude,
                      )),
                    ),
                  ),
                ),

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
                              // lotInfoList[lotListNum][0] = kakaoAddress.jibunAddress.split(' ')[2] + kakaoAddress.jibunAddress.split(' ')[3];

                              if (lotListNum == 0) {
                                jibunAddress = kakaoAddress.jibunAddress;
                                pnu = kakaoAddress.postCode;
                              }
                              fetchData2();
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
                  visible: memoPopupVisible,
                  child: Positioned(
                    child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: const Color.fromRGBO(0, 0, 0, 0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              MemoPopup(
                                onlyCloseFunction: () {
                                  memoPopupVisible = false;
                                  _memoController.text = '';
                                  _fileController.text = '';
                                  setState(() {});
                                },
                                searchFunction: () {
                                  memoUploadFile();
                                },
                                imgSize: imgSize,
                                closeAndUpdateFunction: (imgSize > 200)
                                    ? () {}
                                    : () async {
                                        //TODO 나중에 메모 Insert 하는 기능 추가
                                        if (await setMemo()) {
                                          memoPopupVisible = false;
                                          _memoController.text = '';
                                          _fileController.text = '';
                                          setState(() {});
                                          fetchData();
                                        } else {
                                          GV.d('실패');
                                        }
                                      },
                                memoController: _memoController,
                                fileController: _fileController,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                //lotList 수정 팝업
                Visibility(
                  visible: lotAreaPopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: lotAreaPopup(clickLotRowNum),
                  ),
                ),
                Visibility(
                  visible: lotAreaPyPopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: lotAreaPyPopup(clickLotRowNum),
                  ),
                ),
                Visibility(
                  visible: areaPurposePopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: areaPurposePopup(clickLotRowNum),
                  ),
                ),
                Visibility(
                  visible: sellPricePopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: sellPricePopup(clickLotRowNum),
                  ),
                ),
                Visibility(
                  visible: officialPricePopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: officialPricePopup(clickLotRowNum),
                  ),
                ),
                Visibility(
                  visible: totalPricePopupVisible,
                  child: Positioned(
                    top: 0,
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: totalPricePopup(clickLotRowNum),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
