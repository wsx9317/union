import 'dart:typed_data';
import 'package:intl/intl.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:union_admin/api/id_api.dart';
import 'package:union_admin/common/globalvar.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/common/utils.dart';
import 'package:union_admin/constants/constants.dart';
import 'package:union_admin/id_widget/IdColor.dart';
import 'package:union_admin/id_widget/IdGrid.dart';
import 'package:union_admin/id_widget/IdImageBox1.dart';
import 'package:union_admin/id_widget/IdImageBox2.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';
import 'package:union_admin/id_widget/IdPagination.dart';
import 'package:union_admin/id_widget/IdSpace.dart';
import 'package:union_admin/modelVO/dealDetailBuildingItem.dart';
import 'package:union_admin/modelVO/dealDetailLandItem.dart';
import 'package:union_admin/modelVO/dealStatusResponse.dart';
import 'package:union_admin/modelVO/locationResponse.dart';
import 'package:union_admin/modelVO/memoResponse.dart';
import 'package:union_admin/modelVO/progressResponse.dart';
import 'package:union_admin/modelVO/search_option_item.dart';
import 'package:union_admin/popup/FilePopup.dart';
import 'package:union_admin/popup/MemoPopup.dart';
import 'package:union_admin/popup/agreePopup.dart';
import 'package:union_admin/popup/alertPopup.dart';
import 'package:union_admin/popup/editLabelPopup.dart';
import 'package:union_admin/popup/mapPopup.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:file_picker/file_picker.dart';
import 'package:union_admin/popup/statusChangePopup.dart';
import 'dart:html' as html;

class _DealMemoList {
  MemoResponse? data;
}

class _DealStatusList {
  DealStatusResponse? data;
}

class DealDetail extends StatefulWidget {
  const DealDetail({super.key});

  @override
  State<DealDetail> createState() => _DealDetailState();
}

class _DealDetailState extends State<DealDetail> {
  String dealNoParam = GV.pStrg.getXXX(Param_dealNoString);
  String? typeParam = GV.pStrg.getXXX(Param_typeString);
  String? dealDomiNoParam = GV.pStrg.getXXX(Param_dealDomiNoString);
  //TODO 임시로 넣기
  String userNo = GV.pStrg.getXXX('uId').isEmpty ? '1' : GV.pStrg.getXXX('uId');
  List<List<String>> _dealMemoSvcDS = [];
  List<_DealMemoList> _dealMemoDs = [];
  List<List<String>> _dealStatusSvcDS = [];
  List<_DealStatusList> _dealStatusDs = [];
  String type = '';
  String category = '';
  String latitude = '';
  String longitude = '';
  List rentRollList = [];
  List labelLsit = [];
  List imgPathList = ['', '', '', '', '', '', '', '', '', '', '', '', ''];
  List imgDescList = ['', '', '', '', '', '', '', '', '', '', '', '', ''];
  List lotInfoList = [];

  List tabList = ['메모관리', '진행관리', '파일관리'];
  String tabBtnTitle = '';

  bool mapPopupVisible = false;
  bool agressPopupVisible = false;

  String domiYn = '';

  bool labelMore = false;

  String detailPage = GV.pStrg.getXXX(Param_beforePage); // dealDomi, deal

  int memoCurrentRowsCnt = 0;
  int memoTotalRowsCnt = 0;
  int memoTotalPage = 0;
  int memoActuralPage = 1;

  int statusCurrentRowsCnt = 0;
  int statusTotalRowsCnt = 0;
  int statusTotalPage = 0;
  int statusActuralPage = 1;

  String title = '';
  String dealStatus = '';
  String register = '';
  String address = '';
  String buildingName = '';
  String lotArea = '';
  String totalFloorArea = '';
  String upperFloorArea = '';
  String areaPurpose = '';
  String buildingArea = '';
  String buildingCoverage = '';
  String totalFloorRatio = '';
  String mainPurpose = '';
  String mainStruct = '';
  String ccd = '';
  String upperNum = '';
  String lowerNum = '';
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
  String landEtc = '';
  String additionalEtc = '';
  String additional = '';

  double webWidth = double.tryParse(GV.pStrg.getXXX(key_page_with)) ?? 1200;

  //진행사항
  String changeDateTime = '';
  String statusCreator = '';
  String statusComent = '';

  String fileType = '';

  bool alertPopupVisible = false; //독점보호 팝업 보여주는거
  bool memoPopupVisible = false; //메모 팝업 보여주는거
  bool filePopupVisible = false; //메모 팝업 보여주는거
  Uint8List memoFile = Uint8List(0); //메모 파일첨부
  Uint8List fileFile = Uint8List(0); //메모 파일첨부
  double imgSize = 0;
  Image? uploadImg1;

  bool editLabelPopupVisible = false;
  bool statusChangePopupVisible = false;

  List cdList = [];
  List locationCdList = [];
  String progressStr = '';

  List<String> dealDomiNoList = [];

  TextEditingController _memoController = TextEditingController();
  TextEditingController _fileController = TextEditingController();
  TextEditingController _commentController = TextEditingController();
  TextEditingController _fileController2 = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dealMemoDs.add(_DealMemoList());
    _dealStatusDs.add(_DealStatusList());
    dealDomiNoList.add(dealNoParam);
    tabBtnTitle = tabList[0];
    html.window.onResize.listen((event) {
      setState(() {
        webWidth = html.window.innerWidth!.toDouble();
      });
    });
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    labelLsit = [];

    DealDetailBuildingItem? ret1_1;
    DealDetailLandItem? ret1_2;
    dynamic ret0 = await IdApi.getDealDetail2(dealNoParam);
    if (ret0 == null) return;
    dealDomiNoList.clear();

    try {
      if (GV.pStrg.getXXX(Param_typeString) == 'B') {
        ret1_1 = ret0 as DealDetailBuildingItem;
      } else {
        ret1_2 = ret0 as DealDetailLandItem;
      }
    } catch (e) {}

    ret1_1?.dominant != null ? dealDomiNoList.add(ret1_1!.dominant!.dealDomiNo!) : 1 == 1;
    ret1_2?.dominant != null ? dealDomiNoList.add(ret1_2!.dominant!.dealDomiNo!) : 1 == 1;

    if (GV.pStrg.getXXX(Param_typeString) == 'B') {
      typeParam = ret1_1!.dealMaster!.type;
    } else {
      typeParam = ret1_2!.dealMaster!.type;
    }

    if (GV.pStrg.getXXX(Param_typeString) == 'B') {
      //건물
      for (var i = 0; i < ret1_1!.labelList!.length; i++) {
        labelLsit.add([ret1_1.labelList![i].label.toString(), int.tryParse(ret1_1.labelList![i].labelColor.toString()) ?? 1]);
      }
      type = ret1_1.dealMaster!.type!;
      dealStatus = ret1_1.dealMaster!.dealStatus!;
      category = ret1_1.dealMaster!.category!;
      latitude = ret1_1.dealMaster!.latitude!;
      longitude = ret1_1.dealMaster!.longitude!;
      if (detailPage == 'deal') {
        if (ret1_1.dealMaster!.gubun == '2') {
          domiYn = "Y";
        } else {
          domiYn = "N";
        }
      } else {
        domiYn = "N";
      }
      if (ret1_1.dealMaster!.register == '1') {
        register = '중개사';
      } else if (ret1_1.dealMaster!.register == '2') {
        register = '소유주';
      } else if (ret1_1.dealMaster!.register == '3') {
        register = '시행사';
      } else if (ret1_1.dealMaster!.register == '4') {
        register = '기타 (${ret1_1.dealMaster!.registerEtc})';
      }
      address = '${ret1_1.dealMaster!.address!} ${ret1_1.dealMaster!.addressDtl!}';
      buildingName = ret1_1.building!.buildingName!;
      lotArea = NumberFormat('#,##0.00').format(double.tryParse(ret1_1.building!.lotArea!) ?? 0);
      totalFloorArea = NumberFormat('#,##0.00').format(double.tryParse(ret1_1.building!.totalFloorArea!) ?? 0);
      areaPurpose = ret1_1.building!.areaPurpose!;
      totalFloorRatio = ret1_1.building!.totalFloorRatio!;
      mainPurpose = ret1_1.building!.mainPurpose!;
      mainStruct = ret1_1.building!.mainStruct!;
      ccd = ret1_1.building!.ccd!;
      upperNum = NumberFormat('#,###').format(double.tryParse(ret1_1.building!.upperNum!) ?? 0);
      lowerNum = NumberFormat('#,###').format(double.tryParse(ret1_1.building!.lowerNum!) ?? 0);
      elevator = NumberFormat('#,###').format(double.tryParse(ret1_1.building!.elevator!) ?? 0);
      parkingNum = NumberFormat('#,###').format(double.tryParse(ret1_1.building!.parkingNum!) ?? 0);
      officialLandPrice = NumberFormat('#,##0.00').format((double.tryParse(ret1_1.building!.officialLandPrice!) ?? 0) / 10000);
      totalLandPrice = NumberFormat('#,##0.00').format((double.tryParse(ret1_1.building!.totalLandPrice!) ?? 0) / 10000);
      asking = NumberFormat('#,##0.00').format((double.tryParse(ret1_1.dealMaster!.asking!) ?? 0) / 100000000);
      if (ret1_1.dealMaster!.negotiationType == '1') {
        negotiationType = '가능';
      } else if (ret1_1.dealMaster!.negotiationType == '2') {
        negotiationType = '불가능';
      } else {
        negotiationType = '협의';
      }
      if (ret1_1.dealMaster!.evacuationType == '1') {
        evacuationType = '전층책임명도';
      } else if (ret1_1.dealMaster!.evacuationType == '1') {
        evacuationType = '일부책임명도';
      } else if (ret1_1.dealMaster!.evacuationType == '3') {
        evacuationType = '불가능';
      } else if (ret1_1.dealMaster!.evacuationType == '4') {
        evacuationType = '협의';
      } else {
        evacuationType = '-';
      }

      evacuationPeriod = ret1_1.dealMaster!.evacuationPeriod!;
      if (ret1_1.dealMaster!.evacuationChk == 'N') {
        evacuationChk = '(확인중)';
      } else {
        evacuationChk = '(협의)';
      }

      deposit = NumberFormat('#,##0.00').format((double.tryParse(ret1_1.building!.deposit!) ?? 0) / 10000);
      if (ret1_1.building!.depositChk == 'N') {
        depositChk = '(확인중)';
      } else {
        depositChk = '(협의)';
      }
      monthly = NumberFormat('#,##0.00').format((double.tryParse(ret1_1.building!.monthly!) ?? 0) / 10000);
      if (ret1_1.building!.monthlyChk == 'N') {
        monthlyChk = '(확인중)';
      } else {
        monthlyChk = '(협의)';
      }
      if (ret1_1.building!.loan == 'N') {
        loan = '없음';
      } else {
        loan = '있음';
      }
      roomNum = NumberFormat('#,###').format(double.tryParse(ret1_1.building!.roomNum!) ?? 0);
      if (ret1_1.building!.reModel == '-1') {
        reModel = '확인중';
      } else if (ret1_1.building!.reModel == '0') {
        reModel = '없음';
      } else {
        reModel = ret1_1.building!.reModel!;
      }
      stationName = ret1_1.dealMaster!.stationName!;
      stationDistance = ret1_1.dealMaster!.stationDistance!;
      title = ret1_1.dealMaster!.title!;
      additional = ret1_1.dealMaster!.additional!;
      if (ret1_1.dealMaster!.additionalEtc != null) {
        additionalEtc = ret1_1.dealMaster!.additionalEtc!;
      } else {
        additionalEtc = '-';
      }

      for (var i = 0; i < ret1_1.rentrollList!.length; i++) {
        rentRollList.add([
          ret1_1.rentrollList![i].floor,
          ret1_1.rentrollList![i].sectors,
          ret1_1.rentrollList![i].area,
          NumberFormat('#,##0.00').format((double.tryParse(ret1_1.rentrollList![i].deposit!) ?? 0) / 10000),
          NumberFormat('#,##0.00').format((double.tryParse(ret1_1.rentrollList![i].rent!) ?? 0) / 10000),
          ret1_1.rentrollList![i].etc,
        ]);
      }
      for (var i = 0; i < ret1_1.fileList!.length; i++) {
        if (ret1_1.fileList![i].fileOrder != null) {
          imgPathList[(int.tryParse(ret1_1.fileList![i].fileOrder!) ?? 1) - 1] = ret1_1.fileList![i].s3FileUrl!;
          imgDescList[(int.tryParse(ret1_1.fileList![i].fileOrder!) ?? 1) - 1] = ret1_1.fileList![i].fileDoc!;
        }
      }
    } else {
      //신축부지
      type = ret1_2!.dealMaster!.type!;
      dealStatus = ret1_2.dealMaster!.dealStatus!;
      category = ret1_2.dealMaster!.category!;
      latitude = ret1_2.dealMaster!.latitude!;
      longitude = ret1_2.dealMaster!.longitude!;
      if (detailPage == 'deal') {
        if (ret1_2.dealMaster!.gubun == '2') {
          domiYn = "Y";
        } else {
          domiYn = "N";
        }
      } else {
        domiYn = "N";
      }
      register = ret1_2.dealMaster!.register!;
      address = '${ret1_2.dealMaster!.address!} ${ret1_2.dealMaster!.addressDtl!}';
      asking = NumberFormat('#,##0.00').format((double.tryParse(ret1_2.dealMaster!.asking!) ?? 0) / 100000000);
      if (ret1_2.dealMaster!.negotiationType == '1') {
        negotiationType = '가능';
      } else if (ret1_2.dealMaster!.negotiationType == '2') {
        negotiationType = '불가능';
      } else {
        negotiationType = '협의';
      }
      if (ret1_2.dealMaster!.assetStatus == '0' || ret1_2.dealMaster!.assetStatus == null) {
        assetStatus = '-';
      } else if (ret1_2.dealMaster!.assetStatus == '1') {
        assetStatus = '명도예정/명도중';
      } else if (ret1_2.dealMaster!.assetStatus == '2') {
        assetStatus = '공실';
      } else if (ret1_2.dealMaster!.assetStatus == '3') {
        assetStatus = '나대지';
      } else if (ret1_2.dealMaster!.assetStatus == '4') {
        assetStatus = '인허가/착공';
      }
      evacuationPeriod = ret1_2.dealMaster!.evacuationPeriod!;
      if (ret1_2.dealMaster!.evacuationChk == 'N') {
        evacuationChk = '(확인중)';
      } else {
        evacuationChk = '(협의)';
      }
      if (ret1_2.land!.owner == null || ret1_2.land!.owner == '0') {
        owner = '-';
      } else if (ret1_2.land!.owner == '1') {
        owner = '개인/법인';
      } else if (ret1_2.land!.owner == '2') {
        owner = '시행사';
      } else if (ret1_2.land!.owner == '3') {
        owner = '브릿지/PF';
      }
      stationName = ret1_2.dealMaster!.stationName!;
      stationDistance = ret1_2.dealMaster!.stationDistance!;
      areaPurpose = ret1_2.land!.landUsage!;
      totalFloorRatio = NumberFormat('##.00').format(double.tryParse(ret1_2.land!.totalFloorRatio!) ?? 0);
      buildingCoverage = NumberFormat('##.00').format(double.tryParse(ret1_2.land!.buildingCoverage!) ?? 0);
      buildingArea = NumberFormat('#,##0.00').format(double.tryParse(ret1_2.land!.buildingArea!) ?? 0);
      totalFloorArea = NumberFormat('#,##0.00').format(double.tryParse(ret1_2.land!.totalFloorArea!) ?? 0);
      upperFloorArea = NumberFormat('#,##0.00').format(double.tryParse(ret1_2.land!.upperFloorArea!) ?? 0);
      upperNum = NumberFormat('#,###').format(double.tryParse(ret1_2.land!.upperNum!) ?? 0);
      lowerNum = NumberFormat('#,##').format(double.tryParse(ret1_2.land!.lowerNum!) ?? 0);
      parkingNum = NumberFormat('#,###').format(double.tryParse(ret1_2.land!.parkingNum!) ?? 0);
      elevator = NumberFormat('#,###').format(double.tryParse(ret1_2.land!.elevator!) ?? 0);
      landEtc = ret1_2.land!.etc!;
      title = ret1_2.dealMaster!.title!;
      additional = ret1_2.dealMaster!.additional!;
      if (ret1_2.dealMaster!.additionalEtc != null) {
        additionalEtc = ret1_2.dealMaster!.additionalEtc!;
      } else {
        additionalEtc = '-';
      }

      for (var i = 0; i < ret1_2.fileList!.length; i++) {
        imgPathList[(int.tryParse(ret1_2.fileList![i].fileOrder!) ?? 1) - 1] = ret1_2.fileList![i].s3FileUrl!;
        imgDescList[(int.tryParse(ret1_2.fileList![i].fileOrder!) ?? 1) - 1] = ret1_2.fileList![i].fileDoc!;
      }

      for (var i = 0; i < ret1_2.lotList!.length; i++) {
        lotInfoList.add([
          ret1_2.lotList![i].address,
          double.tryParse(ret1_2.lotList![i].lotArea!) ?? 0,
          double.tryParse(ret1_2.lotList![i].lotAreaPy!) ?? 0,
          ret1_2.lotList![i].areaPurpose!,
          (double.tryParse(ret1_2.lotList![i].officialLandPrice!) ?? 0) / 10000,
          (double.tryParse(ret1_2.lotList![i].totalLandPrice!) ?? 0) / 10000,
          (double.tryParse(ret1_2.lotList![i].asking!) ?? 0) / 100000000,
        ]);
      }
    }
    //메모리스트
    final MemoResponse? ret2 =
        await IdApi.getMemoList(SearchOptionItme(page: memoActuralPage - 1, rowSize: 10, dealNo: dealNoParam, fileType: fileType));
    if (ret2 != null) {
      _dealMemoDs[0].data = ret2;
      Map<String, dynamic> commonInfo = _dealMemoDs[0].data!.commonInfo!;
      memoTotalRowsCnt = commonInfo['totalCount'];
      if (_dealMemoDs[0].data!.list!.isNotEmpty) {
        if (memoTotalRowsCnt % 10 == 0) {
          memoTotalPage = int.tryParse((memoTotalRowsCnt / 10).toString()) ?? 1;
        } else {
          memoTotalPage = (int.tryParse((memoTotalRowsCnt / 10).toString().split('.')[0]) ?? 1) + 1;
        }
      }
    } else {
      _dealMemoDs[0].data = MemoResponse(list: [], commonInfo: {});
    }
    //진행사항 리스트
    final DealStatusResponse? ret3 =
        await IdApi.getStatusHistory(SearchOptionItme(page: statusActuralPage - 1, rowSize: 10, dealNo: dealNoParam));
    if (ret3 != null) {
      _dealStatusDs[0].data = ret3;
      Map<String, dynamic> commonInfo = _dealStatusDs[0].data!.commonInfo!;
      statusTotalRowsCnt = commonInfo['totalCount'];
      int lastInt = 0;
      if (_dealStatusDs[0].data!.list!.length > 0) {
        lastInt = _dealStatusDs[0].data!.list!.length - 1;
        changeDateTime = _dealStatusDs[0].data!.list![lastInt].createDate!;
        statusCreator = _dealStatusDs[0].data!.list![lastInt].creator!;
        statusComent = _dealStatusDs[0].data!.list![lastInt].etc!;
        if (_dealStatusDs[0].data!.list![lastInt].title != null) {
          progressStr = _dealStatusDs[0].data!.list![lastInt].title!;
        } else {
          progressStr = '';
        }
      } else {
        lastInt = 0;
        changeDateTime = '';
        statusCreator = '';
        statusComent = '';
      }

      if (_dealStatusDs[0].data!.list!.isNotEmpty) {
        if (statusTotalRowsCnt % 10 == 0) {
          statusTotalPage = int.tryParse((statusTotalRowsCnt / 10).toString()) ?? 1;
        } else {
          statusTotalPage = (int.tryParse((statusTotalRowsCnt / 10).toString().split('.')[0]) ?? 1) + 1;
        }
      }
    } else {
      _dealStatusDs[0].data = DealStatusResponse(list: [], commonInfo: {});
    }

    //진행사항 코드
    cdList = [];
    final ProgressResponse? ret4 = await IdApi.getProgressCd();

    if (ret4 != null) {
      for (var i = 0; i < ret4.progress!.length; i++) {
        cdList.add([ret4.progress![i].cd, ret4.progress![i].cdName]);
      }
    }

    locationCdList = [];
    final LocationResponse? ret5 = await IdApi.getAdditionCd();

    if (ret5 != null) {
      for (var i = 0; i < ret5.location!.length; i++) {
        locationCdList.add([ret5.location![i].cd, ret5.location![i].cdName]);
      }
    }

    setState(() {});
  }

  List<List<String>> makeRows1() {
    List<List<String>> results = [];
    memoCurrentRowsCnt = 0;
    if (fileType != '') {
      for (var i = 0; i < _dealMemoDs[0].data!.list!.length; i++) {
        List<String> row1 = [];
        var item1 = _dealMemoDs[0].data!.list![i];
        row1.add((i + 1).toString());
        if (item1.fileName != null) {
          row1.add(item1.fileName!);
        } else {
          row1.add('');
        }
        row1.add(item1.creator!);
        row1.add(item1.createDate!);
        row1.add(item1.memo!);
        results.add(row1);
      }
    } else {
      for (var i = 0; i < _dealMemoDs[0].data!.list!.length; i++) {
        List<String> row1 = [];
        var item1 = _dealMemoDs[0].data!.list![i];
        row1.add((i + 1).toString());
        row1.add(item1.creator!);
        row1.add(item1.createDate!);
        row1.add(item1.memo!);
        results.add(row1);
      }
    }
    memoCurrentRowsCnt = results.length;
    setState(() {});
    return results;
  }

  List<List<String>> makeRows2() {
    List<List<String>> results = [];
    statusCurrentRowsCnt = 0;
    for (var i = 0; i < _dealStatusDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _dealStatusDs[0].data!.list![i];
      row1.add((i + 1).toString());
      if (item1.title != null) {
        row1.add(item1.title!);
      } else {
        row1.add('-');
      }
      row1.add(item1.creator!);
      row1.add(item1.createDate!);
      row1.add(item1.etc!);
      results.add(row1);
    }
    statusCurrentRowsCnt = results.length;
    setState(() {});
    return results;
  }

  Future<bool> setMemo() async {
    try {
      final result = await IdApi.setMemo(dealNoParam, userNo, _memoController.text, memoFile, _fileController.text);
      if (result == null) return false;
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> setMemo2() async {
    try {
      final result = await IdApi.setMemo(dealNoParam, userNo, _commentController.text, memoFile, _fileController2.text);
      if (result == null) return false;
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> setDomi() async {
    try {
      final result = await IdApi.setDomi(dealDomiNoList, userNo);
      if (result == null) return false;
    } catch (e) {
      print(e);
    }
    return true;
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
      _fileController2.text = fileName;
      imgSize = ((double.tryParse(fileSize.toString()) ?? 1) / 1000).roundToDouble();
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

  Color labelColor(int num) {
    Color result = IdColors.black;
    if (num == 1) {
      result = IdColors.dealLabel01;
    } else if (num == 2) {
      result = IdColors.dealLabel02;
    } else if (num == 3) {
      result = IdColors.dealLabel03;
    } else if (num == 4) {
      result = IdColors.dealLabel04;
    } else if (num == 5) {
      result = IdColors.dealLabel05;
    } else if (num == 6) {
      result = IdColors.dealLabel06;
    } else if (num == 7) {
      result = IdColors.dealLabel07;
    } else if (num == 8) {
      result = IdColors.dealLabel08;
    } else if (num == 9) {
      result = IdColors.dealLabel09;
    } else if (num == 10) {
      result = IdColors.dealLabel10;
    } else if (num == 11) {
      result = IdColors.dealLabel11;
    } else if (num == 12) {
      result = IdColors.dealLabel12;
    }
    return result;
  }

  Color labelBgColor(int num) {
    Color result = IdColors.black;
    if (num == 1) {
      result = IdColors.dealLabelBg01;
    } else if (num == 2) {
      result = IdColors.dealLabelBg02;
    } else if (num == 3) {
      result = IdColors.dealLabelBg03;
    } else if (num == 4) {
      result = IdColors.dealLabelBg04;
    } else if (num == 5) {
      result = IdColors.dealLabelBg05;
    } else if (num == 6) {
      result = IdColors.dealLabelBg06;
    } else if (num == 7) {
      result = IdColors.dealLabelBg07;
    } else if (num == 8) {
      result = IdColors.dealLabelBg08;
    } else if (num == 9) {
      result = IdColors.dealLabelBg09;
    } else if (num == 10) {
      result = IdColors.dealLabelBg10;
    } else if (num == 11) {
      result = IdColors.dealLabelBg11;
    } else if (num == 12) {
      result = IdColors.dealLabelBg12;
    }
    return result;
  }

  Widget pjtLabel(int num) {
    return Container(
      width: 94,
      height: 26,
      decoration: BoxDecoration(
          color: labelBgColor(labelLsit[num][1]),
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            width: 1,
            color: labelColor(labelLsit[num][1]),
          )),
      child: Center(
        child: uiCommon.styledText(labelLsit[num][0], 14, 0, 1, FontWeight.w700, labelColor(labelLsit[num][1]), TextAlign.center),
      ),
    );
  }

  Widget iconWithText(String imgPath, String title) {
    return Row(
      children: [
        IdImageBox(imagePath: imgPath, imageHeight: 24, imageWidth: 24, imageFit: BoxFit.cover),
        const IdSpace(spaceWidth: 10, spaceHeight: 0),
        uiCommon.styledText(title, 18, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left)
      ],
    );
  }

  Widget contentTitle(String title, Widget childWidget) {
    return Container(
      width: double.infinity,
      height: 70,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: IdColors.black))),
      child: Row(
        children: [
          Expanded(child: uiCommon.styledText(title, 20, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.left)),
          SizedBox(
            width: 97,
            height: 38,
            child: childWidget,
          ),
        ],
      ),
    );
  }

  Widget content(String leftTitle, String leftContent, String rightTitle, String rightContent) {
    return Container(
      width: double.infinity,
      height: 58,
      padding: const EdgeInsets.symmetric(vertical: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: uiCommon.styledText(leftTitle, 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          ),
          Expanded(child: uiCommon.styledText(leftContent, 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left)),
          SizedBox(
            width: 150,
            child: uiCommon.styledText(rightTitle, 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          ),
          Expanded(child: uiCommon.styledText(rightContent, 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left)),
        ],
      ),
    );
  }

  Widget content2(
    String title,
  ) {
    return Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      padding: EdgeInsets.only(top: 8, bottom: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 150,
            padding: EdgeInsets.symmetric(vertical: 8),
            child: uiCommon.styledText(title, 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          ),
          Column(
            children: [
              newBuilding('용도', areaPurpose, '용적률', '$totalFloorRatio%'),
              newBuilding('건폐율', '$buildingCoverage%', '건축면적', '$buildingArea㎡'),
              newBuilding('연면적', '$totalFloorArea㎡', '지상 연면적', '$upperFloorArea㎡'),
              newBuilding('지상/지하', '$upperNum/B$lowerNum', '주차대수', '$parkingNum대'),
              newBuilding('승강기', '$elevator대', '', ''),
              newBuilding('기타사항', landEtc, '', ''),
            ],
          )
        ],
      ),
    );
  }

  Widget newBuilding(String leftTitle, String leftContent, String rightTitle, String rightContent) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          SizedBox(
            width: 140,
            child: uiCommon.styledText(leftTitle, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
          ),
          SizedBox(
            width: 270,
            child: uiCommon.styledText(leftContent, 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
          ),
          SizedBox(
            width: 140,
            child: uiCommon.styledText(rightTitle, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
          ),
          SizedBox(
            width: 270,
            child: uiCommon.styledText(rightContent, 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
          ),
        ],
      ),
    );
  }

  Widget imgContent(List imgPathList, List imgDescList) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //TODO 이미지 관련 사항
              (imgPathList[0] != '')
                  ? IdImageBox2(imagePath: imgPathList[0], imageWidth: 622, imageHeight: 529, round: 8, imageFit: BoxFit.cover)
                  : Container(
                      width: 622,
                      height: 529,
                      decoration: BoxDecoration(color: IdColors.borderDefault, borderRadius: BorderRadius.circular(8)),
                    ),
              const IdSpace(spaceWidth: 0, spaceHeight: 8),
              uiCommon.styledText(imgDescList[0], 16, 0, 1.6, FontWeight.w400, IdColors.textSecondly, TextAlign.left)
            ],
          ),
          const IdSpace(spaceWidth: 16, spaceHeight: 0),
          SizedBox(
            width: 656,
            child: Column(
              children: [
                //외관
                Row(
                  children: List.generate(
                    3,
                    (index) => Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (imgPathList[index + 1] != '')
                                ? IdImageBox2(
                                    imagePath: imgPathList[index + 1], imageWidth: 208, imageHeight: 143, round: 8, imageFit: BoxFit.cover)
                                : Container(
                                    width: 208,
                                    height: 143,
                                    decoration: BoxDecoration(
                                      color: IdColors.borderDefault,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                            uiCommon.styledText(
                                (imgDescList[index + 1].toString().length > 18)
                                    ? imgDescList[index + 1].toString().substring(0, 18) + '...'
                                    : imgDescList[index + 1],
                                16,
                                0,
                                1.6,
                                FontWeight.w400,
                                IdColors.textSecondly,
                                TextAlign.left)
                          ],
                        ),
                        (index != 2) ? const IdSpace(spaceWidth: 16, spaceHeight: 0) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                //외관
                Row(
                  children: List.generate(
                    3,
                    (index) => Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (imgPathList[index + 4] != '')
                                ? IdImageBox2(
                                    imagePath: imgPathList[index + 4], imageWidth: 208, imageHeight: 143, round: 8, imageFit: BoxFit.cover)
                                : Container(
                                    width: 208,
                                    height: 143,
                                    decoration: BoxDecoration(
                                      color: IdColors.borderDefault,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                            uiCommon.styledText(
                                (imgDescList[index + 4].toString().length > 18)
                                    ? imgDescList[index + 4].toString().substring(0, 18) + '...'
                                    : imgDescList[index + 4],
                                16,
                                0,
                                1.6,
                                FontWeight.w400,
                                IdColors.textSecondly,
                                TextAlign.left)
                          ],
                        ),
                        (index != 2) ? const IdSpace(spaceWidth: 16, spaceHeight: 0) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                Row(
                  children: List.generate(
                    3,
                    (index) => Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            (imgPathList[index + 7] != '')
                                ? IdImageBox2(
                                    imagePath: imgPathList[index + 7], imageWidth: 208, imageHeight: 143, round: 8, imageFit: BoxFit.cover)
                                : Container(
                                    width: 208,
                                    height: 143,
                                    decoration: BoxDecoration(
                                      color: IdColors.borderDefault,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                            uiCommon.styledText(
                                (imgDescList[index + 7].toString().length > 18)
                                    ? imgDescList[index + 7].toString().substring(0, 18) + '...'
                                    : imgDescList[index + 7],
                                16,
                                0,
                                1.6,
                                FontWeight.w400,
                                IdColors.textSecondly,
                                TextAlign.left)
                          ],
                        ),
                        (index != 2) ? const IdSpace(spaceWidth: 16, spaceHeight: 0) : const SizedBox(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget rentRoll() {
    return Padding(
      padding: const EdgeInsets.only(top: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 58,
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: Row(
              children: [
                uiCommon.styledText('Rent Roll', 16, 0, 1, FontWeight.w400, IdColors.textDefault, TextAlign.start),
              ],
            ),
          ),
          rentRollTable()
        ],
      ),
    );
  }

  Widget rentRollTable() {
    return Container(
      decoration: const BoxDecoration(border: Border(bottom: BorderSide(width: 1, color: IdColors.borderDefault))),
      child: Column(
        children: List.generate(
          rentRollList.length,
          (index) => Column(
            children: [
              Container(
                width: double.infinity,
                height: 58,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Row(
                  children: [
                    SizedBox(
                      child: rentRollTableContent('층', rentRollList[index][0]),
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      child: rentRollTableContent('업종', rentRollList[index][1]),
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      child: rentRollTableContent('면적(㎡)', rentRollList[index][2] + '㎡'),
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      child: rentRollTableContent('보증금(만원)', '${IdStrUtil.toMoneyUnitKr(rentRollList[index][3])}만원'),
                    ),
                    const Expanded(child: SizedBox()),
                    SizedBox(
                      child: rentRollTableContent('임대료(만원)', '${IdStrUtil.toMoneyUnitKr(rentRollList[index][4])}만원'),
                    ),
                    const Expanded(child: SizedBox()),
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                height: 58,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: SizedBox(
                  child: rentRollTableContent('비고', rentRollList[index][5]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget rentRollTableContent(String title, String content) {
    return Row(
      children: [
        uiCommon.styledText(title, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
        const IdSpace(spaceWidth: 16, spaceHeight: 0),
        uiCommon.styledText(content, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
      ],
    );
  }

  Widget lotTableHeader1(
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

  Widget lotTableHeader2(double topBorder, double leftBorder, double rightBorder, double bottoBorder, String contentsStr) {
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

  Widget lotTableBody(double cellWidth, double cellHeight, double leftBorder, double rightBorder, Widget childWidget) {
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
        lotTableBody(
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
                  Expanded(
                    child: lotTableBody(
                      120,
                      48,
                      1,
                      0,
                      Center(
                        child: uiCommon.styledText(
                            '${NumberFormat('#,##0.00').format(m2)}㎡', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      ),
                    ),
                  ),
                  Expanded(
                      child: lotTableBody(
                          120,
                          48,
                          1,
                          0,
                          Center(
                            child: uiCommon.styledText('${NumberFormat('#,##0.00').format(pyong)}py', 16, 0, 1, FontWeight.w500,
                                IdColors.textDefault, TextAlign.center),
                          ))),
                  lotTableBody(
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
                  lotTableBody(
                      120,
                      48,
                      1,
                      0,
                      Center(
                        child: uiCommon.styledText('주소', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      )),
                  Expanded(
                    child: lotTableBody(
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
        lotTableBody(
            164,
            96,
            1,
            0,
            Center(
              child: uiCommon.styledText(
                  NumberFormat('#,##0.00').format(construction), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
        lotTableBody(
            170,
            96,
            1,
            0,
            Center(
              child: uiCommon.styledText(
                  NumberFormat('#,##0.00').format(constrcutinoTotal), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
        lotTableBody(
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

  Widget lotInfoTable2(String infoNo, double m2, double pyong, String area, String address, double construction, double constrcutinoTotal,
      double sellingPrice) {
    return Row(
      children: [
        lotTableBody(
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
                  Expanded(
                    child: lotTableBody(
                        120,
                        48,
                        1,
                        0,
                        Center(
                          child: uiCommon.styledText((m2.toString().contains('.')) ? '${m2.toStringAsFixed(2)}㎡' : '$m2㎡', 16, 0, 1,
                              FontWeight.w500, IdColors.textDefault, TextAlign.center),
                        )),
                  ),
                  Expanded(
                      child: lotTableBody(
                          120,
                          48,
                          1,
                          0,
                          Center(
                            child: uiCommon.styledText((pyong.toString().contains('.')) ? '${pyong.toStringAsFixed(2)}py' : '${pyong}py',
                                16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                          ))),
                  lotTableBody(
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
                  lotTableBody(
                      120,
                      48,
                      1,
                      0,
                      Center(
                        child: uiCommon.styledText('주소', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                      )),
                  Expanded(
                    child: lotTableBody(
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
        lotTableBody(
            164,
            96,
            1,
            0,
            Center(
              child: uiCommon.styledText(
                  NumberFormat('#,##0.00').format(construction), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
        lotTableBody(
            170,
            96,
            1,
            0,
            Center(
              child: uiCommon.styledText(
                  NumberFormat('#,##0.00').format(constrcutinoTotal), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            )),
        lotTableBody(
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

  Widget lotTable() {
    return Column(
      children: [
        //헤더
        Row(
          children: [
            lotTableHeader1(80, 1, 1, 0, 1, 'NO'),
            Expanded(
              child: Column(
                children: [
                  lotTableHeader2(1, 1, 0, 1, '대지면적'),
                  Row(
                    children: [
                      Expanded(child: lotTableHeader2(1, 1, 0, 1, '㎡')),
                      Expanded(child: lotTableHeader2(1, 1, 0, 1, '평 ')),
                    ],
                  )
                ],
              ),
            ),
            lotTableHeader1(248, 1, 1, 0, 1, '용도지역'),
            lotTableHeader1(164, 1, 1, 0, 1, '개별공사지가'),
            lotTableHeader1(170, 1, 1, 0, 1, '공사지가합계'),
            lotTableHeader1(206, 1, 1, 1, 1, '매도가격()'),
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

  Widget lotList() {
    return Column(
      children: [
        Container(
          width: double.infinity,
          height: 58,
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: uiCommon.styledText('필지정보', 16, 0, 1, FontWeight.w400, IdColors.textDefault, TextAlign.left),
        ),
        lotTable()
      ],
    );
  }

  Widget bottomBtn(Function() onPressed, double width, Color btnColor, String title) {
    return IdNormalBtn(
      onBtnPressed: onPressed,
      childWidget: Container(
        width: width,
        height: 40,
        decoration: BoxDecoration(
          color: btnColor,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Center(
          child: uiCommon.styledText(title, 16, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
        ),
      ),
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
    setState(() {});
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
    setState(() {});
    return result;
  }

  double totalconstructPrice() {
    double result = 0;
    if (lotInfoList.isNotEmpty) {
      for (var i = 0; i < lotInfoList.length; i++) {
        result = double.tryParse((result + lotInfoList[i][4]).toString()) ?? 0;
      }
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

  Widget tabBtn(String title, Function() onBtnPressed) {
    return Stack(
      children: [
        IdNormalBtn(
          onBtnPressed: onBtnPressed,
          childWidget: Container(
            width: 104,
            height: 50,
            decoration: (title == tabBtnTitle)
                ? BoxDecoration(
                    border: Border.all(width: 1, color: IdColors.textDefault),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  )
                : BoxDecoration(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(4),
                    ),
                  ),
            child: Center(
              child: uiCommon.styledText(title, 16, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.center),
            ),
          ),
        ),
        Visibility(
          visible: (title == tabBtnTitle) ? true : false,
          child: Positioned(
            left: 1,
            right: 1,
            bottom: 0,
            child: Container(
              width: 102,
              height: 1,
              color: IdColors.white,
            ),
          ),
        )
      ],
    );
  }

  Widget progressContent(String title, String content) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 4,
              height: 4,
              decoration: BoxDecoration(color: IdColors.textDefault, shape: BoxShape.circle),
            ),
            const IdSpace(spaceWidth: 8, spaceHeight: 0),
            SizedBox(
              width: 100,
              child: uiCommon.styledText(title, 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
            ),
          ],
        ),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        Expanded(child: SizedBox(child: uiCommon.styledText(content, 16, 0, 1.6, FontWeight.w500, IdColors.textSecondly, TextAlign.left)))
      ],
    );
  }

  String additionalStr(String str) {
    String result = '';
    List resultList = [];

    for (var i = 0; i < locationCdList.length; i++) {
      if (str.contains(locationCdList[i][0])) {
        resultList.add(locationCdList[i][1]);
      }
    }

    result = resultList.toString().replaceAll('[', '').replaceAll(']', '');

    return result;
  }

  @override
  Widget build(BuildContext context) {
    uiCommon.setScreen(context);
    if (_dealMemoDs[0].data == null && _dealStatusDs[0].data == null) {
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
    _dealMemoSvcDS = makeRows1();
    _dealStatusSvcDS = makeRows2();

    var pages1 = _dealMemoSvcDS.isNotEmpty
        ? IdPaginationWidget(
            buttonColor: Color.fromRGBO(0, 0, 0, 0),
            buttonTextColor: IdColors.black,
            buttonFontSize: 18,
            actualPage: memoActuralPage,
            countToDisplay: 10,
            totalPages: memoTotalPage,
            onPageChange: (page) async {
              memoActuralPage = page;
              // clickNumber = 0;
              // ListIndex = 0;
              // _constructReportCheckDS.data!.list. = page;
              fetchData();
            },
            moveToBefore: (page) async {
              memoActuralPage - 1;
              fetchData();
            },
            moveToNext: (page) async {
              memoActuralPage + 1;
              fetchData();
            },
          )
        : const SizedBox();

    var pages2 = _dealStatusSvcDS.isNotEmpty
        ? IdPaginationWidget(
            buttonColor: Color.fromRGBO(0, 0, 0, 0),
            buttonTextColor: IdColors.black,
            buttonFontSize: 18,
            actualPage: statusActuralPage,
            countToDisplay: 10,
            totalPages: statusTotalPage,
            onPageChange: (page) async {
              statusActuralPage = page;
              // clickNumber = 0;
              // ListIndex = 0;
              // _constructReportCheckDS.data!.list. = page;
              fetchData();
            },
            moveToBefore: (page) async {
              statusActuralPage - 1;
              fetchData();
            },
            moveToNext: (page) async {
              statusActuralPage + 1;
              fetchData();
            },
          )
        : const SizedBox();

    Widget boardGrid1 = _dealMemoSvcDS.isNotEmpty
        ? IdGrid(
            width: (webWidth - 50),
            internalGrid: false,
            headerColumns: const ['NO', '작성자', '작성일자', '메모'],
            columnWidthsPercentages: const <double>[5, 18, 17, 60],
            headerBorderColor: const Color(0xffffff).withOpacity(0),
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 16,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 50,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 84,
            rowCnt: double.tryParse(memoCurrentRowsCnt.toString()) ?? 1,
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
            headerBodyInterval: 4,
            headerDecoration: const BoxDecoration(
              color: IdColors.backgroundDefault,
              border: BorderDirectional(
                top: BorderSide(width: 1, color: IdColors.borderDefault),
                bottom: BorderSide(width: 1, color: IdColors.borderDefault),
              ),
            ),
            rowDecoration: const BoxDecoration(
                color: IdColors.white, border: BorderDirectional(bottom: BorderSide(width: 1, color: IdColors.borderDefault))),
            rowInterval: 6,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowColor: IdColors.white,
            hoverColor: IdColors.ligthGreen,
            rowsCellRenderer: (row, cell, content) {
              return Stack(
                children: [
                  SizedBox(
                    height: 38,
                    // color: IdColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(content,
                              textAlign: (cell == 3) ? TextAlign.left : TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Pretendard',
                                color: IdColors.textDefault,
                                fontSize: 16,
                              ),
                              softWrap: true),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            noContentWidget: const SizedBox(), //Center(child: Container(width: 30, height: 30, child: CircularProgressIndicator())),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              setState(() {});
            },
            data: _dealMemoSvcDS)
        : Container(
            width: webWidth - 50,
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

    Widget boardGrid2 = _dealStatusSvcDS.isNotEmpty
        ? IdGrid(
            width: (webWidth - 50),
            internalGrid: false,
            headerColumns: const ['NO', '상태', '작성자', '변경일시', '코멘트'],
            columnWidthsPercentages: const <double>[5, 13, 7, 18, 57],
            headerBorderColor: const Color(0xffffff).withOpacity(0),
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 16,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 50,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 84,
            rowCnt: double.tryParse(statusCurrentRowsCnt.toString()) ?? 1,
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
            headerBodyInterval: 4,
            headerDecoration: const BoxDecoration(
              color: IdColors.backgroundDefault,
              border: BorderDirectional(
                top: BorderSide(width: 1, color: IdColors.borderDefault),
                bottom: BorderSide(width: 1, color: IdColors.borderDefault),
              ),
            ),
            rowDecoration: const BoxDecoration(
                color: IdColors.white, border: BorderDirectional(bottom: BorderSide(width: 1, color: IdColors.borderDefault))),
            rowInterval: 6,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowColor: IdColors.white,
            hoverColor: IdColors.ligthGreen,
            rowsCellRenderer: (row, cell, content) {
              return Stack(
                children: [
                  SizedBox(
                    height: 38,
                    // color: IdColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(content,
                              textAlign: (cell == 4) ? TextAlign.left : TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Pretendard',
                                color: IdColors.textDefault,
                                fontSize: 16,
                              ),
                              softWrap: true),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            noContentWidget: const SizedBox(), //Center(child: Container(width: 30, height: 30, child: CircularProgressIndicator())),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              setState(() {});
            },
            data: _dealStatusSvcDS)
        : Container(
            width: webWidth - 50,
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

    Widget boardGrid3 = _dealMemoSvcDS.isNotEmpty
        ? IdGrid(
            width: (webWidth - 50),
            internalGrid: false,
            headerColumns: const ['NO', '파일명', '작성자', '작성일자', '메모'],
            columnWidthsPercentages: const <double>[5, 25, 7, 18, 45],
            headerBorderColor: const Color(0xffffff).withOpacity(0),
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 16,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 50,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 84,
            rowCnt: double.tryParse(memoCurrentRowsCnt.toString()) ?? 1,
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
            headerBodyInterval: 4,
            headerDecoration: const BoxDecoration(
              color: IdColors.backgroundDefault,
              border: BorderDirectional(
                top: BorderSide(width: 1, color: IdColors.borderDefault),
                bottom: BorderSide(width: 1, color: IdColors.borderDefault),
              ),
            ),
            rowDecoration: const BoxDecoration(
                color: IdColors.white, border: BorderDirectional(bottom: BorderSide(width: 1, color: IdColors.borderDefault))),
            rowInterval: 6,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowColor: IdColors.white,
            hoverColor: IdColors.ligthGreen,
            rowsCellRenderer: (row, cell, content) {
              return Stack(
                children: [
                  SizedBox(
                    height: 38,
                    // color: IdColors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(content,
                              textAlign: (cell == 4) ? TextAlign.left : TextAlign.center,
                              maxLines: 2,
                              style: const TextStyle(
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Pretendard',
                                color: IdColors.textDefault,
                                fontSize: 16,
                              ),
                              softWrap: true),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
            noContentWidget: const SizedBox(), //Center(child: Container(width: 30, height: 30, child: CircularProgressIndicator())),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              setState(() {});
            },
            data: _dealMemoSvcDS)
        : Container(
            width: webWidth - 50,
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

    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: IdColors.white,
                    border: Border.all(width: 1, color: IdColors.borderDefault),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      //상단
                      Stack(
                        children: [
                          SizedBox(
                            width: double.infinity,
                            height: (labelMore) ? 132 : 100,
                          ),
                          //타이틀
                          Positioned(
                            top: 3.5,
                            left: 0,
                            child: Row(
                              children: [
                                uiCommon.styledText(title, 32, 0, 1.6, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                                const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                Padding(
                                  padding: const EdgeInsets.only(top: 10),
                                  child: Container(
                                    height: 34,
                                    padding: const EdgeInsets.symmetric(horizontal: 14),
                                    decoration: BoxDecoration(
                                      color: IdColors.white,
                                      borderRadius: BorderRadius.circular(40),
                                      border: Border.all(width: 1, color: IdColors.borderDefault),
                                    ),
                                    child: Center(
                                        child: uiCommon.styledText(
                                            (dealStatus == '0')
                                                ? '보류'
                                                : (dealStatus == '1')
                                                    ? '거래중'
                                                    : '거래완료',
                                            16,
                                            0,
                                            1,
                                            FontWeight.w600,
                                            IdColors.textSecondly,
                                            TextAlign.center)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          //라벨
                          Positioned(
                            top: 70.5,
                            left: 0,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                IdNormalBtn(
                                  onBtnPressed: () {
                                    editLabelPopupVisible = true;
                                    setState(() {});
                                  },
                                  childWidget: Container(
                                    width: 94,
                                    height: 26,
                                    decoration: BoxDecoration(
                                      color: IdColors.white,
                                      border: Border.all(
                                        width: 1,
                                        color: IdColors.textDefault,
                                      ),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Center(
                                      child: uiCommon.styledText('라벨편집', 16, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.center),
                                    ),
                                  ),
                                ),
                                const IdSpace(spaceWidth: 10, spaceHeight: 0),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: List.generate(
                                        labelLsit.length,
                                        (index) => (index < 6)
                                            ? Row(
                                                children: [pjtLabel(index), const IdSpace(spaceWidth: 6, spaceHeight: 0)],
                                              )
                                            : const SizedBox(),
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        IdSpace(spaceWidth: 0, spaceHeight: 6),
                                        Row(
                                          children: List.generate(
                                            labelLsit.length,
                                            (index) => (index >= 6)
                                                ? Row(
                                                    children: [pjtLabel(index), const IdSpace(spaceWidth: 6, spaceHeight: 0)],
                                                  )
                                                : SizedBox(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                const IdSpace(spaceWidth: 10, spaceHeight: 0),
                                (labelLsit.length > 6)
                                    ? IdNormalBtn(
                                        onBtnPressed: () {
                                          if (labelMore) {
                                            labelMore = false;
                                          } else {
                                            labelMore = true;
                                          }
                                          setState(() {});
                                        },
                                        childWidget: const IdImageBox(
                                            imagePath: 'assets/img/icon_more.png',
                                            imageWidth: 26,
                                            imageHeight: 26,
                                            imageFit: BoxFit.contain))
                                    : const SizedBox()
                              ],
                            ),
                          ),
                          //버튼
                          Visibility(
                            visible: (domiYn == 'Y') ? true : false,
                            child: Positioned(
                              top: 26,
                              right: 0,
                              child: IdNormalBtn(
                                onBtnPressed: () {
                                  uiCommon.IdMovePage(context, PAGE_CERT_PDF_PAGE);
                                },
                                childWidget: Container(
                                  width: 178,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    color: IdColors.certification,
                                    borderRadius: BorderRadius.circular(40),
                                  ),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const IdImageBox(imagePath: 'assets/img/icon_certification.png', imageFit: BoxFit.cover),
                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                        uiCommon.styledText("인증서 보기", 18, 0, 1, FontWeight.w700, IdColors.white, TextAlign.left),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                      const IdSpace(spaceWidth: 0, spaceHeight: 16),
                      Row(
                        children: [
                          iconWithText((type == 'B') ? 'assets/img/icon_mydeal_building.png' : 'assets/img/icon_mydeal_land.png',
                              (type == 'B') ? '건물' : '신축부지'),
                          const IdSpace(spaceWidth: 16, spaceHeight: 0),
                          iconWithText((category == '1') ? 'assets/img/icon_mydeal_sell.png' : 'assets/img/icon_mydeal_agency.png',
                              (category == '1') ? '매각' : '위탁운영'),
                        ],
                      ),
                      const IdSpace(spaceWidth: 0, spaceHeight: 16),
                      (type == 'B')
                          ? Column(
                              children: [
                                //첫 번째 컬럼
                                Column(
                                  children: [
                                    contentTitle(
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
                                            color: IdColors.borderDefault,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: uiCommon.styledText(
                                                '지도보기', 14, 0, 1, FontWeight.w700, IdColors.textTertiary, TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    ),
                                    content('등록자', register, '소재지', address),
                                    content('건물명', buildingName, '대지면적(㎡)', '$lotArea㎡'),
                                    content('연면적(㎡)', '$totalFloorArea㎡', '용도지역', areaPurpose),
                                    content('용적률(%)', '$totalFloorRatio%', '주용도', mainPurpose),
                                    content('주구조', mainStruct, '준공연도', ccd),
                                    content('지상/지하', '$upperNum/B$lowerNum', '승강기(대)', '$elevator대'),
                                    content('주차장(대)', '$parkingNum대', '공시지가(만원)', '${IdStrUtil.toMoneyUnitKr(officialLandPrice)}만원'),
                                    content('공시지가 합계(만원)', '${IdStrUtil.toMoneyUnitKr(totalLandPrice)}만원', '', ''),
                                  ],
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                //두 번째 컬럼
                                Column(
                                  children: [
                                    contentTitle(
                                      '제안할 부동산 거래 정보',
                                      const SizedBox(),
                                    ),
                                    content('희망매각가(억원)', '$asking억원', '가격협의', negotiationType),
                                    content('명도', evacuationType, '예상명도기간(개월)', '$evacuationPeriod개월 $evacuationChk'),
                                    content('보증금(만원)', '${IdStrUtil.toMoneyUnitKr(deposit)}만원 $depositChk', '월세(만원)',
                                        '${IdStrUtil.toMoneyUnitKr(monthly)}만원 $monthlyChk'),
                                    content('융자여부', loan, '객실 수(개)', roomNum),
                                    content('리모델링(여부)', reModel, '인근 지하철/거리', '$stationName/$stationDistance'),
                                    rentRoll()
                                  ],
                                ),
                              ],
                            )
                          : Column(
                              children: [
                                //첫 번째 컬럼
                                Column(
                                  children: [
                                    contentTitle(
                                      '부동산 기본 정보',
                                      IdNormalBtn(
                                        onBtnPressed: () {
                                          mapPopupVisible = true;
                                          setState(() {});
                                        },
                                        childWidget: Container(
                                          width: 97,
                                          height: 38,
                                          decoration: BoxDecoration(
                                            color: IdColors.borderDefault,
                                            borderRadius: BorderRadius.circular(4),
                                          ),
                                          child: Center(
                                            child: uiCommon.styledText(
                                                '지도보기', 14, 0, 1, FontWeight.w700, IdColors.textTertiary, TextAlign.center),
                                          ),
                                        ),
                                      ),
                                    ),
                                    content('등록자', register, '소재지', address),
                                    lotList()
                                  ],
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                //두 번째 컬럼
                                Column(
                                  children: [
                                    contentTitle(
                                      '부동산 거래 정보',
                                      const SizedBox(),
                                    ),
                                    content('희망매각가(억원)', '$asking억원', '가격협의', negotiationType),
                                    content('자산현황', assetStatus, '예상명도기간(개월)', '$evacuationPeriod개월 $evacuationChk'),
                                    content('소유자', owner, '인근 지하철/거리', '$stationName/$stationDistance'),
                                    content2('신축예상규모\n(인허가/착공)')
                                  ],
                                ),
                              ],
                            ),
                      const IdSpace(spaceWidth: 0, spaceHeight: 16),
                      //세 번째 컬럼
                      Column(
                        children: [
                          contentTitle(
                            '기타 정보',
                            const SizedBox(),
                          ),
                          content('Deal 제목', title, '위치 특이사항', additionalStr(additional)),
                          content('기타 특이사항', additionalEtc, '', ''),
                          imgContent(imgPathList, imgDescList),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                uiCommon.styledText('기타 자료등록', 18, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child:
                                          uiCommon.styledText('TM 자료이름', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                                    ),
                                    Expanded(
                                        child: uiCommon.styledText(
                                            imgDescList[10], 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left)),
                                  ],
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: uiCommon.styledText('도면이름', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                                    ),
                                    Expanded(
                                        child: uiCommon.styledText(
                                            imgDescList[11], 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left)),
                                  ],
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 150,
                                      child: uiCommon.styledText('기타', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                                    ),
                                    Expanded(
                                        child: uiCommon.styledText(
                                            imgDescList[12], 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left)),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const IdSpace(spaceWidth: 0, spaceHeight: 16),
                      Row(
                        children: [
                          const Expanded(child: SizedBox()),
                          Row(
                            children: [
                              Visibility(
                                visible: (detailPage == 'dealDomi') ? true : false,
                                child: Row(
                                  children: [
                                    bottomBtn(() {
                                      agressPopupVisible = true;
                                      setState(() {});
                                    }, 104, IdColors.textDefault, '동의보기'),
                                    const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                    (domiYn == 'N')
                                        ? Row(
                                            children: [
                                              bottomBtn(() {
                                                alertPopupVisible = true;
                                                setState(() {});
                                              }, 104, IdColors.orange, '독점승인'),
                                              const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                            ],
                                          )
                                        : const SizedBox(),
                                  ],
                                ),
                              ),
                              bottomBtn(() {
                                if (detailPage == 'deal') {
                                  uiCommon.IdMovePage(context, PAGE_DEAL_PAGE);
                                } else {
                                  uiCommon.IdMovePage(context, PAGE_DEAL_DOMI_PAGE);
                                }
                              }, 76, IdColors.textTertiary, '목록'),
                            ],
                          ),
                        ],
                      ),
                      Visibility(
                        visible: (detailPage == 'dealDomi') ? false : true,
                        child: Column(
                          children: [
                            const IdSpace(spaceWidth: 0, spaceHeight: 50),
                            Stack(
                              children: [
                                Container(
                                  width: double.infinity,
                                  height: 70,
                                  decoration: const BoxDecoration(
                                    border: Border(
                                      bottom: BorderSide(width: 1, color: IdColors.textDefault),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 0,
                                  left: 0,
                                  child: Row(
                                    children: [
                                      tabBtn(
                                        '메모관리',
                                        () {
                                          tabBtnTitle = tabList[0];
                                          fileType = '';
                                          setState(() {});
                                          fetchData();
                                        },
                                      ),
                                      tabBtn(
                                        '진행관리',
                                        () {
                                          tabBtnTitle = tabList[1];
                                          setState(() {});
                                          fetchData();
                                        },
                                      ),
                                      tabBtn(
                                        '파일관리',
                                        () {
                                          tabBtnTitle = tabList[2];
                                          fileType = 'Y';
                                          setState(() {});
                                          fetchData();
                                        },
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            const IdSpace(spaceWidth: 0, spaceHeight: 16),
                            //하단 탭으로 제어
                            SizedBox(
                              width: double.infinity,
                              child: (tabBtnTitle == tabList[0])
                                  ? Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        //TODO 메모 리스트
                                        boardGrid1,
                                        Container(
                                          width: double.infinity,
                                          padding: const EdgeInsets.symmetric(vertical: 40),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              pages1,
                                            ],
                                          ),
                                        ),
                                        const IdSpace(spaceWidth: 0, spaceHeight: 32),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 32,
                                          child: Row(
                                            children: [
                                              const Expanded(child: SizedBox()),
                                              IdNormalBtn(
                                                //TODO 메모 팝업
                                                onBtnPressed: () {
                                                  memoPopupVisible = true;
                                                  setState(() {});
                                                },
                                                childWidget: Container(
                                                  width: 72,
                                                  height: 32,
                                                  decoration: BoxDecoration(
                                                    color: IdColors.green,
                                                    borderRadius: BorderRadius.circular(4),
                                                  ),
                                                  child: Center(
                                                    child: uiCommon.styledText(
                                                        '새 메모', 14, 0, 1, FontWeight.w700, IdColors.white, TextAlign.center),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : (tabBtnTitle == tabList[1])
                                      ? Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: double.infinity,
                                              height: 48,
                                              child: Center(
                                                child: Row(
                                                  crossAxisAlignment: CrossAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: 100,
                                                      child: uiCommon.styledText(
                                                          '투자심의', 18, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                                                    ),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    IdNormalBtn(
                                                      //TODO 상태변경 팝업
                                                      onBtnPressed: () {
                                                        statusChangePopupVisible = true;
                                                        setState(() {});
                                                      },
                                                      childWidget: Container(
                                                        width: 84,
                                                        height: 32,
                                                        decoration: BoxDecoration(
                                                          color: IdColors.textTertiary,
                                                          borderRadius: BorderRadius.circular(4),
                                                        ),
                                                        child: Center(
                                                          child: uiCommon.styledText(
                                                              '상태 변경', 14, 0, 1, FontWeight.w700, IdColors.white, TextAlign.center),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                            progressContent('상태변경일', changeDateTime),
                                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                            progressContent('작성자', statusCreator),
                                            const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                            progressContent('코멘트', statusComent),
                                            const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                            //TODO 진행관리 리스트
                                            boardGrid2,
                                            Container(
                                              width: double.infinity,
                                              padding: const EdgeInsets.symmetric(vertical: 40),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  pages2,
                                                ],
                                              ),
                                            ),
                                          ],
                                        )
                                      : Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            //TODO 파일관리 리스트
                                            boardGrid3,
                                            const IdSpace(spaceWidth: 0, spaceHeight: 24),
                                            SizedBox(
                                              width: double.infinity,
                                              height: 32,
                                              child: Row(
                                                children: [
                                                  const Expanded(child: SizedBox()),
                                                  IdNormalBtn(
                                                    //TODO 메모 팝업
                                                    onBtnPressed: () {
                                                      filePopupVisible = true;
                                                      setState(() {});
                                                    },
                                                    childWidget: Container(
                                                      width: 81,
                                                      height: 32,
                                                      decoration: BoxDecoration(
                                                        color: IdColors.textTertiary,
                                                        borderRadius: BorderRadius.circular(4),
                                                      ),
                                                      child: Center(
                                                        child: uiCommon.styledText(
                                                            '파일등록', 14, 0, 1, FontWeight.w700, IdColors.white, TextAlign.center),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                          ],
                                        ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                (domiYn == "N")
                    ? const SizedBox()
                    : const Visibility(
                        child: Positioned(
                          top: 0,
                          left: 0,
                          child: IdImageBox(
                              imagePath: 'assets/img/icon_dealDomi_label.png', imageWidth: 61, imageHeight: 61, imageFit: BoxFit.cover),
                        ),
                      ),
              ],
            ),
          ),
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
            visible: agressPopupVisible,
            child: Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: IdColors.black8Per,
                child: Center(
                  child: AgreePopup(onlyCloseFunction: () {
                    agressPopupVisible = false;
                    setState(() {});
                  }),
                ),
              ),
            ),
          ),
          Visibility(
            visible: alertPopupVisible,
            child: Positioned(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: IdColors.black8Per,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AlertPopup(
                            popupTitle: '독점보호 승인',
                            content: '독점보호를 진행하시겠습니까?',
                            onlyCloseFunction: () {
                              alertPopupVisible = false;
                              setState(() {});
                            },
                            activeFunction: () async {
                              if (await setDomi()) {
                                alertPopupVisible = false;
                                domiYn = 'Y';
                                fetchData();
                              } else {
                                GV.d('실패');
                              }
                            })
                      ],
                    ),
                  ],
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
                color: IdColors.black8Per,
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
          Visibility(
            visible: filePopupVisible,
            child: Positioned(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: IdColors.black8Per,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FilePopup(
                          onlyCloseFunction: () {
                            filePopupVisible = false;
                            _commentController.text = '';
                            _fileController2.text = '';
                            setState(() {});
                          },
                          searchFunction: () {
                            memoUploadFile();
                          },
                          imgSize: imgSize,
                          closeAndUpdateFunction: (imgSize > 200)
                              ? () {}
                              : () async {
                                  _fileController.text = '';
                                  if (_fileController2.text != '') {
                                    if (await setMemo2()) {
                                      filePopupVisible = false;
                                      _commentController.text = '';
                                      _fileController2.text = '';
                                      setState(() {});
                                      fetchData();
                                    } else {
                                      GV.d('실패');
                                    }
                                  } else {}
                                },
                          memoController: _commentController,
                          fileController: _fileController2,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: editLabelPopupVisible,
            child: Positioned(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: IdColors.black8Per,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        EditLabelPopup(onlyCloseFunction: () {
                          editLabelPopupVisible = false;
                          setState(() {});
                        })
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Visibility(
            visible: statusChangePopupVisible,
            child: Positioned(
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: IdColors.black8Per,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        StatusChangePopup(
                          onlyCloseFunction: () {
                            statusChangePopupVisible = false;
                            setState(() {});
                          },
                          cdList: cdList,
                          progress: progressStr,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
