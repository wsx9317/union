import 'dart:html';
import 'dart:html' as html;
import 'package:intl/intl.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:indexed/indexed.dart';
import 'package:union_admin/api/id_api.dart';
import 'package:union_admin/common/globalvar.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/constants/constants.dart';
import 'package:union_admin/id_widget/IdColor.dart';
import 'package:union_admin/id_widget/IdDualCalendar.dart';
import 'package:union_admin/id_widget/IdGrid.dart';
import 'package:union_admin/id_widget/IdImageBox1.dart';
import 'package:union_admin/id_widget/IdInputValidation.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';
import 'package:union_admin/id_widget/IdPagination.dart';
import 'package:union_admin/id_widget/IdSpace.dart';
import 'package:union_admin/modelVO/dealResponse.dart';
import 'package:union_admin/modelVO/search_option_item.dart';

class _DealList {
  DealResponse? data;
}

class Deal extends StatefulWidget {
  const Deal({super.key});

  @override
  State<Deal> createState() => _DealState();
}

class _DealState extends State<Deal> {
  List<List<String>> _dealSvcDS = [];
  List<_DealList> _dealDs = [];
  String userNo = GV.pStrg.getXXX('uId').isEmpty ? '1' : GV.pStrg.getXXX('uId');
  bool isCalenderShowed = false;
  DateTime? _startDate;
  DateTime? _endDate;
  String keyword = '';
  String startYear = '1000';
  String startMonth = '01';
  String startDay = '01';
  String startHour = '00';
  String startMinutes = '00';
  String startSeconds = '00';
  String endYear = '9999';
  String endMonth = '12';
  String endDay = '31';
  String endHour = '23';
  String endMinutes = '59';
  String endSeconds = '59';
  String searchType1 = '';
  String searchType2 = '';

  DateTime now = DateTime.now();

  List tapStatusList = ['독점', '일반', '전체'];
  String tapStatus = '';

  int orderType = 0;
  List<int> orderTypeList = []; //DEAL 종류, 상태, 진행단계, asking, 연면적, 독점구분

  int dealTypeOrder = 0;
  int statusOrder = 0;
  int leftDateOrder = 0;
  int dealStatusOrder = 0;
  int askingOrder = 0;
  int dealDomiOrder = 0;
  int totalLotOrder = 0;

  double webWidth = double.tryParse(GV.pStrg.getXXX(key_page_with)) ?? 1200;

  int rowSize = 20;

  int currentRowsCnt = 0;
  int totalRowsCnt = 0;
  int totalPage = 0;
  int acturalPage = 1;

  int gubun = 2;
  int rowNum = 0;

  List dealNoList = [];
  List typeList = [];
  List labelList = [];

  bool labelPopupVisible = false;

  var _focusDropDown1 = FocusNode();
  bool changeDropdown1 = false;
  List<DropdownMenuItem> _items1 = [];

  var _focusDropDown2 = FocusNode();
  bool changeDropdown2 = false;
  List<DropdownMenuItem> _items2 = [];

  List<DropdownMenuItem> _items3 = [];

  var _focusDropDown3 = FocusNode();
  bool changeDropdown3 = false;
  List<DropdownMenuItem> _items4 = [];

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dealDs.add(_DealList());
    tapStatus = tapStatusList[0];
    html.window.onResize.listen((event) {
      setState(() {
        webWidth = html.window.innerWidth!.toDouble();
      });
    });

    itemList();
    fetchData();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _startDateController.dispose();
    _endDateController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  Future<void> fetchData() async {
    String startDateStr = '';
    String endDateStr = '';

    if (_startDate.toString().split('-')[0] == '2000' || _startDate == null) {
      startDateStr = '';
    } else {
      startDateStr = _startDate.toString().split(' ')[0];
    }
    if (_endDate.toString().split('-')[0] == '2000' || _endDate == null) {
      endDateStr = '';
    } else {
      endDateStr = _endDate.toString().split(' ')[0];
    }

    final DealResponse? ret1 = await IdApi.getDealList(SearchOptionItme(
        page: acturalPage - 1,
        rowSize: rowSize,
        searchType1: searchType1,
        searchType2: searchType2,
        searchVal: _searchController.text,
        gubun: gubun.toString(),
        startDate: startDateStr,
        endDate: endDateStr,
        orderType: (orderType == 0) ? '' : orderType.toString(),
        order: (orderType == 0)
            ? '0'
            : (orderType == 1)
                ? dealTypeOrder.toString()
                : (orderType == 2)
                    ? statusOrder.toString()
                    : (orderType == 3)
                        ? dealStatusOrder.toString()
                        : (orderType == 4)
                            ? askingOrder.toString()
                            : (orderType == 5)
                                ? totalLotOrder.toString()
                                : (orderType == 6)
                                    ? dealDomiOrder.toString()
                                    : leftDateOrder.toString()));

    if (ret1 != null) {
      _dealDs[0].data = ret1;
      Map<String, dynamic> commonInfo = _dealDs[0].data!.commonInfo!;

      totalRowsCnt = commonInfo['totalCount'];

      if (totalRowsCnt > 0) {
        if (totalRowsCnt % rowSize == 0) {
          totalPage = int.tryParse((totalRowsCnt / rowSize).toString()) ?? 1;
        } else {
          totalPage = (int.tryParse((totalRowsCnt / rowSize).toString().split('.')[0]) ?? 1) + 1;
        }
      }

      orderTypeList = [1, 2, 3, 4, 5, 6, 7];

      makeRows();
    } else {
      _dealDs[0].data = DealResponse(list: [], commonInfo: {});
    }
  }

  List<List<String>> makeRows() {
    List<List<String>> results = [];
    currentRowsCnt = 0;
    dealNoList = [];
    typeList = [];
    labelList = [];
    for (var i = 0; i < _dealDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _dealDs[0].data!.list![i];
      //테이블 row 클릭시 넘길 파라미터
      dealNoList.add(item1.dealNo!);
      typeList.add(item1.type!);
      labelList.add([[]]);

      if (item1.labelList!.length > 0) {
        List labelSubList = [];
        for (var j = 0; j < item1.labelList!.length; j++) {
          labelSubList.add([item1.labelList![j].label, int.tryParse(item1.labelList![j].labelColor!) ?? 1]);
        }
        labelList[i] = labelSubList;
      }
      //테이블
      row1.add((i + 1).toString());
      if (gubun != 0) {
        row1.add(item1.address!);
        row1.add(item1.title!);
        if (item1.type == 'L') {
          row1.add('토지');
        } else {
          row1.add('건물');
        }
        row1.add(item1.userName!);
        row1.add(item1.office!);
        //TODO 잔여일
        if (gubun == 2) {
          if (item1.dayRemaining != null) {
            if (item1.dayRemaining == '-1') {
              row1.add('만료');
            } else {
              row1.add(item1.dayRemaining!);
            }
          } else {
            row1.add('');
          }
        }
        row1.add(dealStatusStr(item1.dealStatus!));
        row1.add(statusStr(item1.status!));
        if (item1.labelList!.length == 0) {
          row1.add('');
        } else {
          row1.add('${item1.labelList![0].label!}-${item1.labelList![0].labelColor!}-${item1.labelList!.length}');
        }
        row1.add(NumberFormat('#,##0.00').format((double.tryParse(item1.asking!) ?? 0) / 100000000));
        row1.add(NumberFormat('#,##0.00').format(double.tryParse(item1.totalFloorArea!) ?? 0));
      } else if (gubun == 0) {
        row1.add(item1.address!);
        row1.add(item1.title!);
        if (item1.type == 'L') {
          row1.add('토지');
        } else {
          row1.add('건물');
        }
        if (item1.gubun == '2') {
          row1.add('독점');
        } else if (item1.gubun == '1') {
          row1.add('일반');
        } else {
          row1.add('전체');
        }
        row1.add(item1.userName!);
        row1.add(item1.office!);
        //TODO 잔여일
        if (gubun == 2) {
          if (item1.dayRemaining != null) {
            if (item1.dayRemaining == '-1') {
              row1.add('만료');
            } else {
              row1.add(item1.dayRemaining!);
            }
          } else {
            row1.add('');
          }
        }
        row1.add(dealStatusStr(item1.dealStatus!));
        row1.add(statusStr(item1.status!));
        if (item1.labelList!.length == 0) {
          row1.add('');
        } else {
          row1.add('${item1.labelList![0].label!}-${item1.labelList![0].labelColor!}-${item1.labelList!.length}');
        }
        row1.add(NumberFormat('#,##0.00').format((double.tryParse(item1.asking!) ?? 0) / 100000000));
        row1.add(NumberFormat('#,##0.00').format(double.tryParse(item1.totalFloorArea!) ?? 0));
      }
      results.add(row1);
    }
    currentRowsCnt = results.length;

    setState(() {});

    return results;
  }

  Future<bool> setExcell() async {
    try {
      String startDateStr = '';
      String endDateStr = '';

      if (_startDate.toString().split('-')[0] == '2000' || _startDate == null) {
        startDateStr = '';
      } else {
        startDateStr = _startDate.toString().split(' ')[0];
      }
      if (_endDate.toString().split('-')[0] == '2000' || _endDate == null) {
        endDateStr = '';
      } else {
        endDateStr = _endDate.toString().split(' ')[0];
      }
      final result = await IdApi.setDealExcell(SearchOptionItme(
          searchType1: searchType1,
          searchType2: searchType2,
          gubun: gubun.toString(),
          searchVal: _searchController.text,
          startDate: startDateStr,
          endDate: endDateStr,
          orderType: (orderType == 0) ? '' : orderType.toString(),
          order: (orderType == 0)
              ? '0'
              : (orderType == 1)
                  ? dealTypeOrder.toString()
                  : (orderType == 2)
                      ? statusOrder.toString()
                      : (orderType == 3)
                          ? dealStatusOrder.toString()
                          : (orderType == 4)
                              ? askingOrder.toString()
                              : (orderType == 5)
                                  ? totalLotOrder.toString()
                                  : (orderType == 6)
                                      ? dealDomiOrder.toString()
                                      : leftDateOrder.toString()));
      if (result == null) return false;
      final blob = Blob([result], 'application/octet-stream');
      final url = Url.createObjectUrlFromBlob(blob);

      final anchor = AnchorElement()
        ..href = url
        ..download = (gubun == 2)
            ? '독점승인 딜 리스트.xlsx'
            : (gubun == 1)
                ? '일반 딜리스트.xlsx'
                : '전체 딜 리스트.xlsx';
      anchor.click();
      Url.revokeObjectUrl(url);
    } catch (e) {
      print(e);
    }
    return true;
  }

//상단 시작
  void itemList() {
    _items1 = [
      const DropdownMenuItem(
        value: '',
        child: Text('전체', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'dealType',
        child: Text('deal종류', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'STATUS',
        child: Text('상태', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'PROGRESS',
        child: Text('진행단계', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'NAME',
        child: Text('이름', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'ID',
        child: Text('아이디', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'TITLE',
        child: Text('제목', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'ADDRESS',
        child: Text('상세주소', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'LABEL',
        child: Text('라벨명', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
    _items2 = [
      const DropdownMenuItem(
        value: '1',
        child: Text('거래중', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: '0',
        child: Text('보류', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: '2',
        child: Text('거래종료', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
    _items3 = [
      const DropdownMenuItem(
        value: 'WRITE',
        child: Text('딜작성', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'VIEW',
        child: Text('열람', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'REVIEWING',
        child: Text('검토중', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'REVIEW_HOLD',
        child: Text('검토보류', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'BUSINESS_MODELING',
        child: Text('사업모델링(수익성검토)', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'IM_CREATION',
        child: Text('IM제작', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'OP_TAPPING',
        child: Text('운용사태핑', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'OP_REVIEW',
        child: Text('운용사검토', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'INV_TAPPING',
        child: Text('투자자태핑', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'INV_REVIEWING',
        child: Text('투자검토중', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'INV_RECRUITING',
        child: Text('투자자모집', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'MOU',
        child: Text('MOU', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'INV_CONSIDERATION',
        child: Text('투자심의', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'CONTRACT_PREP',
        child: Text('계약준비', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'CONTRACT_SIGN',
        child: Text('계약체결', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'PERMIT_REVIEW',
        child: Text('인허가/심의', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'FINAL_PAYMENT',
        child: Text('잔금', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];

    _items4 = [
      const DropdownMenuItem(
        value: 20,
        child: Text('20개씩 보기', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 50,
        child: Text('50개씩 보기', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 100,
        child: Text('100개씩 보기', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
  }

  String dealStatusStr(String dealStatus) {
    String result = '';
    if (dealStatus == '0') {
      result = '보류';
    } else if (dealStatus == '1') {
      result = '거래중';
    } else if (dealStatus == '2') {
      result = '거래완료';
    }
    return result;
  }

  String statusStr(String status) {
    String result = '';
    if (status.toUpperCase() == 'WRITE') {
      result = '딜작성';
    } else if (status.toUpperCase() == 'VIEW') {
      result = '열람';
    } else if (status.toUpperCase() == 'REVIEWING') {
      result = '검토중';
    } else if (status.toUpperCase() == 'REVIEW_HOLD') {
      result = '검토보류';
    } else if (status.toUpperCase() == 'BUSINESS_MODELING') {
      result = '사업모델링(수익성검토)';
    } else if (status.toUpperCase() == 'IM_CREATION') {
      result = 'IM제작';
    } else if (status.toUpperCase() == 'OP_TAPPING') {
      result = '운용사태핑';
    } else if (status.toUpperCase() == 'OP_REVIEW') {
      result = '운용사검토';
    } else if (status.toUpperCase() == 'INV_TAPPING') {
      result = '투자자태핑';
    } else if (status.toUpperCase() == 'INV_REVIEWING') {
      result = '투자검토중';
    } else if (status.toUpperCase() == 'INV_RECRUITING') {
      result = '투자자모집';
    } else if (status.toUpperCase() == 'MOU') {
      result = 'MOU';
    } else if (status.toUpperCase() == 'INV_CONSIDERATION') {
      result = '투자심의';
    } else if (status.toUpperCase() == 'CONTRACT_PREP') {
      result = '계약준비';
    } else if (status.toUpperCase() == 'CONTRACT_SIGN') {
      result = '계약체결';
    } else if (status.toUpperCase() == 'PERMIT_REVIEW') {
      result = '인허가/심의';
    } else if (status.toUpperCase() == 'FINAL_PAYMENT') {
      result = '잔금';
    }
    return result;
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

  Widget topTapBtn(String title, Function() onBtnPressed) {
    return IdNormalBtn(
      onBtnPressed: onBtnPressed,
      childWidget: Container(
        width: 140,
        height: 51,
        decoration: (tapStatus == title)
            ? const BoxDecoration(
                color: IdColors.ligthGreen,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16),
                  topRight: Radius.circular(16),
                ),
              )
            : const BoxDecoration(
                color: IdColors.invisiable,
              ),
        child: Center(
          child: uiCommon.styledText(title, 16, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.center),
        ),
      ),
    );
  }

  Widget inputBox(double width, TextEditingController controller) {
    return IdInputValidation(
        width: width,
        height: 40,
        inputColor: IdColors.white,
        round: 4,
        textAlign: 'start',
        hintText: '',
        borderColor: IdColors.borderDefault,
        controller: controller,
        hintTextFontSize: 16,
        hintTextfontWeight: FontWeight.w500,
        hintTextFontColor: IdColors.textDefault,
        keyboardType: 'text',
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: true);
  }

  Widget datePickerBtn(String dateString) {
    return SizedBox(
      width: 150,
      height: 40,
      child: IdNormalBtn(
        onBtnPressed: () {
          setState(() {
            isCalenderShowed = true;
          });
        },
        childWidget: Stack(
          children: [
            Container(
              width: 150,
              height: 40,
              decoration: BoxDecoration(
                  color: IdColors.white,
                  borderRadius: BorderRadius.circular(4),
                  border: Border.all(width: 1, color: IdColors.borderDefault)),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 12),
                child: uiCommon.styledText((dateString.split('-')[0] == '2000') ? '' : dateformatString(dateString), 16, 0, 1.6,
                    FontWeight.w500, IdColors.textDefault, TextAlign.left),
              ),
            ),
            const Positioned(
                top: 8,
                right: 12,
                child: IdImageBox(imageWidth: 24, imageHeight: 24, imagePath: 'assets/img/icon_calendarBlank.png', imageFit: BoxFit.cover))
          ],
        ),
      ),
    );
  }

  String dateformatString(String date) {
    String results = '';
    if (date == '' || date == 'null') {
      results = '';
    } else {
      results = date.toString().split(' ')[0];
    }
    return results;
  }

  Widget _oneDualCalendar(double left, double top, double width, double widgetHeight, DateTime? start, DateTime? end,
      Function(DateTime, DateTime) onSubmitted) {
    Widget ptCalendar = IdDualCalendar(
      start != null && end != null ? [start, end] : [],
      onClose: () {
        isCalenderShowed = false;
        setState(() {});
      },
      onComplete: (p0, p1) {
        _startDate = p0;
        _endDate = p1;
        isCalenderShowed = false;
        //연,월,일,시,분,초로 쪼개서 각 파라미터에 전달
        //시작일
        startYear = p0.toString().split(' ')[0].split('-')[0];
        startMonth = p0.toString().split(' ')[0].split('-')[1];
        startDay = p0.toString().split(' ')[0].split('-')[2];
        startHour = p0.toString().split(' ')[1].split('.')[0].split(':')[0];
        startMinutes = p0.toString().split(' ')[1].split('.')[0].split(':')[1];
        startSeconds = p0.toString().split(' ')[1].split('.')[0].split(':')[2];
        //마지막일
        endYear = p1.toString().split(' ')[0].split('-')[0];
        endMonth = p1.toString().split(' ')[0].split('-')[1];
        endDay = p1.toString().split(' ')[0].split('-')[2];
        endHour = p1.toString().split(' ')[1].split('.')[0].split(':')[0];
        endMinutes = p1.toString().split(' ')[1].split('.')[0].split(':')[1];
        endSeconds = p1.toString().split(' ')[1].split('.')[0].split(':')[2];

        setState(() {});
      },
    );
    return Indexed(
        key: UniqueKey(),
        index: 500,
        child: Positioned(left: left, top: top, child: SizedBox(width: width, height: widgetHeight, child: Material(child: ptCalendar))));
  }

  Widget dropdown1(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown, String searchType) {
    return Container(
      width: 140,
      height: 40,
      padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
      decoration: BoxDecoration(
        color: IdColors.white,
        border: Border.all(
          width: 1,
          color: IdColors.borderDefault,
        ),
        borderRadius: BorderRadius.circular(4),
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
          if (searchType == 'searchType1') {
            searchType1 = value.toString().toUpperCase();
            if (searchType1 == '' ||
                searchType1 == 'NAME'.toUpperCase() ||
                searchType1 == 'ID'.toUpperCase() ||
                searchType1 == 'TITLE'.toUpperCase() ||
                searchType1 == 'ADDRESS'.toUpperCase() ||
                searchType1 == 'LABEL'.toUpperCase()) {
              searchType2 = '';
            }
          } else {
            searchType2 = value;
          }
          setState(() {});
          focusDropDown.unfocus();
        },
        onSaved: (value) {},
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(top: 4, right: 11),
            child: Icon(
              changeDropdown ? Icons.expand_less : Icons.expand_more,
              color: IdColors.textDefault,
            ),
          ),
          iconSize: 20,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 250,
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

  Widget dropdown2(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown) {
    return Container(
      width: 160,
      height: 32,
      padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
      decoration: BoxDecoration(
        color: IdColors.white,
        border: Border.all(
          width: 1,
          color: IdColors.blueGrey,
        ),
        borderRadius: BorderRadius.circular(32),
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
          rowSize = int.tryParse(value.toString()) ?? 1;
          setState(() {});
          focusDropDown.unfocus();
          fetchData();
        },
        onSaved: (value) {},
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(top: 4, right: 11),
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

  void orderStatus(int orderTypeListNum) {
    if (orderTypeListNum == 1) {
      statusOrder = 0;
      dealStatusOrder = 0;
      askingOrder = 0;
      totalLotOrder = 0;
      dealDomiOrder = 0;
      leftDateOrder = 0;
      if (dealTypeOrder == 0) {
        dealTypeOrder = 1;
      } else if (dealTypeOrder == 1) {
        dealTypeOrder = 0;
      }
    } else if (orderTypeListNum == 2) {
      dealTypeOrder = 0;
      dealStatusOrder = 0;
      askingOrder = 0;
      totalLotOrder = 0;
      dealDomiOrder = 0;
      leftDateOrder = 0;
      if (statusOrder == 0) {
        statusOrder = 1;
      } else if (statusOrder == 1) {
        statusOrder = 0;
      }
    } else if (orderTypeListNum == 3) {
      dealTypeOrder = 0;
      statusOrder = 0;
      askingOrder = 0;
      totalLotOrder = 0;
      dealDomiOrder = 0;
      leftDateOrder = 0;
      if (dealStatusOrder == 0) {
        dealStatusOrder = 1;
      } else if (dealStatusOrder == 1) {
        dealStatusOrder = 0;
      }
    } else if (orderTypeListNum == 4) {
      dealTypeOrder = 0;
      statusOrder = 0;
      dealStatusOrder = 0;
      totalLotOrder = 0;
      dealDomiOrder = 0;
      leftDateOrder = 0;
      if (askingOrder == 0) {
        askingOrder = 1;
      } else if (askingOrder == 1) {
        askingOrder = 0;
      }
    } else if (orderTypeListNum == 5) {
      dealTypeOrder = 0;
      statusOrder = 0;
      dealStatusOrder = 0;
      askingOrder = 0;
      dealDomiOrder = 0;
      leftDateOrder = 0;
      if (totalLotOrder == 0) {
        totalLotOrder = 1;
      } else if (totalLotOrder == 1) {
        totalLotOrder = 0;
      }
    } else if (orderTypeListNum == 6) {
      dealTypeOrder = 0;
      statusOrder = 0;
      dealStatusOrder = 0;
      askingOrder = 0;
      totalLotOrder = 0;
      leftDateOrder = 0;
      if (dealDomiOrder == 0) {
        dealDomiOrder = 1;
      } else if (dealDomiOrder == 1) {
        dealDomiOrder = 0;
      }
    } else if (orderTypeListNum == 7) {
      dealTypeOrder = 0;
      statusOrder = 0;
      dealStatusOrder = 0;
      askingOrder = 0;
      totalLotOrder = 0;
      dealDomiOrder = 0;
      if (leftDateOrder == 0) {
        leftDateOrder = 1;
      } else if (leftDateOrder == 1) {
        leftDateOrder = 0;
      }
    }

    setState(() {});
  }

  String arrowPath(int orderTypeListNum) {
    String result = "assets/img/icon_arrow_down.png";
    if (orderTypeListNum == 1) {
      if (dealTypeOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (dealTypeOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 2) {
      if (statusOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (statusOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 3) {
      if (dealStatusOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (dealStatusOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 4) {
      if (askingOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (askingOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 5) {
      if (totalLotOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (totalLotOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 6) {
      if (dealDomiOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (dealDomiOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 7) {
      if (leftDateOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (leftDateOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    }

    return result;
  }

  Widget boardHeaderContent(
    double widthPersent,
    double borderWidth,
    String title,
    String headerType,
    String unit,
    int orderTypeListNum,
    int order,
  ) {
    return (headerType == 'button')
        ? SizedBox(
            width: ((widthPersent / 100) * (webWidth - 50)) - borderWidth,
            height: 63,
            child: Center(
              child: IdNormalBtn(
                onBtnPressed: () {
                  orderType = orderTypeList[orderTypeListNum - 1];
                  orderStatus(orderTypeListNum);

                  fetchData();
                },
                childWidget: (unit == '')
                    ? SizedBox(
                        height: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            uiCommon.styledText(title, 14, 0, 1, FontWeight.w600, IdColors.black, TextAlign.center),
                            const IdSpace(spaceWidth: 4, spaceHeight: 0),
                            IdImageBox(imagePath: arrowPath(orderTypeListNum), imageFit: BoxFit.cover)
                          ],
                        ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              uiCommon.styledText(title, 14, 0, 1, FontWeight.w600, IdColors.black, TextAlign.center),
                              const IdSpace(spaceWidth: 4, spaceHeight: 0),
                              IdImageBox(imagePath: arrowPath(orderTypeListNum), imageFit: BoxFit.cover)
                            ],
                          ),
                          IdSpace(spaceWidth: 0, spaceHeight: 3),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: Container(
                              width: double.infinity,
                              height: 1,
                              color: IdColors.borderDefault,
                            ),
                          ),
                          IdSpace(spaceWidth: 0, spaceHeight: 4),
                          uiCommon.styledText(unit, 13, 0, 1, FontWeight.w400, IdColors.textTertiary, TextAlign.center)
                        ],
                      ),
              ),
            ),
          )
        : SizedBox(
            width: ((widthPersent / 100) * (webWidth - 50)) - borderWidth,
            height: 63,
            child: Center(
              child: uiCommon.styledText(title, 14, 0, 1, FontWeight.w600, IdColors.black, TextAlign.center),
            ),
          );
  }

  Widget boardHeader() {
    return Container(
      width: webWidth - 50,
      decoration: BoxDecoration(
        color: IdColors.backgroundDefault,
        border: Border.all(width: 1, color: IdColors.borderDefault),
      ),
      child: (gubun == 2)
          ? Row(
              children: [
                boardHeaderContent(5, 1, 'no', 'text', '', 0, 0),
                boardHeaderContent(14, 0, '주소', 'text', '', 0, 0),
                boardHeaderContent(14, 0, '제목', 'text', '', 0, 0),
                boardHeaderContent(10, 0, 'Deal종류', 'button', '', 1, dealTypeOrder),
                boardHeaderContent(7, 0, '이름', 'text', '', 0, 0),
                boardHeaderContent(10, 0, '소속', 'text', '', 0, 0),
                boardHeaderContent(5, 0, '잔여일', 'button', '', 7, leftDateOrder),
                boardHeaderContent(7, 0, '상태', 'button', '', 2, statusOrder),
                boardHeaderContent(7, 0, '진행단계', 'button', '', 3, dealStatusOrder),
                boardHeaderContent(5, 0, '라벨', 'text', '', 0, 0),
                boardHeaderContent(10, 0, 'Asking', 'button', '억원', 4, askingOrder),
                boardHeaderContent(6, 1, '연면적', 'button', '㎡', 5, totalLotOrder),
              ],
            )
          : (gubun == 0)
              ? Row(
                  children: [
                    boardHeaderContent(5, 1, 'no', 'text', '', 0, 0),
                    boardHeaderContent(10, 0, '주소', 'text', '', 0, 0),
                    boardHeaderContent(10, 0, '제목', 'text', '', 0, 0),
                    boardHeaderContent(10, 0, 'Deal종류', 'button', '', 1, dealTypeOrder),
                    boardHeaderContent(10, 0, '독점보호', 'button', '', 6, 0),
                    boardHeaderContent(7, 0, '이름', 'text', '', 0, 0),
                    boardHeaderContent(15, 0, '소속', 'text', '', 0, 0),
                    boardHeaderContent(5, 0, '상태', 'button', '', 2, statusOrder),
                    boardHeaderContent(6, 0, '진행단계', 'button', '', 3, dealStatusOrder),
                    boardHeaderContent(5, 0, '라벨', 'text', '', 0, 0),
                    boardHeaderContent(10, 0, 'Asking', 'button', '억원', 4, askingOrder),
                    boardHeaderContent(7, 1, '연면적', 'button', '㎡', 5, totalLotOrder),
                  ],
                )
              : Row(
                  children: [
                    boardHeaderContent(5, 1, 'no', 'text', '', 0, 0),
                    boardHeaderContent(15, 0, '주소', 'text', '', 0, 0),
                    boardHeaderContent(15, 0, '제목', 'text', '', 0, 0),
                    boardHeaderContent(10, 0, 'Deal종류', 'button', '', 1, dealTypeOrder),
                    boardHeaderContent(7, 0, '이름', 'text', '', 0, 0),
                    boardHeaderContent(15, 0, '소속', 'text', '', 0, 0),
                    boardHeaderContent(5, 0, '상태', 'button', '', 2, statusOrder),
                    boardHeaderContent(6, 0, '진행단계', 'button', '', 3, dealStatusOrder),
                    boardHeaderContent(5, 0, '라벨', 'text', '', 0, 0),
                    boardHeaderContent(10, 0, 'Asking', 'button', '억원', 4, askingOrder),
                    boardHeaderContent(7, 1, '연면적', 'button', '㎡', 5, totalLotOrder),
                  ],
                ),
    );
  }

  //상단 끝
  @override
  Widget build(BuildContext context) {
    uiCommon.setScreen(context);
    if (_dealDs[0].data == null) {
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
    _dealSvcDS = makeRows();

    var pages = _dealSvcDS.isNotEmpty
        ?

        // Idpagination2(totalPageCnt: totalListCnt)

        IdPaginationWidget(
            buttonColor: Color.fromRGBO(0, 0, 0, 0),
            buttonTextColor: IdColors.black,
            buttonFontSize: 18,
            actualPage: acturalPage,
            countToDisplay: 10,
            totalPages: totalPage,
            onPageChange: (page) async {
              acturalPage = page;
              rowNum = 0;
              labelPopupVisible = false;
              // clickNumber = 0;
              // ListIndex = 0;
              // _constructReportCheckDS.data!.list. = page;
              fetchData();
            },
            moveToBefore: (page) async {
              acturalPage - 1;
              rowNum = 0;
              labelPopupVisible = false;
              fetchData();
            },
            moveToNext: (page) async {
              acturalPage + 1;
              rowNum = 0;
              labelPopupVisible = false;
              fetchData();
            },
          )
        : const SizedBox();

    Widget boardGrid123 = _dealSvcDS.isNotEmpty
        ? IdGrid(
            width: webWidth - 50,
            internalGrid: false,
            headerColumns: (gubun == 2)
                ? ['NO', '주소', '제목', 'Deal종류', '이름', '소속', '잔여일', '상태', '진행단계', '라벨', 'asking', '연면적']
                : (gubun == 1)
                    ? ['NO', '주소', '제목', 'Deal종류', '이름', '소속', '상태', '진행단계', '라벨', 'asking', '연면적']
                    : ['NO', '주소', '제목', 'Deal종류', '독점보호', '이름', '소속', '상태', '진행단계', '라벨', 'asking', '연면적'],
            columnWidthsPercentages: (gubun == 2)
                ? <double>[5, 14, 14, 10, 7, 10, 5, 7, 7, 5, 10, 6]
                : (gubun == 1)
                    ? <double>[5, 15, 15, 10, 7, 15, 5, 6, 5, 10, 7]
                    : <double>[5, 10, 10, 10, 10, 7, 15, 5, 6, 5, 10, 7],
            headerBorderColor: const Color(0xffffff).withOpacity(0),
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 16,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 0,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 38,
            rowCnt: double.tryParse(currentRowsCnt.toString()) ?? 1,
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
                top: BorderSide(width: 2, color: IdColors.borderSecondly),
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
                          child: (gubun == 2)
                              ? (cell == 9)
                                  ? (content != '')
                                      ? Row(
                                          children: [
                                            Container(
                                              width: 80,
                                              height: 26,
                                              decoration: BoxDecoration(
                                                color: labelBgColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                border: Border.all(
                                                  width: 1,
                                                  color: labelColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                ),
                                                borderRadius: BorderRadius.circular(8),
                                              ),
                                              child: Center(
                                                child: Text(content.toString().split('-')[0],
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontFamily: 'Pretendard',
                                                      color: labelColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                      fontSize: 14,
                                                    ),
                                                    softWrap: true),
                                              ),
                                            ),
                                            ((int.tryParse(content.toString().split('-')[2]) ?? 0) > 1)
                                                ? Row(
                                                    children: [
                                                      IdSpace(spaceWidth: 5, spaceHeight: 0),
                                                      IdNormalBtn(
                                                        onBtnPressed: () {
                                                          rowNum = row;
                                                          labelPopupVisible = true;
                                                          setState(() {});
                                                        },
                                                        childWidget: const IdImageBox(
                                                            imagePath: 'assets/img/icon_plus.png',
                                                            imageWidth: 20,
                                                            imageHeight: 20,
                                                            imageFit: BoxFit.cover),
                                                      ),
                                                    ],
                                                  )
                                                : const SizedBox()
                                          ],
                                        )
                                      : const SizedBox()
                                  : Text(content,
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.w400,
                                        fontFamily: 'Pretendard',
                                        color: IdColors.textDefault,
                                        fontSize: 16,
                                      ),
                                      softWrap: true)
                              : (gubun == 1)
                                  ? (cell == 8)
                                      ? (content != '')
                                          ? Row(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 26,
                                                  decoration: BoxDecoration(
                                                    color: labelBgColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: labelColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Center(
                                                    child: Text(content.toString().split('-')[0],
                                                        textAlign: TextAlign.center,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: 'Pretendard',
                                                          color: labelColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                          fontSize: 14,
                                                        ),
                                                        softWrap: true),
                                                  ),
                                                ),
                                                ((int.tryParse(content.toString().split('-')[2]) ?? 0) > 1)
                                                    ? Row(
                                                        children: [
                                                          IdSpace(spaceWidth: 5, spaceHeight: 0),
                                                          IdNormalBtn(
                                                            onBtnPressed: () {
                                                              rowNum = row;
                                                              labelPopupVisible = true;
                                                              setState(() {});
                                                            },
                                                            childWidget: const IdImageBox(
                                                                imagePath: 'assets/img/icon_plus.png',
                                                                imageWidth: 20,
                                                                imageHeight: 20,
                                                                imageFit: BoxFit.cover),
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox()
                                              ],
                                            )
                                          : SizedBox()
                                      : Text(content,
                                          textAlign: TextAlign.center,
                                          maxLines: 2,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontFamily: 'Pretendard',
                                            color: IdColors.textDefault,
                                            fontSize: 16,
                                          ),
                                          softWrap: true)
                                  : (cell == 9)
                                      ? (content != '')
                                          ? Row(
                                              children: [
                                                Container(
                                                  width: 80,
                                                  height: 26,
                                                  decoration: BoxDecoration(
                                                    color: labelBgColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                    border: Border.all(
                                                      width: 1,
                                                      color: labelColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                    ),
                                                    borderRadius: BorderRadius.circular(8),
                                                  ),
                                                  child: Center(
                                                    child: Text(content.toString().split('-')[0],
                                                        textAlign: TextAlign.center,
                                                        maxLines: 2,
                                                        style: TextStyle(
                                                          fontWeight: FontWeight.w400,
                                                          fontFamily: 'Pretendard',
                                                          color: labelColor(int.tryParse(content.toString().split('-')[1]) ?? 1),
                                                          fontSize: 14,
                                                        ),
                                                        softWrap: true),
                                                  ),
                                                ),
                                                ((int.tryParse(content.toString().split('-')[2]) ?? 0) > 1)
                                                    ? Row(
                                                        children: [
                                                          IdSpace(spaceWidth: 5, spaceHeight: 0),
                                                          IdNormalBtn(
                                                            onBtnPressed: () {
                                                              rowNum = row;
                                                              labelPopupVisible = true;
                                                              setState(() {});
                                                            },
                                                            childWidget: const IdImageBox(
                                                                imagePath: 'assets/img/icon_plus.png',
                                                                imageWidth: 20,
                                                                imageHeight: 20,
                                                                imageFit: BoxFit.cover),
                                                          ),
                                                        ],
                                                      )
                                                    : SizedBox()
                                              ],
                                            )
                                          : SizedBox()
                                      : Text(content,
                                          textAlign: TextAlign.center,
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
              GV.pStrg.putXXX(Param_beforePage, 'deal');
              GV.pStrg.putXXX(Param_dealNoString, dealNoList[index]);
              GV.pStrg.putXXX(Param_typeString, typeList[index]);

              uiCommon.IdMovePage(context, PAGE_DEAL_DETAIL_PAGE);

              setState(() {});
            },
            data: _dealSvcDS)
        : Container(
            width: double.infinity,
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
            child: Container(
              width: double.infinity,
              color: IdColors.white,
              child: Column(
                children: [
                  //상단
                  Stack(
                    children: [
                      Column(
                        children: [
                          const IdSpace(spaceWidth: 0, spaceHeight: 50),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: IdColors.ligthGreen,
                              borderRadius: const BorderRadius.only(
                                topRight: Radius.circular(16),
                                bottomLeft: Radius.circular(16),
                                bottomRight: Radius.circular(16),
                              ),
                              border: Border.all(
                                width: 1,
                                color: IdColors.borderDefault,
                              ),
                            ),
                            child: Row(
                              children: [
                                uiCommon.styledText(
                                    (gubun == 2) ? '기간 선택' : '딜 등록일', 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                datePickerBtn(_startDate.toString()),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                uiCommon.styledText('-', 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                datePickerBtn(_endDate.toString()),
                                const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                dropdown1(_focusDropDown1, '선택하세요', _items1, changeDropdown1, 'searchType1'),
                                const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                (searchType1.toUpperCase() == 'STATUS'.toUpperCase() ||
                                        searchType1.toUpperCase() == 'PROGRESS'.toUpperCase())
                                    ? dropdown1(
                                        _focusDropDown2,
                                        '선택하세요',
                                        (searchType1.toUpperCase() == 'STATUS'.toUpperCase()) ? _items2 : _items3,
                                        changeDropdown2,
                                        'searchType2')
                                    : Container(
                                        width: 140,
                                        height: 40,
                                        padding: const EdgeInsets.fromLTRB(15, 4, 11, 4),
                                        decoration: BoxDecoration(
                                          color: IdColors.backgroundDefault,
                                          border: Border.all(
                                            width: 1,
                                            color: IdColors.borderDefault,
                                          ),
                                          borderRadius: BorderRadius.circular(4),
                                        ),
                                        child:
                                            uiCommon.styledText('선택하세요', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                                      ),
                                const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                inputBox(273, _searchController),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                IdNormalBtn(
                                  //TODO API나오면 그때 넘겨줄 REQUEST부분
                                  onBtnPressed: () {
                                    fetchData();
                                  },
                                  childWidget: Container(
                                    width: 76,
                                    height: 40,
                                    decoration: BoxDecoration(color: IdColors.textDefault, borderRadius: BorderRadius.circular(4)),
                                    child: Center(
                                        child: uiCommon.styledText('검색', 16, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.center)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Positioned(
                        top: 0,
                        left: 0,
                        child: Row(
                          children: [
                            topTapBtn(
                              '독점',
                              () {
                                gubun = 2;
                                rowNum = 0;
                                labelPopupVisible = false;
                                tapStatus = tapStatusList[0];
                                setState(() {});
                                fetchData();
                              },
                            ),
                            topTapBtn(
                              '일반',
                              () {
                                gubun = 1;
                                rowNum = 0;
                                labelPopupVisible = false;
                                tapStatus = tapStatusList[1];
                                setState(() {});
                                fetchData();
                              },
                            ),
                            topTapBtn(
                              '전체',
                              () {
                                gubun = 0;
                                rowNum = 0;
                                labelPopupVisible = false;
                                tapStatus = tapStatusList[2];
                                setState(() {});
                                fetchData();
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const IdSpace(spaceWidth: 0, spaceHeight: 16),
                  //본문
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration:
                        BoxDecoration(border: Border.all(width: 1, color: IdColors.borderDefault), borderRadius: BorderRadius.circular(16)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: double.infinity,
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  children: [
                                    uiCommon.styledText('$currentRowsCnt건 / 총 $totalRowsCnt건', 16, 0, 1.6, FontWeight.w500,
                                        IdColors.textDefault, TextAlign.left),
                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                    dropdown2(_focusDropDown3, '20개씩 보기', _items4, changeDropdown3)
                                  ],
                                ),
                              ),
                              IdNormalBtn(
                                //TODO 추후 엑셀다운로드 되면
                                onBtnPressed: () async {
                                  if (await setExcell()) {
                                    GV.d('성공');
                                  } else {
                                    GV.d('실패');
                                  }
                                },
                                childWidget: Container(
                                  width: 132,
                                  height: 32,
                                  decoration: BoxDecoration(color: IdColors.textTertiary, borderRadius: BorderRadius.circular(4)),
                                  child: Center(
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        uiCommon.styledText('액셀 다운로드', 14, 0, 1, FontWeight.w700, IdColors.white, TextAlign.left),
                                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                        const IdImageBox(
                                            imagePath: 'assets/img/icon_down.png', imageWidth: 16, imageHeight: 16, imageFit: BoxFit.cover)
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const IdSpace(spaceWidth: 0, spaceHeight: 16),
                        boardHeader(),
                        Stack(
                          children: [
                            Column(
                              children: [
                                SizedBox(
                                  width: double.infinity,
                                  child: boardGrid123,
                                ),
                                const IdSpace(spaceWidth: 0, spaceHeight: 56),
                                // uiCommon.styledText('$gubun   ${labelList.isNotEmpty}   $labelList   ${labelList.length}', 16, 0, 1,
                                //     FontWeight.w500, IdColors.black, TextAlign.center)
                              ],
                            ),
                            //라벨리스트
                            Visibility(
                              visible: labelPopupVisible,
                              child: Positioned(
                                top: 43 * (double.tryParse(rowNum.toString()) ?? 0),
                                right: (gubun == 2) ? (16 / 100) * webWidth : (17 / 100) * webWidth,
                                child: Container(
                                  width: (labelList.isNotEmpty)
                                      ? (labelList[rowNum].length >= 6)
                                          ? (100 * 6)
                                          : (100 * (double.tryParse((labelList[rowNum].length).toString()) ?? 0))
                                      : 0,
                                  padding: EdgeInsets.only(left: 5, top: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    color: IdColors.white,
                                    boxShadow: const [
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
                                        children: [
                                          const Expanded(child: SizedBox()),
                                          IdNormalBtn(
                                            onBtnPressed: () {
                                              rowNum = 0;
                                              labelPopupVisible = false;
                                              setState(() {});
                                            },
                                            childWidget: const IdImageBox(
                                                imagePath: 'assets/img/icon_close.png',
                                                imageWidth: 20,
                                                imageHeight: 20,
                                                imageFit: BoxFit.cover),
                                          ),
                                          IdSpace(spaceWidth: 5, spaceHeight: 0)
                                        ],
                                      ),
                                      IdSpace(spaceWidth: 0, spaceHeight: 8),
                                      (_dealSvcDS.isEmpty)
                                          ? SizedBox()
                                          : (labelList[rowNum].length <= 6)
                                              ? Column(
                                                  children: [
                                                    Row(
                                                      children: List.generate(
                                                        labelList[rowNum].length,
                                                        (index) => Row(
                                                          children: [
                                                            Container(
                                                              width: 93,
                                                              height: 24,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: (labelList[rowNum][0].length > 0)
                                                                        ? labelColor(labelList[rowNum][index][1])
                                                                        : IdColors.black),
                                                              ),
                                                              child: Center(
                                                                child: uiCommon.styledText(
                                                                    (labelList[rowNum][0].length > 0) ? labelList[rowNum][index][0] : '',
                                                                    14,
                                                                    0,
                                                                    1,
                                                                    FontWeight.w400,
                                                                    (labelList[rowNum][0].length > 0)
                                                                        ? labelColor(labelList[rowNum][index][1])
                                                                        : IdColors.black,
                                                                    TextAlign.center),
                                                              ),
                                                            ),
                                                            (index + 1 == labelList[rowNum].length)
                                                                ? SizedBox()
                                                                : IdSpace(spaceWidth: 5, spaceHeight: 0)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    const IdSpace(spaceWidth: 0, spaceHeight: 10)
                                                  ],
                                                )
                                              : Column(
                                                  children: [
                                                    Row(
                                                      children: List.generate(
                                                        6,
                                                        (index) => Row(
                                                          children: [
                                                            Container(
                                                              width: 93,
                                                              height: 24,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: (labelList[rowNum][0].length > 0)
                                                                        ? labelColor(labelList[rowNum][index][1])
                                                                        : IdColors.black),
                                                              ),
                                                              child: Center(
                                                                child: uiCommon.styledText(
                                                                    (labelList[rowNum][0].length > 0) ? labelList[rowNum][index][0] : '',
                                                                    14,
                                                                    0,
                                                                    1,
                                                                    FontWeight.w400,
                                                                    (labelList[rowNum][0].length > 0)
                                                                        ? labelColor(labelList[rowNum][index][1])
                                                                        : IdColors.black,
                                                                    TextAlign.center),
                                                              ),
                                                            ),
                                                            (index == 5) ? SizedBox() : IdSpace(spaceWidth: 5, spaceHeight: 0)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    IdSpace(spaceWidth: 0, spaceHeight: 5),
                                                    Row(
                                                      children: List.generate(
                                                        labelList[rowNum].length - 6,
                                                        (index) => Row(
                                                          children: [
                                                            Container(
                                                              width: 93,
                                                              height: 24,
                                                              decoration: BoxDecoration(
                                                                borderRadius: BorderRadius.circular(8),
                                                                border: Border.all(
                                                                    width: 1,
                                                                    color: (labelList[rowNum][0].length > 0)
                                                                        ? labelColor(labelList[rowNum][index + 6][1])
                                                                        : IdColors.black),
                                                              ),
                                                              child: Center(
                                                                child: uiCommon.styledText(
                                                                    (labelList[rowNum][0].length > 0)
                                                                        ? labelList[rowNum][index + 6][0]
                                                                        : '',
                                                                    14,
                                                                    0,
                                                                    1,
                                                                    FontWeight.w400,
                                                                    (labelList[rowNum][0].length > 0)
                                                                        ? labelColor(labelList[rowNum][index + 6][1])
                                                                        : IdColors.black,
                                                                    TextAlign.center),
                                                              ),
                                                            ),
                                                            (index == 5) ? SizedBox() : IdSpace(spaceWidth: 5, spaceHeight: 0)
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                    IdSpace(spaceWidth: 0, spaceHeight: 10),
                                                  ],
                                                ),
                                    ],
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              pages,
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          //데이터 피커
          isCalenderShowed
              ? _oneDualCalendar(92, 84, 548, 361, (_startDate.toString().split('-')[0] == '2000') ? now : _startDate,
                  (_startDate.toString().split('-')[0] == '2000') ? now : _endDate, (p0, p1) {})
              : const SizedBox()
        ],
      ),
    );
  }
}
