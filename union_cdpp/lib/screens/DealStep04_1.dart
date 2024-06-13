// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:typed_data';

import 'package:croppy/croppy.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDealRegistBottomBtn.dart';
import 'package:unionCDPP/id_widget/IdDottedBorderContainer.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageStep.dart';
import 'package:unionCDPP/id_widget/IdRadio.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/modelVO/commonCdItem.dart';
import 'package:unionCDPP/modelVO/commonCdResponse.dart';
import 'package:unionCDPP/modelVO/dealBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealLotItem.dart';
import 'package:unionCDPP/modelVO/dealLotResponse.dart';
import 'package:unionCDPP/modelVO/dealMasterItem.dart';
import 'package:unionCDPP/modelVO/dealNewBuildingItem.dart';
import 'package:unionCDPP/modelVO/dealRegisterItem.dart';
import 'package:unionCDPP/modelVO/dealRentRollItem.dart';
import 'package:unionCDPP/modelVO/dealRentRollResponse.dart';

class _CommonCdList {
  CommonCdResponse? data;
}

class DealStep04_1 extends StatefulWidget {
  const DealStep04_1({super.key});

  @override
  IdState<DealStep04_1> createState() => _DealStep04_1State();
}

class _DealStep04_1State extends IdState<DealStep04_1> {
  CommonCdItem? commonCd1Item;
  List<_CommonCdList> _commonCd1Item = [];
  List<_CommonCdList> _commonCd2Item = [];
  DealMasterItem? dealMasterItem;
  DealNewBuildingItem? dealNewBuildingItem;
  DealLotResponse? dealLotResponse;
  DealBuildingItem? dealBuildingItem;
  DealRentRollResponse? dealRentRollResponse;
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List stepDesc = [];

  String dealNo = GV.pStrg.getXXX(Param_newDealNo);
  String userNo = GV.pStrg.getXXX(Param_commonUserNo);
  String pnu = '';
  String register = '';
  String registerEtc = '';
  String address = '';
  String addressDtl = '';
  String areaPos = '';
  String asking = '';
  String negotiationType = '';
  String assetStatus = '';
  String evacuationType = '';
  String evacuationPeriod = '';
  String evacuationChk = '';
  String stationDistance = '';
  String stationName = '';
  //
  String buildingArea = '';
  String landUsage = '';
  String buildingCoverage = '';
  String upperFloorArea = '';
  String lowerFloorArea = '';
  String etc = '';
  String owner = '';
  List<DealLotItem> lotList = [];

  //
  String parkingNum = '';
  String totalFloorArea = '';
  String elevator = '';
  String totalFloorRatio = '';
  String bdCoverageRatio = '';
  String lowerNum = '';
  String upperNum = '';
  String bdUniqueId = '';
  String buildingName = '';
  String lotArea = '';
  String areaPurpose = '';
  String mainPurpose = '';
  String mainStruct = '';
  String ccd = '';
  String officialLandPrice = '';
  String totalLandPrice = '';
  String deposit = '';
  String depositChk = '';
  String monthly = '';
  String monthlyChk = '';
  String loan = '';
  String roomNum = '';
  String reModel = '';
  String bdDistrictUnitPlan = '';
  List<DealRentRollItem> rentrollList = [];

  String dealType = '';
  String dealCategory = '';

  String title = '';
  List additional = [];
  List buildingEtc = [];

  List<int> areaNumList = [];
  List<int> buildingNumList = [];

  List<String> areaCDList = [];
  List<String> areaList = [];
  List<String> buildingCDList = [];
  List<String> buildingList = [];

  bool negotiateBool = false;

  List<RawImage?> imgList = [null, null, null, null, null, null, null, null, null, null, null, null, null];
  List<dynamic> fileList = [];
  List<int> fileNumList = [];
  int nullCount = 13;

  TextEditingController _dealTitleController = TextEditingController(); //딜제목
  TextEditingController _otherSpecialInfoController = TextEditingController(); //기타 특이사항

  List<TextEditingController> textControllerList = [];
  TextEditingController _img1DescController = TextEditingController(); //1
  TextEditingController _img2DescController = TextEditingController(); //2
  TextEditingController _img3DescController = TextEditingController(); //3
  TextEditingController _img4DescController = TextEditingController(); //4
  TextEditingController _img5DescController = TextEditingController(); //5
  TextEditingController _img6DescController = TextEditingController(); //6
  TextEditingController _img7DescController = TextEditingController(); //7
  TextEditingController _img8DescController = TextEditingController(); //8
  TextEditingController _img9DescController = TextEditingController(); //9
  TextEditingController _img10DescController = TextEditingController(); //10
  List<String> textControllerTextList = [];

  TextEditingController _TM_InfoController = TextEditingController(); //TM자료
  TextEditingController _floorPlanController = TextEditingController(); //도면
  TextEditingController _otherController = TextEditingController(); //기타

  @override
  void initState() {
    super.initState();
    dealMasterItem = DealMasterItem();
    dealNewBuildingItem = DealNewBuildingItem();
    dealLotResponse = DealLotResponse();
    dealBuildingItem = DealBuildingItem();
    dealRentRollResponse = DealRentRollResponse();
    _commonCd1Item.add(_CommonCdList());
    _commonCd2Item.add(_CommonCdList());

    textControllerList = [
      _img1DescController, //1
      _img2DescController, //2
      _img3DescController, //3
      _img4DescController, //4
      _img5DescController, //5
      _img6DescController, //6
      _img7DescController, //7
      _img8DescController, //8
      _img9DescController, //9
      _img10DescController, //10
    ];
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
    String dealLotStr = GV.pStrg.getXXX('dealLotJson');
    String dealBuildingItemStr = GV.pStrg.getXXX('dealBuildingJson');
    String dealRentRollStr = GV.pStrg.getXXX('dealRentRollJson');
    String rentRollRegistCheck = GV.pStrg.getXXX(Param_rentRollRegist);

    if (dealMasterItemStr != '') {
      dealMasterItem = DealMasterItem.fromJson(jsonDecode(dealMasterItemStr));
      //딜마스터
      pnu = dealMasterItem!.pnu!;
      dealType = dealMasterItem!.type!;
      dealCategory = dealMasterItem!.category!;
      register = dealMasterItem!.register!;
      registerEtc = dealMasterItem!.registerEtc!;
      address = dealMasterItem!.address!;
      addressDtl = dealMasterItem!.addressDtl!;
      areaPos = dealMasterItem!.areaPos!;
      asking = dealMasterItem!.asking!;
      negotiationType = dealMasterItem!.negotiationType!;
      evacuationType = dealMasterItem!.evacuationType!;
      evacuationPeriod = dealMasterItem!.evacuationPeriod!;
      evacuationChk = dealMasterItem!.evacuationChk!;
      stationDistance = dealMasterItem!.stationDistance!;
      stationName = dealMasterItem!.stationName!;
    }
    if (dealNewBuildingItemStr != '') {
      dealNewBuildingItem = DealNewBuildingItem.fromJson(jsonDecode(dealNewBuildingItemStr));
      buildingArea = dealNewBuildingItem!.buildingArea!;
      landUsage = dealNewBuildingItem!.landUsage!;
      parkingNum = dealNewBuildingItem!.parkingNum!;
      totalFloorArea = dealNewBuildingItem!.totalFloorArea!;
      buildingCoverage = dealNewBuildingItem!.buildingCoverage!;
      elevator = dealNewBuildingItem!.elevator!;
      upperFloorArea = dealNewBuildingItem!.upperFloorArea!;
      lowerFloorArea = dealNewBuildingItem!.lowerFloorArea!;
      totalFloorRatio = dealNewBuildingItem!.totalFloorRatio!;
      lowerNum = dealNewBuildingItem!.lowerNum!;
      upperNum = dealNewBuildingItem!.upperNum!;
      etc = dealNewBuildingItem!.etc!;
      owner = dealNewBuildingItem!.owner!;
    }
    if (dealLotStr != '') {
      dealLotResponse = DealLotResponse.fromJson(jsonDecode(dealLotStr));
      lotList = dealLotResponse!.lotList!;
    }
    if (dealBuildingItemStr != '') {
      dealBuildingItem = DealBuildingItem.fromJson(jsonDecode(dealBuildingItemStr));
      //building
      bdUniqueId = dealBuildingItem!.bdUniqueId!;
      buildingName = dealBuildingItem!.buildingName!;
      lotArea = dealBuildingItem!.lotArea!;
      totalFloorArea = dealBuildingItem!.totalFloorArea!;
      areaPurpose = dealBuildingItem!.areaPurpose!;
      totalFloorRatio = dealBuildingItem!.totalFloorRatio!;
      bdCoverageRatio = dealBuildingItem!.bdCoverageRatio!;
      bdDistrictUnitPlan = dealBuildingItem!.bdDistrictUnitPlan!;
      mainPurpose = dealBuildingItem!.mainPurpose!;
      mainStruct = dealBuildingItem!.mainStruct!;
      parkingNum = dealBuildingItem!.parkingNum!;
      elevator = dealBuildingItem!.elevator!;
      lowerNum = dealBuildingItem!.lowerNum!;
      upperNum = dealBuildingItem!.upperNum!;
      ccd = dealBuildingItem!.ccd!;
      officialLandPrice = dealBuildingItem!.officialLandPrice!;
      totalLandPrice = dealBuildingItem!.totalLandPrice!;
      deposit = dealBuildingItem!.deposit!;
      depositChk = dealBuildingItem!.depositChk!;
      monthly = dealBuildingItem!.monthly!;
      monthlyChk = dealBuildingItem!.monthlyChk!;
      loan = dealBuildingItem!.loan!;
      roomNum = dealBuildingItem!.roomNum!;
      reModel = dealBuildingItem!.reModel!;
    }
    if (dealRentRollStr != '') {
      dealRentRollResponse = DealRentRollResponse.fromJson(jsonDecode(dealRentRollStr));
      if (rentRollRegistCheck == '2') {
        rentrollList = [];
      } else {
        rentrollList = dealRentRollResponse!.rentrollList!;
      }
    }

    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    final CommonCdResponse ret1 = await IdApi.getCommonCd1();
    final CommonCdResponse ret2 = await IdApi.getCommonCd2();
    if (ret1 != null) {
      _commonCd1Item[0].data = ret1;
      for (var i = 0; i < _commonCd1Item[0].data!.list!.length; i++) {
        areaCDList.add(_commonCd1Item[0].data!.list![i].cd!);
        areaList.add(_commonCd1Item[0].data!.list![i].cdName!);
        areaNumList.add(0);
      }
    }
    if (ret2 != null) {
      _commonCd2Item[0].data = ret2;
      for (var i = 0; i < _commonCd2Item[0].data!.list!.length; i++) {
        buildingCDList.add(_commonCd2Item[0].data!.list![i].cd!);
        buildingList.add(_commonCd2Item[0].data!.list![i].cdName!);
        buildingNumList.add(0);
      }
    }
    setState(() {});
  }

  Future<bool> setDeal() async {
    for (var i = 0; i < areaNumList.length; i++) {
      if (areaNumList[i] != 0) {
        additional.add(areaCDList[i]);
      }
    }
    for (var i = 0; i < buildingNumList.length; i++) {
      if (buildingNumList[i] != 0) {
        buildingEtc.add(buildingCDList[i]);
      }
    }

    for (var i = 0; i < textControllerList.length; i++) {
      if (textControllerList[i].text != '') {
        textControllerTextList.add(textControllerList[i].text);
      }
    }

    for (var i = 0; i < fileNumList.length; i++) {
      fileList.add('{"fileDoc":"${textControllerTextList[i]}", "fileOrder":"${fileNumList[i]}"}');
    }

    GV.pStrg.putXXX(Param_dealAddress, address + ' ' + addressDtl);

    // GV.d(asking);
    // GV.d(officialLandPrice);
    // GV.d(totalLandPrice);
    // GV.d(lotList);

    if (dealType == 'L') {
      final result = await IdApi.setDealLand(
        dealNo,
        userNo,
        pnu,
        DealMasterItem(
          pnu: pnu,
          title: _dealTitleController.text,
          type: dealType,
          category: dealCategory,
          register: register,
          registerEtc: registerEtc,
          address: address,
          addressDtl: addressDtl,
          areaPos: areaPos,
          asking: asking.replaceAll(',', ''),
          negotiationType: negotiationType,
          assetStatus: assetStatus,
          evacuationType: evacuationType,
          evacuationPeriod: evacuationPeriod,
          evacuationChk: evacuationChk,
          stationDistance: stationDistance,
          stationName: stationName,
          additional: additional.toString().split('[')[1].split(']')[0],
          additionalEtc: _otherSpecialInfoController.text,
        ),
        DealNewBuildingItem(
          landUsage: landUsage,
          buildingArea: buildingArea.replaceAll(',', ''),
          totalFloorArea: totalFloorArea.replaceAll(',', ''),
          totalFloorRatio: totalFloorRatio.replaceAll(',', ''),
          buildingCoverage: buildingCoverage.replaceAll(',', ''),
          parkingNum: parkingNum.replaceAll(',', ''),
          elevator: elevator.replaceAll(',', ''),
          lowerFloorArea: lowerFloorArea.replaceAll(',', ''),
          upperFloorArea: upperFloorArea.replaceAll(',', ''),
          lowerNum: lowerNum.replaceAll(',', ''),
          upperNum: upperNum.replaceAll(',', ''),
          etc: etc,
          owner: owner,
        ),
        lotList,
        fileList,
      );
      DealRegisterItem data = result;

      GV.pStrg.putXXX(Param_dominantlyOwnedStr, data.dominantlyOwned!.toString());
      GV.pStrg.putXXX(Param_regOrderCntStr, data.regOrder!.toString());
      if (result == null) return false;
    } else {
      final result = await IdApi.setDealBuilding(
        dealNo,
        userNo,
        pnu,
        DealMasterItem(
          pnu: pnu,
          title: _dealTitleController.text,
          type: dealType,
          category: dealCategory,
          register: register,
          registerEtc: registerEtc,
          address: address,
          addressDtl: addressDtl,
          areaPos: areaPos,
          asking: asking.replaceAll(',', ''),
          negotiationType: negotiationType,
          assetStatus: assetStatus,
          evacuationType: evacuationType,
          evacuationPeriod: evacuationPeriod,
          evacuationChk: evacuationChk,
          stationDistance: stationDistance,
          stationName: stationName,
          additional: additional.toString().split('[')[1].split(']')[0],
          additionalEtc: _otherSpecialInfoController.text,
        ),
        DealBuildingItem(
            pnu: pnu,
            buildingName: buildingName,
            lotArea: lotArea.replaceAll(',', ''),
            totalFloorArea: totalFloorArea.replaceAll(',', ''),
            areaPurpose: areaPurpose,
            totalFloorRatio: totalFloorRatio.replaceAll(',', ''),
            bdCoverageRatio: bdCoverageRatio.replaceAll(',', ''),
            bdDistrictUnitPlan: bdDistrictUnitPlan,
            mainPurpose: mainPurpose,
            mainStruct: mainStruct,
            ccd: ccd.replaceAll(',', ''),
            lowerNum: lowerNum.replaceAll(',', ''),
            upperNum: upperNum.replaceAll(',', ''),
            elevator: elevator.replaceAll(',', ''),
            parkingNum: parkingNum.replaceAll(',', ''),
            officialLandPrice: officialLandPrice.replaceAll(',', ''),
            totalLandPrice: totalLandPrice.replaceAll(',', ''),
            deposit: deposit.replaceAll(',', ''),
            depositChk: depositChk,
            monthly: monthly.replaceAll(',', ''),
            monthlyChk: monthlyChk,
            loan: loan,
            roomNum: roomNum.replaceAll(',', ''),
            reModel: reModel,
            bdAdditional: buildingEtc.toString().split('[')[1].split(']')[0]),
        rentrollList,
        fileList,
      );
      DealRegisterItem data = result;

      GV.pStrg.putXXX(Param_dominantlyOwnedStr, data.dominantlyOwned!.toString());
      GV.pStrg.putXXX(Param_regOrderCntStr, data.regOrder!.toString());
      if (result == null) return false;
    }

    return true;
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

  Widget textInputWidget(double width, String hint, TextEditingController controller, bool enabledBool) {
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
        keyboardType: 'text',
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: enabledBool);
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

  Widget inputWithLable(String title, String hint, TextEditingController controller, bool enabledBool) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(title),
        textInputWidget(double.infinity, hint, controller, enabledBool),
      ],
    );
  }

  Widget inputWithLable2(String title, String hint, TextEditingController controller, bool enabledBool) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        titleWidget(title),
        Container(
          width: double.infinity,
          height: 132,
          decoration: BoxDecoration(
            color: IdColors.backgroundDefault,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TextField(
              controller: controller,
              maxLength: null,
              maxLines: null,
              keyboardType: TextInputType.multiline,
              decoration: InputDecoration(border: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }

  Widget imgWithLable(int imgNumber, Function() onBtnPressed1, TextEditingController controller) {
    return SizedBox(
      width: 221,
      child: Column(
        children: [
          IdNormalBtn(
            onBtnPressed: onBtnPressed1,
            childWidget: (imgList[imgNumber - 1] != null)
                ? SizedBox(child: imgList[imgNumber - 1])
                : IdDottedBorder(
                    boxWidth: double.infinity,
                    boxHeigh: 140,
                    roundRadius: 8,
                    pattern: [4, 4],
                    boxColor: IdColors.green5,
                    borderColor: IdColors.green2,
                    childWidget: Center(
                      child: uiCommon.styledText('+ 사진 추가', 16, 0, 1, FontWeight.w600, IdColors.green2, TextAlign.left),
                    ),
                  ),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 8),
          IdInputValidation(
              width: double.infinity,
              height: 54,
              inputColor: IdColors.backgroundDefault,
              controller: controller,
              round: 8,
              textAlign: 'start',
              hintText: '사진설명을 입력할 수 있습니다.',
              hintTextFontSize: 16,
              hintTextfontWeight: FontWeight.w400,
              hintTextFontColor: IdColors.textTertiary,
              keyboardType: 'text',
              validationText: '',
              validationVisible: false,
              vlaidationCheck: false,
              enabledBool: true)
        ],
      ),
    );
  }

  Widget searchWithInput(String title, TextEditingController controller, Function() onBtnPressed) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: inputWithLable(title, '', controller, false),
        ),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        IdNormalBtn(
          onBtnPressed: onBtnPressed,
          childWidget: Container(
            width: 74,
            height: 44,
            decoration: ShapeDecoration(
              color: IdColors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(width: 1, color: IdColors.textDefault),
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Center(
              child: uiCommon.styledText('찾기', 15, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left),
            ),
          ),
        )
      ],
    );
  }

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
          width: 221,
          height: 140,
          fit: BoxFit.contain,
          alignment: Alignment.center,
        );

        showCupertinoImageCropper(context,
            imageProvider: uploadImg1!.image,
            cropPathFn: aabbCropShapeFn,
            enabledTransformations: Transformation.values,
            shouldPopAfterCrop: true,
            allowedAspectRatios: [CropAspectRatio(width: (imgNumber == 1) ? 9 : 11, height: (imgNumber == 1) ? 11 : 7)],
            postProcessFn: (result) async {
          var croppedImg1 = RawImage(image: result.uiImage);
          // var d123 = await result.uiImage.toByteData(); //(format: ui.ImageByteFormat.png);
          var toJpg = await uiCommon.convertImageToJpg(result.uiImage);
          // var d123 = await result.uiImage.toByteData(); //(format: ui.ImageByteFormat.png);

          // d123!.buffer.asUint8List();

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

  Future<bool> imgFetchData(Uint8List imgData, String userNo1, String fileName, String fileOrder, String dealNo1) async {
    final result = await IdApi.uploadTempFile(imgData, userNo1, fileName, fileOrder, dealNo1);
    if (result == null) return false;
    return true;
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
                                height: (dealType == 'L') ? 1922 : 2258,
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
                                                uiCommon.styledText('<fb2>Step 4.</fb2> 제안할 부동산의 거래 정보를 입력하세요.', 32, 0, 1.3,
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
                                                inputWithLable('<fb2>*</fb2> Deal 제목', '', _dealTitleController, true),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('위치 특이사항'),
                                                    Row(
                                                      children: List.generate(
                                                          areaList.length,
                                                          (index) => checkboxWithLable(() {
                                                                if (areaNumList[index] == 0) {
                                                                  areaNumList[index] = 1;
                                                                } else {
                                                                  areaNumList[index] = 0;
                                                                }
                                                                setState(() {});
                                                              }, areaNumList[index], areaList[index])),
                                                    )
                                                  ],
                                                ),
                                                Visibility(
                                                  visible: (dealType == 'B') ? true : false,
                                                  child: Column(
                                                    children: [
                                                      const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          titleWidget('물건 특이사항'),
                                                          Row(
                                                            children: List.generate(
                                                                buildingList.length,
                                                                (index) => checkboxWithLable(() {
                                                                      if (buildingNumList[index] == 0) {
                                                                        buildingNumList[index] = 1;
                                                                      } else {
                                                                        buildingNumList[index] = 0;
                                                                      }
                                                                      setState(() {});
                                                                    }, buildingNumList[index], buildingList[index])),
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                inputWithLable2('기타 특이사항', '', _otherSpecialInfoController, true),

                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('<fb2>*</fb2> 대표사진'),
                                                    imgWithLable(1, () {
                                                      cropFile(1);
                                                    }, _img1DescController),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                //사진 관련 사항
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('외관 사진'),
                                                    //첫 번째 줄
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            imgWithLable(2, () {
                                                              cropFile(2);
                                                            }, _img2DescController),
                                                            const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                                            imgWithLable(
                                                                3,
                                                                (imgList[1] != null)
                                                                    ? () {
                                                                        cropFile(3);
                                                                      }
                                                                    : () {
                                                                        activeToast('첫번째 외각 사진을 등록해 주세요.');
                                                                      },
                                                                _img3DescController),
                                                            const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                                            imgWithLable(
                                                                4,
                                                                (imgList[1] != null)
                                                                    ? (imgList[2] != null)
                                                                        ? () {
                                                                            cropFile(4);
                                                                          }
                                                                        : () {
                                                                            activeToast('두번째 외관 사진을 등록해 주세요.');
                                                                          }
                                                                    : () {
                                                                        activeToast('첫번째 외관 사진을 등록해 주세요.');
                                                                      },
                                                                _img4DescController),
                                                          ],
                                                        ),
                                                        const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                      ],
                                                    ),
                                                    //두 번째 줄
                                                    titleWidget('내부 사진'),
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            imgWithLable(5, () {
                                                              cropFile(5);
                                                            }, _img5DescController),
                                                            const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                                            imgWithLable(
                                                                6,
                                                                (imgList[4] != null)
                                                                    ? () {
                                                                        cropFile(6);
                                                                      }
                                                                    : () {
                                                                        activeToast('첫번째 내부 사진을 등록해 주세요.');
                                                                      },
                                                                _img6DescController),
                                                            const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                                            imgWithLable(
                                                                7,
                                                                (imgList[4] != null)
                                                                    ? (imgList[5] != null)
                                                                        ? () {
                                                                            cropFile(7);
                                                                          }
                                                                        : () {
                                                                            activeToast('두번째 내부 사진을 등록해 주세요.');
                                                                          }
                                                                    : () {
                                                                        activeToast('첫번째 내부 사진을 등록해 주세요.');
                                                                      },
                                                                _img7DescController),
                                                          ],
                                                        ),
                                                        const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                      ],
                                                    ),
                                                    //세 번째 줄
                                                    Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            imgWithLable(
                                                                8,
                                                                (imgList[4] != null)
                                                                    ? (imgList[5] != null)
                                                                        ? (imgList[6] != null)
                                                                            ? () {
                                                                                cropFile(8);
                                                                              }
                                                                            : () {
                                                                                activeToast('세번째 내부 사진을 등록해 주세요.');
                                                                              }
                                                                        : () {
                                                                            activeToast('두번째 내부 사진을 등록해 주세요.');
                                                                          }
                                                                    : () {
                                                                        activeToast('첫번째 내부 사진을 등록해 주세요.');
                                                                      },
                                                                _img8DescController),
                                                            const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                                            imgWithLable(
                                                                9,
                                                                (imgList[4] != null)
                                                                    ? (imgList[5] != null)
                                                                        ? (imgList[6] != null)
                                                                            ? (imgList[7] != null)
                                                                                ? () {
                                                                                    cropFile(9);
                                                                                  }
                                                                                : () {
                                                                                    activeToast('네번째 내부 사진을 등록해 주세요.');
                                                                                  }
                                                                            : () {
                                                                                activeToast('세번째 내부 사진을 등록해 주세요.');
                                                                              }
                                                                        : () {
                                                                            activeToast('두번째 내부 사진을 등록해 주세요.');
                                                                          }
                                                                    : () {
                                                                        activeToast('첫번째 내부 사진을 등록해 주세요.');
                                                                      },
                                                                _img9DescController),
                                                            const IdSpace(spaceWidth: 12, spaceHeight: 0),
                                                            imgWithLable(
                                                                10,
                                                                (imgList[4] != null)
                                                                    ? (imgList[5] != null)
                                                                        ? (imgList[6] != null)
                                                                            ? (imgList[7] != null)
                                                                                ? (imgList[8] != null)
                                                                                    ? () {
                                                                                        cropFile(10);
                                                                                      }
                                                                                    : () {
                                                                                        activeToast('다섯번째 내부 사진을 등록해 주세요.');
                                                                                      }
                                                                                : () {
                                                                                    activeToast('네번째 내부 사진을 등록해 주세요.');
                                                                                  }
                                                                            : () {
                                                                                activeToast('세번째 내부 사진을 등록해 주세요.');
                                                                              }
                                                                        : () {
                                                                            activeToast('두번째 내부 사진을 등록해 주세요.');
                                                                          }
                                                                    : () {
                                                                        activeToast('첫번째 내부 사진을 등록해 주세요.');
                                                                      },
                                                                _img10DescController),
                                                          ],
                                                        ),
                                                        const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                      ],
                                                    ),
                                                    //주의 사항
                                                    Container(
                                                      width: double.infinity,
                                                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                                                      decoration: ShapeDecoration(
                                                        color: IdColors.warning,
                                                        shape: RoundedRectangleBorder(
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                      ),
                                                      child: Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          const Padding(
                                                            padding: EdgeInsets.only(top: 6),
                                                            child: IdImageBox(
                                                                imagePath: 'assets/img/icon_warning.png',
                                                                imageWidth: 16,
                                                                imageHeight: 16,
                                                                imageFit: BoxFit.cover),
                                                          ),
                                                          const SizedBox(width: 8),
                                                          Expanded(
                                                            child: SizedBox(
                                                              child: uiCommon.styledText(
                                                                  '<warning>사진 등록시 주의 사항</warning>\n최대 10장의 사진을 등록할 수 있습니다. (사진 1장당 10MB 이내로 등록하셔야 합니다.)',
                                                                  15,
                                                                  -0.30,
                                                                  1.6,
                                                                  FontWeight.w400,
                                                                  IdColors.textDefault,
                                                                  TextAlign.left),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                                                Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    titleWidget('기타 자료등록'),
                                                    searchWithInput(
                                                      'TM자료',
                                                      _TM_InfoController,
                                                      () {
                                                        otherUploadFile(11);
                                                      },
                                                    ),
                                                    const IdSpace(spaceWidth: 0, spaceHeight: 10),
                                                    searchWithInput('도면', _floorPlanController, () {
                                                      otherUploadFile(12);
                                                    }),
                                                    const IdSpace(spaceWidth: 0, spaceHeight: 10),
                                                    searchWithInput('기타', _otherController, () {
                                                      otherUploadFile(13);
                                                    }),
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                                IdDealRegistBottomBtn(
                                                  beforeBtnFunction: () {
                                                    if (dealType == 'L') {
                                                      uiCommon.IdMovePage(context, PAGE_DEAL_STEP_03_1_PAGE);
                                                    } else {
                                                      uiCommon.IdMovePage(context, PAGE_DEAL_STEP_03_2_PAGE);
                                                    }
                                                  },
                                                  btn1: '이전',
                                                  afterBtnFunction: () async {
                                                    if (_dealTitleController.text.isEmpty) {
                                                      activeToast('제목을 입력해 주세요.');
                                                    } else {
                                                      if (imgList[0] == null) {
                                                        activeToast('메인 사진을 등록해 주세요.');
                                                      } else {
                                                        if (imgList[0] != null && textControllerList[0].text == '') {
                                                          activeToast('메인 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[1] != null && textControllerList[1].text == '') {
                                                          activeToast('외관 첫번째 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[2] != null && textControllerList[2].text == '') {
                                                          activeToast('외관 두번째 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[3] != null && textControllerList[3].text == '') {
                                                          activeToast('외관 마지막 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[4] != null && textControllerList[4].text == '') {
                                                          activeToast('내부 첫번째 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[5] != null && textControllerList[5].text == '') {
                                                          activeToast('내부 두번째 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[6] != null && textControllerList[6].text == '') {
                                                          activeToast('내부 세번째 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[7] != null && textControllerList[7].text == '') {
                                                          activeToast('내부 네번째 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[8] != null && textControllerList[8].text == '') {
                                                          activeToast('내부 다섯번째 사진의 설명을 등록해 주세요.');
                                                        } else if (imgList[9] != null && textControllerList[9].text == '') {
                                                          activeToast('내부 여섯번째 사진의 설명을 등록해 주세요.');
                                                        } else {
                                                          if (await setDeal()) {
                                                            GV.pStrg.putXXX('dealMasterJson', '');
                                                            GV.pStrg.putXXX('dealNewBuildingJson', '');
                                                            GV.pStrg.putXXX('dealLotJson', '');
                                                            GV.pStrg.putXXX('dealBuildingJson', '');
                                                            GV.pStrg.putXXX('dealRentRollJson', '');
                                                            uiCommon.IdMovePage(context, PAGE_DEAL_STEP_04_2_PAGE);
                                                          } else {
                                                            print('disable move Page');
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
