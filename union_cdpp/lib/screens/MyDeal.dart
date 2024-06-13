import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdBoardCnt.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDivider.dart';
import 'package:unionCDPP/id_widget/IdGrid.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNoneData.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageTopSection.dart';
import 'package:unionCDPP/id_widget/IdPagination.dart';
import 'package:unionCDPP/id_widget/IdPjtListDropdown.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdStatus.dart';
import 'package:unionCDPP/id_widget/IdSubNavigator.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:unionCDPP/modelVO/myDealResponse.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';
import 'package:unionCDPP/modelVO/searchiInfoItem.dart';
import 'package:unionCDPP/popup/myDealStatusPopup.dart';
import 'package:hovering/hovering.dart';

class _DealList {
  MyDealResponse? data;
}

class MyDeal extends StatefulWidget {
  const MyDeal({super.key});

  @override
  IdState<MyDeal> createState() => _MyDealState();
}

class _MyDealState extends IdState<MyDeal> {
  List<List<String>> _mydealSvcDS = [];
  List<_DealList> _mydealDs = [];

  String userNo = GV.pStrg.getXXX(Param_commonUserNo);

  int totalRowsCnt = 0;
  int currentRowsCnt = 0;

  int totalPage = 0;
  int acturalPage = 1;

  int rowSize = 0;

  List menuNavigator = [];
  List menuNavigatorLink = [];
  List submenuNameList = [];
  List submenuNavigatorLink = [];

  String searchType = '';
  String searchVal = '';

  List seqList = [];
  List dealtypeList = [];
  List dealAddressList = [];
  List dealpjtList = [];
  List dealpjtColorList = [];
  List dealImgList = [];
  List dealUpdateList = [];
  List dealStatus1List = [];
  List dealStatus2List = [];
  List dealStatus3List = [];
  List dealPriceList = [];
  List dealTitleList = [];
  List dealTotalFloorAreaList = [];
  List dealTotalFloorAreaPyList = [];
  List dealLandAreaList = [];
  List dealLandAreaPyList = [];
  List dealCreateList = [];

  List<String> searchCategori1List = [];
  List<String> searchCategori2List = [];

  //상단 드롭다운 열고 닫는 bool
  bool categori1 = false;
  bool categori2 = false;
  bool categori3 = false;
  bool categori4 = false;
  bool categori5 = false;

  //상단 드롭다운 내부 체크 bool
  bool categori1_01 = false;
  bool categori1_02 = false;
  bool categori1_03 = false;
  bool categori1_04 = false;
  bool categori1_05 = false;
  bool categori1_06 = false;
  bool categori1_07 = false;
  bool categori1_08 = false;

  bool categori2_01 = false;
  bool categori2_02 = false;
  bool categori2_03 = false;
  bool categori2_04 = false;
  bool categori2_05 = false;
  bool categori2_06 = false;
  bool categori2_07 = false;
  bool categori2_08 = false;

  TextEditingController _priceText1Controller = TextEditingController();
  TextEditingController _priceText2Controller = TextEditingController();
  TextEditingController _landPyText1Controller = TextEditingController();
  TextEditingController _landPyText2Controller = TextEditingController();
  TextEditingController _totalFloorPyText1Controller = TextEditingController();
  TextEditingController _totalFloorPyText2Controller = TextEditingController();
  TextEditingController _searchValueController = TextEditingController();

  List pjtDataList = [];

  bool apiData = true;

  double dropDownValue = 5;

  bool popupVisible = false;
  String dealStatus = '';
  String dealStatusComent = '';

  DateTime today = DateTime.now();

  var _focusDropDown1 = FocusNode();
  bool changeDropdown1 = false;
  List<DropdownMenuItem> _items1 = [];

  var _focusDropDown2 = FocusNode();
  bool changeDropdown2 = false;
  List<DropdownMenuItem> _items2 = [];

  List<String> labelList = [];
  List<String> labelColorList = [];

  @override
  void initState() {
    super.initState();
    _mydealDs.add(_DealList());
    rowSize = 5;
    menuNavigator = ['home', 'My Page', '내가 등록한 딜'];
    menuNavigatorLink = [
      () {
        uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
      },
      () {
        uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
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
    itemList();
    fetchData();
  }

  void itemList() {
    _items1 = [
      const DropdownMenuItem(
        value: 5,
        child: Text('5개씩 보기', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 10,
        child: Text('10개씩 보기', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 20,
        child: Text('20개씩 보기', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
    _items2 = [
      const DropdownMenuItem(
        value: '',
        child: Text('전체', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'address',
        child: Text('주소', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'title',
        child: Text('제목', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
  }

  Future<void> fetchData() async {
    categori1 = false;
    categori2 = false;
    categori3 = false;
    categori4 = false;
    categori5 = false;
    searchCategori1List = [];
    searchCategori2List = [];
    //물건분류
    if (categori1_01) {
      searchCategori1List.add('BD');
    }
    if (categori1_02) {
      searchCategori1List.add('LAND');
    }
    if (categori1_03) {
      searchCategori1List.add('NORMAL');
    }
    if (categori1_04) {
      searchCategori1List.add('DOMI');
    }
    if (categori1_05) {
      searchCategori1List.add('PROGRESS');
    }
    if (categori1_06) {
      searchCategori1List.add('END');
    }
    if (categori1_07) {
      searchCategori1List.add('MATCH');
    }
    if (categori1_08) {
      searchCategori1List.add('NOT_MATCH');
    }

    //소재지
    if (categori2_01) {
      searchCategori2List.add('GSSG');
    }
    if (categori2_02) {
      searchCategori2List.add('MUS');
    }
    if (categori2_03) {
      searchCategori2List.add('JJD');
    }
    if (categori2_04) {
      searchCategori2List.add('JGND');
    }
    if (categori2_05) {
      searchCategori2List.add('DKY');
    }
    if (categori2_06) {
      searchCategori2List.add('SSGY');
    }
    if (categori2_07) {
      searchCategori2List.add('GGGY');
    }
    if (categori2_08) {
      searchCategori2List.add('NONE_S');
    }

    final MyDealResponse? ret1 = await IdApi.getMydael(
        userNo,
        SearchOptionItme(rowSize: rowSize, page: acturalPage, searchType: searchType, searchVal: _searchValueController.text),
        SearchInfoItem(
            startPrice: _priceText1Controller.text,
            endPrice: _priceText2Controller.text,
            searchLocationTypeList: searchCategori2List,
            filterTypeList: searchCategori1List,
            startFloorPy: _totalFloorPyText1Controller.text,
            endFloorPy: _totalFloorPyText2Controller.text,
            startLotPy: _landPyText1Controller.text,
            endLotPy: _landPyText2Controller.text));

    if (ret1 != null) {
      _mydealDs[0].data = ret1;
      totalRowsCnt = _mydealDs[0].data!.commonInfo!['totalCnt'];
      if (totalRowsCnt % rowSize == 0) {
        totalPage = int.tryParse((totalRowsCnt / rowSize).toString()) ?? 1;
      } else {
        totalPage = (int.tryParse((totalRowsCnt / rowSize).toString().split('.')[0]) ?? 1) + 1;
      }
    } else {
      _mydealDs[0].data = MyDealResponse(list: [], commonInfo: {});
    }
    setState(() {});
  }

  List<List<String>> makeRows() {
    List<List<String>> results = [];
    seqList = [];
    dealtypeList = [];
    dealTitleList = [];
    dealpjtList = [];
    dealpjtColorList = [];
    dealImgList = [];
    dealUpdateList = [];
    dealStatus1List = [];
    dealStatus2List = [];
    dealStatus3List = [];
    dealAddressList = [];
    dealPriceList = [];
    dealTotalFloorAreaList = [];
    dealTotalFloorAreaPyList = [];
    dealLandAreaList = [];
    dealLandAreaPyList = [];
    dealCreateList = [];
    currentRowsCnt = 0;
    labelList = [];
    labelColorList = [];
    for (var i = 0; i < _mydealDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _mydealDs[0].data!.list![i];
      setState(() {
        seqList.add(item1.dealNo);
        if (item1.type == 'L') {
          dealtypeList.add('토지');
        } else {
          dealtypeList.add('건물');
        }
        if (item1.title == '') {
          dealTitleList.add('');
        } else {
          dealTitleList.add(item1.title);
        }
        if (item1.s3FileUrl == null) {
          dealImgList.add('');
        } else {
          dealImgList.add('${item1.s3FileUrl}');
        }
        List<String> labelList = [];
        List<String> labelColorList = [];
        if (item1.labelList != null) {
          for (var i = 0; i < item1.labelList!.length; i++) {
            labelList.add(item1.labelList![i].label!);
            labelColorList.add(item1.labelList![i].labelColor!);
          }
          dealpjtList.add(labelList);
          dealpjtColorList.add(labelColorList);
        } else {
          labelList = [];
          labelColorList = [];
        }
        DateTime updateTime = DateTime.tryParse(item1.updateDate!) ?? today;
        DateTime towDayAfter = updateTime.add(Duration(days: 2));
        if (item1.updateDate == null) {
          dealUpdateList.add('');
        } else {
          if (DateTime.now().isBefore(towDayAfter)) {
            dealUpdateList.add('Update');
          } else {
            dealUpdateList.add('');
          }
        }
        dealStatus1List.add(item1.gubun);
        if (item1.dealStatus == '1') {
          dealStatus2List.add('거래중');
        } else if (item1.dealStatus == '2') {
          dealStatus2List.add('거래완료');
        } else {
          dealStatus2List.add('보류');
        }
        dealStatus3List.add(item1.statusNm);
        dealAddressList.add('${item1.address} ${item1.addressDtl}');
        if (item1.asking == null || item1.asking == '') {
          dealPriceList.add('0');
        } else {
          dealPriceList.add(((double.tryParse(item1.asking!) ?? 0) / 100000000).toStringAsFixed(2));
        }
        if (item1.type == 'L') {
          if (item1.landTotalFloorArea == null) {
            dealTotalFloorAreaList.add('0');
          } else {
            dealTotalFloorAreaList.add(item1.landTotalFloorArea);
          }
          if (item1.landTotalFloorAreaPy == null) {
            dealTotalFloorAreaPyList.add('0');
          } else {
            dealTotalFloorAreaPyList.add(item1.landTotalFloorAreaPy);
          }
        } else {
          if (item1.bdTotalFloorArea == null) {
            dealTotalFloorAreaList.add('0');
          } else {
            dealTotalFloorAreaList.add(item1.bdTotalFloorArea);
          }
          if (item1.bdTotalFloorAreaPy == null) {
            dealTotalFloorAreaPyList.add('0');
          } else {
            dealTotalFloorAreaPyList.add(item1.bdTotalFloorAreaPy);
          }
        }
        if (item1.type == 'L') {
          if (item1.landLotArea == null) {
            dealLandAreaList.add('0');
          } else {
            dealLandAreaList.add(item1.landLotArea);
          }
          if (item1.landLotAreaPy == null) {
            dealLandAreaPyList.add('0');
          } else {
            dealLandAreaPyList.add(item1.landLotAreaPy);
          }
        } else {
          if (item1.bdLotArea == null) {
            dealLandAreaList.add('0');
          } else {
            dealLandAreaList.add(item1.bdLotArea);
          }
          if (item1.bdLotAreaPy == null) {
            dealLandAreaPyList.add('0');
          } else {
            dealLandAreaPyList.add(item1.bdLotAreaPy);
          }
        }
        if (item1.createDate == '') {
          dealCreateList.add(item1.createDate);
        } else {
          dealCreateList.add(item1.createDate);
        }
      });
      row1.add(i.toString());
      results.add(row1);
    }
    currentRowsCnt = results.length;
    return results;
  }

  Widget dropDown1(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown) {
    return SizedBox(
      width: 131,
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
          rowSize = value;
          setState(() {});
          focusDropDown.unfocus();
          fetchData();
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
          offset: const Offset(0, -12),
          decoration: BoxDecoration(
            border: Border.all(color: IdColors.white, width: 0.9),
            borderRadius: BorderRadius.circular(4.0),
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

  Widget dropDown2(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown) {
    return Container(
      width: 112,
      height: 44,
      padding: EdgeInsets.symmetric(vertical: 9),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: IdColors.borderDefault,
        ),
        borderRadius: BorderRadius.circular(40),
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
          searchType = value;
          if (searchType == '') {
            _searchValueController.text = '';
          }
          setState(() {});
          focusDropDown.unfocus();
        },
        onSaved: (value) {},
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(top: 4, right: 8),
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

  Widget topDropDownBtn(Function() onPresedBtn, Widget childWidget, Color btnColor, Color borderColor) {
    return GestureDetector(
      onTap: onPresedBtn,
      child: Container(
        height: 44,
        padding: const EdgeInsets.only(left: 16, right: 8),
        decoration: BoxDecoration(
          color: btnColor,
          border: Border.all(width: 1, color: borderColor),
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            childWidget,
            const IdSpace(spaceWidth: 16, spaceHeight: 0),
            const IdImageBox(imagePath: 'assets/img/icon_dropdown.png', imageWidth: 18, imageHeight: 18, imageFit: BoxFit.cover)
          ],
        ),
      ),
    );
  }

  Widget dropDownCheck(Function() onPressedBtn, bool checkBool, String lable, double lableWidth) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          IdNormalBtn(
              onBtnPressed: onPressedBtn,
              childWidget: IdImageBox(
                  imagePath: checkBool ? 'assets/img/icon_checkBox_green.png' : 'assets/img/icon_checkBox_none.png',
                  imageHeight: 20,
                  imageWidth: 20,
                  imageFit: BoxFit.cover)),
          const SizedBox(width: 8),
          SizedBox(
            width: lableWidth,
            child: uiCommon.styledText(lable, 14, 0, 1, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          ),
        ],
      ),
    );
  }

  Widget sizedWithPyong(String title, double areaSize, double areaSizePy) {
    return Row(
      children: [
        uiCommon.styledText(title, 18, 0, 1, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        Row(
          children: [
            uiCommon.styledText(
                '${NumberFormat('#,##0.00').format(areaSizePy)}py', 18, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
            uiCommon.styledText(
                '(${NumberFormat('#,##0.00').format(areaSize)}㎡)', 18, 0, 1, FontWeight.w500, IdColors.textSecondly, TextAlign.left),
          ],
        ),
      ],
    );
  }

  Widget boardContent(
    String imgPath,
    String type,
    String address,
    List pjtDataList,
    List pjtDataColorList,
    String update,
    String status1,
    String status2,
    String status3,
    String title,
    double price,
    double totalArea,
    double totalAreaPy,
    double landArea,
    double landAreaPy,
    String cerateDateTime,
  ) {
    return Stack(
      children: [
        HoverWidget(
          onHover: (event) {},
          hoverChild: Container(
            width: 1222,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            decoration: ShapeDecoration(
              color: IdColors.green5,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 2,
                  // color: IdColors.green2,
                  color: IdColors.green5,
                ),
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
            child: Row(
              children: [
                //건물 이미지
                Container(
                  width: 184,
                  height: 146,
                  decoration: ShapeDecoration(
                    color: IdColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 184,
                        height: 146,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imgPath),
                            fit: BoxFit.fitHeight,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Visibility(
                        visible: (status1 == '2') ? true : false,
                        child: const Positioned(
                            child: IdImageBox(
                                imagePath: 'assets/img/icon_shild_ribon.png', imageWidth: 46, imageHeight: 46, imageFit: BoxFit.cover)),
                      )
                    ],
                  ),
                ),
                const IdSpace(spaceWidth: 32, spaceHeight: 0),
                //내용
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IdImageBox(
                                imagePath: (type == '토지') ? 'assets/img/icon_mydeal_01.png' : 'assets/img/icon_mydeal_02.png',
                                imageWidth: 24,
                                imageHeight: 24,
                                imageFit: BoxFit.cover),
                            const IdSpace(spaceWidth: 6, spaceHeight: 0),
                            uiCommon.styledText(type, 16, 0, 1, FontWeight.w500, IdColors.textSecondly, TextAlign.left),
                            const IdSpace(spaceWidth: 16, spaceHeight: 0),
                          ],
                        ),
                        const IdSpace(spaceWidth: 0, spaceHeight: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  uiCommon.styledText(address, 20, 0, 1.6, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                                  const SizedBox(width: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: uiCommon.styledText(update, 14, 0, 1, FontWeight.w900, IdColors.orange1, TextAlign.left),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IdStatus(status: status2),
                                const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                (status3 == '딜작성')
                                    ? SizedBox()
                                    : IdNormalBtn(
                                        onBtnPressed: () {
                                          popupVisible = true;
                                          dealStatus = status3;
                                          setState(() {});
                                        },
                                        childWidget: IdStatus(status: status3),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const IdSpace(spaceWidth: 0, spaceHeight: 12),
                        Row(
                          children: [
                            Expanded(child: uiCommon.styledText(title, 18, 0, 1, FontWeight.w400, IdColors.textSecondly, TextAlign.left)),
                            Row(
                              children: [
                                uiCommon.styledText('금액', 16, 0, 1, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                (price.toString().contains('.'))
                                    ? Row(
                                        children: [
                                          uiCommon.styledText(
                                              NumberFormat('#,###').format(double.tryParse(price.toString().split('.')[0]) ?? 0),
                                              24,
                                              0,
                                              1,
                                              FontWeight.w600,
                                              IdColors.textDefault,
                                              TextAlign.left),
                                          uiCommon.styledText('.' + price.toString().split('.')[1], 20, 0, 1, FontWeight.w600,
                                              IdColors.textDefault, TextAlign.left),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          uiCommon.styledText(NumberFormat('#,###').format(price), 24, 0, 1, FontWeight.w600,
                                              IdColors.textDefault, TextAlign.left),
                                          uiCommon.styledText('.00', 20, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                        ],
                                      ),
                                uiCommon.styledText('억원', 18, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  sizedWithPyong('연면적', totalArea, totalAreaPy),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 9.5),
                                    child: IdDivider(),
                                  ),
                                  sizedWithPyong('대지면적', landArea, landAreaPy),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                uiCommon.styledText('등록일', 16, 0, 1.6, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                uiCommon.styledText(cerateDateTime, 16, 0, 1.6, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          child: Container(
            width: 1222,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 40),
            decoration: ShapeDecoration(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                side: const BorderSide(
                  width: 2,
                  // color: IdColors.green2,
                  color: IdColors.white,
                ),
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
            child: Row(
              children: [
                //건물 이미지
                Container(
                  width: 184,
                  height: 146,
                  decoration: ShapeDecoration(
                    color: IdColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Stack(
                    children: [
                      Container(
                        width: 184,
                        height: 146,
                        decoration: ShapeDecoration(
                          image: DecorationImage(
                            image: NetworkImage(imgPath),
                            fit: BoxFit.fitHeight,
                          ),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                      ),
                      Visibility(
                        visible: (status1 == '2') ? true : false,
                        child: const Positioned(
                            child: IdImageBox(
                                imagePath: 'assets/img/icon_shild_ribon.png', imageWidth: 46, imageHeight: 46, imageFit: BoxFit.cover)),
                      )
                    ],
                  ),
                ),
                const IdSpace(spaceWidth: 32, spaceHeight: 0),
                //내용
                Expanded(
                  child: SizedBox(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            IdImageBox(
                                imagePath: (type == '토지') ? 'assets/img/icon_mydeal_01.png' : 'assets/img/icon_mydeal_02.png',
                                imageWidth: 24,
                                imageHeight: 24,
                                imageFit: BoxFit.cover),
                            const IdSpace(spaceWidth: 6, spaceHeight: 0),
                            uiCommon.styledText(type, 16, 0, 1, FontWeight.w500, IdColors.textSecondly, TextAlign.left),
                            const IdSpace(spaceWidth: 16, spaceHeight: 0),
                          ],
                        ),
                        const IdSpace(spaceWidth: 0, spaceHeight: 12),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  uiCommon.styledText(address, 20, 0, 1.6, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                                  const SizedBox(width: 8),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5),
                                    child: uiCommon.styledText(update, 14, 0, 1, FontWeight.w900, IdColors.orange1, TextAlign.left),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IdStatus(status: status2),
                                const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                (status3 == '딜작성')
                                    ? SizedBox()
                                    : IdNormalBtn(
                                        onBtnPressed: () {
                                          popupVisible = true;
                                          dealStatus = status3;
                                          setState(() {});
                                        },
                                        childWidget: IdStatus(status: status3),
                                      ),
                              ],
                            ),
                          ],
                        ),
                        const IdSpace(spaceWidth: 0, spaceHeight: 12),
                        Row(
                          children: [
                            Expanded(child: uiCommon.styledText(title, 18, 0, 1, FontWeight.w400, IdColors.textSecondly, TextAlign.left)),
                            Row(
                              children: [
                                uiCommon.styledText('금액', 16, 0, 1, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                (price.toString().contains('.'))
                                    ? Row(
                                        children: [
                                          uiCommon.styledText(
                                              NumberFormat('#,###').format(double.tryParse(price.toString().split('.')[0]) ?? 0),
                                              24,
                                              0,
                                              1,
                                              FontWeight.w600,
                                              IdColors.textDefault,
                                              TextAlign.left),
                                          uiCommon.styledText('.' + price.toString().split('.')[1], 20, 0, 1, FontWeight.w600,
                                              IdColors.textDefault, TextAlign.left),
                                        ],
                                      )
                                    : Row(
                                        children: [
                                          uiCommon.styledText(NumberFormat('#,###').format(price), 24, 0, 1, FontWeight.w600,
                                              IdColors.textDefault, TextAlign.left),
                                          uiCommon.styledText('.00', 20, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                        ],
                                      ),
                                uiCommon.styledText('억원', 18, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                              ],
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Row(
                                children: [
                                  sizedWithPyong('연면적', totalArea, totalAreaPy),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 9.5),
                                    child: IdDivider(),
                                  ),
                                  sizedWithPyong('대지면적', landArea, landAreaPy),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                uiCommon.styledText('등록일', 16, 0, 1.6, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                uiCommon.styledText(cerateDateTime, 16, 0, 1.6, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        Positioned(
          top: 40,
          left: 322,
          child: Container(
            child: Row(
              children: [
                IdPjtDropdown(pjtDataList: pjtDataList, pjtDataColorList: pjtDataColorList, pageName: 'MyDeal'),
              ],
            ),
          ),
        )
      ],
    );
  }

  @override
  Widget idBuild(BuildContext context) {
    if (_mydealDs[0].data == null) {
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
    _mydealSvcDS = makeRows();

    var pages = _mydealSvcDS.isNotEmpty
        ? IdPaginationWidget(
            buttonColor: Color.fromRGBO(0, 0, 0, 0),
            buttonTextColor: IdColors.black,
            buttonFontSize: 18,
            actualPage: acturalPage,
            countToDisplay: 10,
            totalPages: totalPage,
            onPageChange: (page) async {
              acturalPage = page;
              fetchData();
            },
            moveToBefore: (page) async {
              // ignore: unnecessary_statements
              acturalPage - 1;
              fetchData();
            },
            moveToNext: (page) async {
              // ignore: unnecessary_statements
              acturalPage + 1;
              fetchData();
            },
          )
        : const SizedBox();

    Widget boardGrid123 = _mydealSvcDS.isNotEmpty
        ? IdGrid(
            width: 1224,
            internalGrid: false,
            headerColumns: const [''],
            columnWidthsPercentages: const <double>[100],
            headerBorderColor: IdColors.borderDefault,
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 0,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 0,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 263,
            rowCnt: double.tryParse(currentRowsCnt.toString()) ?? 0,
            headerBodyInterval: 0,
            rowDecoration: const BoxDecoration(),
            rowInterval: 0,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowColor: IdColors.borderDefault,
            rowsCellRenderer: (row, cell, content) {
              return SizedBox(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 24),
                  child: Row(
                    children: [
                      boardContent(
                          dealImgList[int.tryParse(content) ?? 0],
                          dealtypeList[int.tryParse(content) ?? 0],
                          dealAddressList[int.tryParse(content) ?? 0],
                          dealpjtList[int.tryParse(content) ?? 0],
                          dealpjtColorList[int.tryParse(content) ?? 0],
                          dealUpdateList[int.tryParse(content) ?? 0],
                          dealStatus1List[int.tryParse(content) ?? 0],
                          dealStatus2List[int.tryParse(content) ?? 0],
                          dealStatus3List[int.tryParse(content) ?? 0],
                          dealTitleList[int.tryParse(content) ?? 0],
                          double.tryParse(dealPriceList[int.tryParse(content) ?? 0]) ?? 0,
                          double.tryParse(dealTotalFloorAreaList[int.tryParse(content) ?? 0]) ?? 0,
                          double.tryParse(dealTotalFloorAreaPyList[int.tryParse(content) ?? 0]) ?? 0,
                          double.tryParse(dealLandAreaList[int.tryParse(content) ?? 0]) ?? 0,
                          double.tryParse(dealLandAreaPyList[int.tryParse(content) ?? 0]) ?? 0,
                          dealCreateList[int.tryParse(content) ?? 0]),
                    ],
                  ),
                ),
              );
            },
            noContentWidget: const SizedBox(),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              GV.pStrg.putXXX(Param_myDealNo, _mydealDs[0].data!.list![index].dealNo.toString());
              GV.pStrg.putXXX(Param_dealType, _mydealDs[0].data!.list![index].type!);
              // print(seqList);
              // print(dealtypeList);
              // print(GV.pStrg.getXXX(myDealNo));
              // print(GV.pStrg.getXXX(dealType));
              uiCommon.IdMovePage(context, PAGE_MYDEAL_DETAIL_PAGE);
              setState(() {});
            },
            data: _mydealSvcDS)
        :
        //데이터 없을때
        Container(
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
                    Stack(
                      children: [
                        Container(
                          width: double.infinity,
                          color: IdColors.white,
                          child: Column(
                            children: [
                              (apiData)
                                  ? Stack(
                                      children: [
                                        GestureDetector(
                                          // onTap: () {
                                          //   categori1 = false;
                                          //   categori2 = false;
                                          //   categori3 = false;
                                          //   setState(() {});
                                          // },
                                          child: Container(
                                            constraints: const BoxConstraints(maxWidth: 1224),
                                            child: Column(
                                              children: [
                                                const IdSpace(spaceWidth: 0, spaceHeight: 176),
                                                //보드 CNT
                                                Stack(
                                                  children: [
                                                    const SizedBox(
                                                      width: double.infinity,
                                                      height: 26,
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      left: 0,
                                                      child: Row(
                                                        children: [
                                                          IdBoardCnt(currentCnt: currentRowsCnt, totalCnt: totalRowsCnt),
                                                          const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                          const IdDivider(),
                                                          dropDown1(_focusDropDown1, '5개씩 보기', _items1, changeDropdown1)
                                                        ],
                                                      ),
                                                    ),
                                                    Positioned(
                                                      bottom: 0,
                                                      right: 0,
                                                      child: uiCommon.styledText(
                                                          '단위 : 억원', 16, 0.14, 1.6, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                                                    )
                                                  ],
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 32),
                                                SizedBox(
                                                  width: double.infinity,
                                                  child: boardGrid123,
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 32),
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
                                                const IdSpace(spaceWidth: 0, spaceHeight: 158),
                                              ],
                                            ),
                                          ),
                                        ),
                                        //상단 board 검색
                                        Positioned(
                                          top: 100,
                                          left: 0,
                                          right: 0,
                                          child: Stack(
                                            children: [
                                              const SizedBox(
                                                width: double.infinity,
                                                height: 224,
                                              ),
                                              //상단 왼쪽 드롭다운 3개
                                              Positioned(
                                                child: Row(
                                                  children: [
                                                    topDropDownBtn(
                                                      () {
                                                        if (categori1) {
                                                          categori1 = false;
                                                        } else {
                                                          categori1 = true;
                                                          categori2 = false;
                                                          categori3 = false;
                                                          categori4 = false;
                                                          categori5 = false;
                                                        }
                                                        setState(() {});
                                                      },
                                                      uiCommon.styledText('물건분류', 16, 0, 1, FontWeight.w500,
                                                          categori1 ? IdColors.green2 : IdColors.textDefault, TextAlign.left),
                                                      categori1 ? IdColors.green5 : IdColors.white,
                                                      categori1 ? IdColors.green2 : IdColors.borderDefault,
                                                    ),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    topDropDownBtn(
                                                      () {
                                                        if (categori2) {
                                                          categori2 = false;
                                                        } else {
                                                          categori2 = true;
                                                          categori1 = false;
                                                          categori3 = false;
                                                          categori4 = false;
                                                          categori5 = false;
                                                        }
                                                        setState(() {});
                                                      },
                                                      uiCommon.styledText('소재지', 16, 0, 1, FontWeight.w500,
                                                          categori2 ? IdColors.green2 : IdColors.textDefault, TextAlign.left),
                                                      categori2 ? IdColors.green5 : IdColors.white,
                                                      categori2 ? IdColors.green2 : IdColors.borderDefault,
                                                    ),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    topDropDownBtn(
                                                      () {
                                                        if (categori3) {
                                                          categori3 = false;
                                                        } else {
                                                          categori3 = true;
                                                          categori1 = false;
                                                          categori2 = false;
                                                          categori4 = false;
                                                          categori5 = false;
                                                        }
                                                        setState(() {});
                                                      },
                                                      uiCommon.styledText('거래금액', 16, 0, 1, FontWeight.w500,
                                                          categori3 ? IdColors.green2 : IdColors.textDefault, TextAlign.left),
                                                      categori3 ? IdColors.green5 : IdColors.white,
                                                      categori3 ? IdColors.green2 : IdColors.borderDefault,
                                                    ),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    topDropDownBtn(
                                                      () {
                                                        if (categori4) {
                                                          categori4 = false;
                                                        } else {
                                                          categori4 = true;
                                                          categori1 = false;
                                                          categori2 = false;
                                                          categori3 = false;
                                                          categori5 = false;
                                                        }
                                                        setState(() {});
                                                      },
                                                      uiCommon.styledText('연면적', 16, 0, 1, FontWeight.w500,
                                                          categori4 ? IdColors.green2 : IdColors.textDefault, TextAlign.left),
                                                      categori4 ? IdColors.green5 : IdColors.white,
                                                      categori4 ? IdColors.green2 : IdColors.borderDefault,
                                                    ),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    topDropDownBtn(
                                                      () {
                                                        if (categori5) {
                                                          categori5 = false;
                                                        } else {
                                                          categori5 = true;
                                                          categori1 = false;
                                                          categori2 = false;
                                                          categori3 = false;
                                                          categori4 = false;
                                                        }
                                                        setState(() {});
                                                      },
                                                      uiCommon.styledText('대지면적', 16, 0, 1, FontWeight.w500,
                                                          categori5 ? IdColors.green2 : IdColors.textDefault, TextAlign.left),
                                                      categori5 ? IdColors.green5 : IdColors.white,
                                                      categori5 ? IdColors.green2 : IdColors.borderDefault,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Positioned(
                                                top: 0,
                                                right: 0,
                                                child: Row(
                                                  children: [
                                                    dropDown2(_focusDropDown2, '전체', _items2, changeDropdown2),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    idSearchInputBox(searchType, _searchValueController),
                                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                    idSearchBtn(() {
                                                      fetchData();
                                                    }),
                                                  ],
                                                ),
                                              ),
                                              //카테고리1 드롭다운
                                              Visibility(
                                                visible: categori1,
                                                child: Positioned(
                                                  left: 0,
                                                  top: 56,
                                                  child: Container(
                                                    width: 228,
                                                    height: 168,
                                                    padding: const EdgeInsets.all(16),
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color: IdColors.black16Per,
                                                          blurRadius: 12,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            dropDownCheck(() {
                                                              if (categori1_01) {
                                                                categori1_01 = false;
                                                              } else {
                                                                categori1_01 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori1_01, '건물', 50),
                                                            const SizedBox(width: 8),
                                                            dropDownCheck(() {
                                                              if (categori1_02) {
                                                                categori1_02 = false;
                                                              } else {
                                                                categori1_02 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori1_02, '토지', 50),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            dropDownCheck(() {
                                                              if (categori1_03) {
                                                                categori1_03 = false;
                                                              } else {
                                                                categori1_03 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori1_03, '일반', 50),
                                                            const SizedBox(width: 8),
                                                            dropDownCheck(() {
                                                              if (categori1_04) {
                                                                categori1_04 = false;
                                                              } else {
                                                                categori1_04 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori1_04, '독점보호', 50),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            dropDownCheck(() {
                                                              if (categori1_05) {
                                                                categori1_05 = false;
                                                              } else {
                                                                categori1_05 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori1_05, '거래중', 50),
                                                            const SizedBox(width: 8),
                                                            dropDownCheck(() {
                                                              if (categori1_06) {
                                                                categori1_06 = false;
                                                              } else {
                                                                categori1_06 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori1_06, '거래완료', 50),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            dropDownCheck(() {
                                                              if (categori1_07) {
                                                                categori1_07 = false;
                                                              } else {
                                                                categori1_07 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori1_07, '매칭딜', 50),
                                                            const SizedBox(width: 8),
                                                            dropDownCheck(() {
                                                              if (categori1_08) {
                                                                categori1_08 = false;
                                                              } else {
                                                                categori1_08 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori1_08, '비대칭딜', 50),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //카테고리2 드롭다운
                                              Visibility(
                                                visible: categori2,
                                                child: Positioned(
                                                  left: 122,
                                                  top: 56,
                                                  child: Container(
                                                    width: 368,
                                                    height: 168,
                                                    padding: const EdgeInsets.all(16),
                                                    decoration: ShapeDecoration(
                                                      color: Colors.white,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color: IdColors.black16Per,
                                                          blurRadius: 12,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 0,
                                                        ),
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            dropDownCheck(() {
                                                              if (categori2_01) {
                                                                categori2_01 = false;
                                                              } else {
                                                                categori2_01 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori2_01, '강남/서초/송파/강동', 120),
                                                            const SizedBox(width: 8),
                                                            dropDownCheck(() {
                                                              if (categori2_02) {
                                                                categori2_02 = false;
                                                              } else {
                                                                categori2_02 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori2_02, '마포/은평/서대문', 120),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            dropDownCheck(() {
                                                              if (categori2_03) {
                                                                categori2_03 = false;
                                                              } else {
                                                                categori2_03 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori2_03, '중구/종로/동대문', 120),
                                                            const SizedBox(width: 8),
                                                            dropDownCheck(() {
                                                              if (categori2_04) {
                                                                categori2_04 = false;
                                                              } else {
                                                                categori2_04 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori2_04, '중랑/강북/노원/도봉', 120),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            dropDownCheck(() {
                                                              if (categori2_05) {
                                                                categori2_05 = false;
                                                              } else {
                                                                categori2_05 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori2_05, '동작/관악/영등포', 120),
                                                            const SizedBox(width: 8),
                                                            dropDownCheck(() {
                                                              if (categori2_06) {
                                                                categori2_06 = false;
                                                              } else {
                                                                categori2_06 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori2_06, '성북/성동/광진/용산', 120),
                                                          ],
                                                        ),
                                                        Row(
                                                          children: [
                                                            dropDownCheck(() {
                                                              if (categori2_07) {
                                                                categori2_07 = false;
                                                              } else {
                                                                categori2_07 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori2_07, '금천/구로/강서/양천', 120),
                                                            const SizedBox(width: 8),
                                                            dropDownCheck(() {
                                                              if (categori2_08) {
                                                                categori2_08 = false;
                                                              } else {
                                                                categori2_08 = true;
                                                              }
                                                              setState(() {});
                                                            }, categori2_08, '서울 외', 120),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //카테고리3 거래금액 드롭다운내용
                                              Visibility(
                                                visible: categori3,
                                                child: Positioned(
                                                  left: 230,
                                                  top: 56,
                                                  child: Container(
                                                    width: 351,
                                                    height: 146,
                                                    padding: const EdgeInsets.all(16),
                                                    decoration: ShapeDecoration(
                                                      color: IdColors.white,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color: IdColors.black16Per,
                                                          blurRadius: 12,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IdInputValidation(
                                                                width: 120,
                                                                height: 40,
                                                                inputColor: IdColors.lightGray2,
                                                                round: 8,
                                                                controller: _priceText1Controller,
                                                                textAlign: 'start',
                                                                hintText: '',
                                                                hintTextFontSize: 18,
                                                                hintTextfontWeight: FontWeight.w400,
                                                                hintTextFontColor: IdColors.textDefault,
                                                                keyboardType: 'text',
                                                                validationText: '',
                                                                validationVisible: false,
                                                                vlaidationCheck: false,
                                                                enabledBool: true),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                '억원', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                ' ~', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            IdInputValidation(
                                                                width: 120,
                                                                height: 40,
                                                                inputColor: IdColors.lightGray2,
                                                                round: 8,
                                                                controller: _priceText2Controller,
                                                                textAlign: 'start',
                                                                hintText: '',
                                                                hintTextFontSize: 18,
                                                                hintTextfontWeight: FontWeight.w400,
                                                                hintTextFontColor: IdColors.textDefault,
                                                                keyboardType: 'text',
                                                                validationText: '',
                                                                validationVisible: false,
                                                                vlaidationCheck: false,
                                                                enabledBool: true),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                '억원', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                          ],
                                                        ),
                                                        const IdSpace(spaceWidth: 4, spaceHeight: 32),
                                                        IdNormalBtn(
                                                          onBtnPressed: () {
                                                            fetchData();
                                                          },
                                                          childWidget: Container(
                                                            width: double.infinity,
                                                            height: 38,
                                                            decoration: ShapeDecoration(
                                                              color: IdColors.green2,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                            ),
                                                            child: Center(
                                                              child: uiCommon.styledText(
                                                                  '확인', 14, 0, 1, FontWeight.w600, IdColors.white, TextAlign.left),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //카테고리4 연면적 드롭다운내용
                                              Visibility(
                                                visible: categori4,
                                                child: Positioned(
                                                  left: 352,
                                                  top: 56,
                                                  child: Container(
                                                    width: 333,
                                                    height: 146,
                                                    padding: const EdgeInsets.all(16),
                                                    decoration: ShapeDecoration(
                                                      color: IdColors.white,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color: IdColors.black16Per,
                                                          blurRadius: 12,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IdInputValidation(
                                                                width: 120,
                                                                height: 40,
                                                                inputColor: IdColors.lightGray2,
                                                                round: 8,
                                                                controller: _totalFloorPyText1Controller,
                                                                textAlign: 'start',
                                                                hintText: '',
                                                                hintTextFontSize: 18,
                                                                hintTextfontWeight: FontWeight.w400,
                                                                hintTextFontColor: IdColors.textDefault,
                                                                keyboardType: 'text',
                                                                validationText: '',
                                                                validationVisible: false,
                                                                vlaidationCheck: false,
                                                                enabledBool: true),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                'py', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                ' ~', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            IdInputValidation(
                                                                width: 120,
                                                                height: 40,
                                                                inputColor: IdColors.lightGray2,
                                                                round: 8,
                                                                controller: _totalFloorPyText2Controller,
                                                                textAlign: 'start',
                                                                hintText: '',
                                                                hintTextFontSize: 18,
                                                                hintTextfontWeight: FontWeight.w400,
                                                                hintTextFontColor: IdColors.textDefault,
                                                                keyboardType: 'text',
                                                                validationText: '',
                                                                validationVisible: false,
                                                                vlaidationCheck: false,
                                                                enabledBool: true),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                'py', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                          ],
                                                        ),
                                                        const IdSpace(spaceWidth: 4, spaceHeight: 32),
                                                        IdNormalBtn(
                                                          onBtnPressed: () {
                                                            fetchData();
                                                          },
                                                          childWidget: Container(
                                                            width: double.infinity,
                                                            height: 38,
                                                            decoration: ShapeDecoration(
                                                              color: IdColors.green2,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                            ),
                                                            child: Center(
                                                              child: uiCommon.styledText(
                                                                  '확인', 14, 0, 1, FontWeight.w600, IdColors.white, TextAlign.left),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              //카테고리5 대지면적 드롭다운내용
                                              Visibility(
                                                visible: categori5,
                                                child: Positioned(
                                                  left: 460,
                                                  top: 56,
                                                  child: Container(
                                                    width: 333,
                                                    height: 146,
                                                    padding: const EdgeInsets.all(16),
                                                    decoration: ShapeDecoration(
                                                      color: IdColors.white,
                                                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                      shadows: const [
                                                        BoxShadow(
                                                          color: IdColors.black16Per,
                                                          blurRadius: 12,
                                                          offset: Offset(0, 0),
                                                          spreadRadius: 0,
                                                        )
                                                      ],
                                                    ),
                                                    child: Column(
                                                      children: [
                                                        Row(
                                                          children: [
                                                            IdInputValidation(
                                                                width: 120,
                                                                height: 40,
                                                                inputColor: IdColors.lightGray2,
                                                                round: 8,
                                                                controller: _landPyText1Controller,
                                                                textAlign: 'start',
                                                                hintText: '',
                                                                hintTextFontSize: 18,
                                                                hintTextfontWeight: FontWeight.w400,
                                                                hintTextFontColor: IdColors.textDefault,
                                                                keyboardType: 'text',
                                                                validationText: '',
                                                                validationVisible: false,
                                                                vlaidationCheck: false,
                                                                enabledBool: true),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                'py', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                ' ~', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            IdInputValidation(
                                                                width: 120,
                                                                height: 40,
                                                                inputColor: IdColors.lightGray2,
                                                                round: 8,
                                                                controller: _landPyText2Controller,
                                                                textAlign: 'start',
                                                                hintText: '',
                                                                hintTextFontSize: 18,
                                                                hintTextfontWeight: FontWeight.w400,
                                                                hintTextFontColor: IdColors.textDefault,
                                                                keyboardType: 'text',
                                                                validationText: '',
                                                                validationVisible: false,
                                                                vlaidationCheck: false,
                                                                enabledBool: true),
                                                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                                                            uiCommon.styledText(
                                                                'py', 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                                          ],
                                                        ),
                                                        const IdSpace(spaceWidth: 4, spaceHeight: 32),
                                                        IdNormalBtn(
                                                          onBtnPressed: () {
                                                            fetchData();
                                                          },
                                                          childWidget: Container(
                                                            width: double.infinity,
                                                            height: 38,
                                                            decoration: ShapeDecoration(
                                                              color: IdColors.green2,
                                                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                                            ),
                                                            child: Center(
                                                              child: uiCommon.styledText(
                                                                  '확인', 14, 0, 1, FontWeight.w600, IdColors.white, TextAlign.left),
                                                            ),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  :
                                  //데이터가 없을때
                                  IdNoneData(
                                      dataBoardType: 'noDataWithImg',
                                      imgPath: 'assets/img/img_deal_nodata.png',
                                      imgWidth: 200,
                                      imgHeight: 200,
                                      noDataText: '등록된 딜이 없습니다.',
                                      childWidget: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          IdNormalBtn(
                                            onBtnPressed: () {},
                                            childWidget: Container(
                                              width: 130,
                                              height: 44,
                                              decoration: BoxDecoration(
                                                color: IdColors.green2,
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: uiCommon.styledText(
                                                    '+ 딜 등록하기', 15, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    idCommonFooter()
                  ],
                ),
              ),
              //헤더
              idCommonHeader(),
              idFloatDealRegistBtn(),
              Visibility(
                visible: popupVisible,
                child: Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    height: double.infinity,
                    color: IdColors.black8Per,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MyDealStatusPopup(
                          closedOnpressed: () {
                            popupVisible = false;
                            setState(() {});
                          },
                          status: '열람',
                          coment: dealStatusComent,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
