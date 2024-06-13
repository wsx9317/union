import 'dart:html';
import 'dart:html' as html;

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:indexed/indexed.dart';
import 'package:intl/intl.dart';
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
import 'package:union_admin/modelVO/dealDomiResponse.dart';
import 'package:union_admin/modelVO/search_option_item.dart';
import 'package:union_admin/popup/alertPopup.dart';

class _DealDomiList {
  DealDomiResponse? data;
}

class DealDomi extends StatefulWidget {
  const DealDomi({super.key});

  @override
  State<DealDomi> createState() => _DealDomiState();
}

class _DealDomiState extends State<DealDomi> {
  List<List<String>> _dealDomiSvcDS = [];
  List<_DealDomiList> _dealDomiDs = [];
  //TODO 유저번호 임시
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

  int rowSize = 20;

  double webWidth = double.tryParse(GV.pStrg.getXXX(key_page_with)) ?? 1200;

  DateTime now = DateTime.now();

  int currentRowsCnt = 0;
  int totalRowsCnt = 0;
  int totalPage = 0;
  int acturalPage = 1;

  int orderType = 0;
  List<int> orderTypeList = [1, 2, 3, 4, 5, 6, 7]; //이름, 소속, 등록일시, 만료일시, Asking, 연면적, 대지면적

  int nameOrder = 0;
  int officeOrder = 0;
  int startDateOrder = 0;
  int endDateOrder = 0;
  int askingOrder = 0;
  int lotOrder = 0;
  int totalLotOrder = 0;

  List dealNoList = [];
  List dealDomiNoList = [];
  List typeList = [];

  List<bool> checkBoxList = [];
  List<String> dealNoParamList = [];

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

  double boardWidth = 1292;

  bool alertPopupVisible = false;

  TextEditingController _startDateController = TextEditingController();
  TextEditingController _endDateController = TextEditingController();
  TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _dealDomiDs.add(_DealDomiList());
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
    checkBoxList = [];

    final DealDomiResponse? ret1 = await IdApi.getdealDomiList(SearchOptionItme(
      rowSize: rowSize,
      page: acturalPage - 1,
      searchType1: searchType1,
      searchType2: searchType2,
      searchVal: _searchController.text,
      dateType: 'START',
      startDate: startDateStr,
      endDate: endDateStr,
      orderType: (orderType == 0) ? '' : orderType.toString(),
      order: (orderType == 0)
          ? '0'
          : (orderType == 1)
              ? nameOrder.toString()
              : (orderType == 2)
                  ? officeOrder.toString()
                  : (orderType == 3)
                      ? startDateOrder.toString()
                      : (orderType == 4)
                          ? endDateOrder.toString()
                          : (orderType == 5)
                              ? askingOrder.toString()
                              : (orderType == 6)
                                  ? totalLotOrder.toString()
                                  : lotOrder.toString(),
    ));

    if (ret1 != null) {
      _dealDomiDs[0].data = ret1;
      Map<String, dynamic> commonInfo = _dealDomiDs[0].data!.commonInfo!;

      totalRowsCnt = commonInfo['totalCount'];

      if (totalRowsCnt > 0) {
        if (totalRowsCnt % rowSize == 0) {
          totalPage = int.tryParse((totalRowsCnt / rowSize).toString()) ?? 1;
        } else {
          totalPage = (int.tryParse((totalRowsCnt / rowSize).toString().split('.')[0]) ?? 1) + 1;
        }
      }
      for (var i = 0; i < _dealDomiDs[0].data!.list!.length; i++) {
        checkBoxList.add(false);
      }
    } else {
      _dealDomiDs[0].data = DealDomiResponse(list: [], commonInfo: {});
    }
    makeRows();
  }

  List<List<String>> makeRows() {
    List<List<String>> results = [];
    dealNoList = [];
    dealDomiNoList = [];
    typeList = [];
    currentRowsCnt = 0;

    for (var i = 0; i < _dealDomiDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _dealDomiDs[0].data!.list![i];
      dealNoList.add(item1.dealNo!);
      dealDomiNoList.add(item1.dealDomiNo);
      typeList.add(item1.type!);
      row1.add((i + 1).toString());
      row1.add(item1.dealDomiNo!);
      if (item1.userName != null) {
        row1.add(item1.userName!);
      } else {
        row1.add('-');
      }
      if (item1.office != null) {
        row1.add(item1.office!);
      } else {
        row1.add('-');
      }
      row1.add(item1.startDate!);
      row1.add(item1.endDate!);
      if (item1.address != null) {
        row1.add(item1.address!);
      } else {
        row1.add('-');
      }
      row1.add(NumberFormat('#,##0.00').format((double.tryParse(item1.asking!) ?? 0) / 100000000));
      row1.add(NumberFormat('#,##0.00').format(double.tryParse(item1.totalFloorArea!) ?? 0));
      row1.add(NumberFormat('#,##0.00').format(double.tryParse(item1.lotArea!) ?? 0));
      results.add(row1);
    }
    currentRowsCnt = results.length;
    setState(() {});
    return results;
  }

  Future<bool> setDomi() async {
    try {
      final result = await IdApi.setDomi(dealNoParamList, userNo);
      if (result == null) return false;
    } catch (e) {
      print(e);
    }
    return true;
  }

  Future<bool> setExcell() async {
    try {
      int orderPram = 0;
      String startDateStr = '';
      String endDateStr = '';

      if (orderType == 1) {
        orderPram = nameOrder;
      } else if (orderType == 2) {
        orderPram = officeOrder;
      } else if (orderType == 3) {
        orderPram = startDateOrder;
      } else if (orderType == 4) {
        orderPram = endDateOrder;
      } else if (orderType == 5) {
        orderPram = askingOrder;
      } else if (orderType == 6) {
        orderPram = totalLotOrder;
      } else if (orderType == 7) {
        orderPram = lotOrder;
      }

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
      checkBoxList = [];
      final result = await IdApi.setDomiExcell(SearchOptionItme(
        searchType1: searchType1,
        searchType2: searchType2,
        searchVal: _searchController.text,
        dateType: 'START',
        startDate: startDateStr,
        endDate: endDateStr,
        orderType: (orderType == 0) ? '' : orderType.toString(),
        order: (orderType == 0)
            ? '0'
            : (orderType == 1)
                ? nameOrder.toString()
                : (orderType == 2)
                    ? officeOrder.toString()
                    : (orderType == 3)
                        ? startDateOrder.toString()
                        : (orderType == 4)
                            ? endDateOrder.toString()
                            : (orderType == 5)
                                ? askingOrder.toString()
                                : (orderType == 6)
                                    ? totalLotOrder.toString()
                                    : lotOrder.toString(),
      ));
      if (result == null) return false;
      final blob = Blob([result], 'application/octet-stream');
      final url = Url.createObjectUrlFromBlob(blob);

      final anchor = AnchorElement()
        ..href = url
        ..download = '독점 요청 딜 리스트.xlsx';
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
        value: 'deal',
        child: Text('deal종류', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'status',
        child: Text('상태', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'title',
        child: Text('제목', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'address',
        child: Text('상세주소', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'progress',
        child: Text('진행현황', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
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
                searchType1 == 'TITLE'.toUpperCase() ||
                searchType1 == 'ADDRESS'.toUpperCase() ||
                searchType1 == 'DEAL'.toUpperCase()) {
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
  //상단 끝

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
      if (nameOrder == 0) {
        nameOrder = 1;
      } else if (nameOrder == 1) {
        nameOrder = 0;
      }
    } else if (orderTypeListNum == 2) {
      if (officeOrder == 0) {
        officeOrder = 1;
      } else if (officeOrder == 1) {
        officeOrder = 0;
      }
    } else if (orderTypeListNum == 3) {
      if (startDateOrder == 0) {
        startDateOrder = 1;
      } else if (startDateOrder == 1) {
        startDateOrder = 0;
      }
    } else if (orderTypeListNum == 4) {
      if (endDateOrder == 0) {
        endDateOrder = 1;
      } else if (endDateOrder == 1) {
        endDateOrder = 0;
      }
    } else if (orderTypeListNum == 5) {
      if (askingOrder == 0) {
        askingOrder = 1;
      } else if (askingOrder == 1) {
        askingOrder = 0;
      }
    } else if (orderTypeListNum == 6) {
      if (totalLotOrder == 0) {
        totalLotOrder = 1;
      } else if (totalLotOrder == 1) {
        totalLotOrder = 0;
      }
    } else if (orderTypeListNum == 7) {
      if (lotOrder == 0) {
        lotOrder = 1;
      } else if (lotOrder == 1) {
        lotOrder = 0;
      }
    }
    setState(() {});
  }

  String arrowPath(int orderTypeListNum) {
    String result = "assets/img/icon_arrow_down.png";
    if (orderTypeListNum == 1) {
      if (nameOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (nameOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 2) {
      if (officeOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (officeOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 3) {
      if (startDateOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (startDateOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 4) {
      if (endDateOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (endDateOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 5) {
      if (askingOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (askingOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 6) {
      if (totalLotOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (totalLotOrder == 1) {
        result = "assets/img/icon_arrow_up.png";
      }
    } else if (orderTypeListNum == 7) {
      if (lotOrder == 0) {
        result = "assets/img/icon_arrow_down.png";
      } else if (lotOrder == 1) {
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
      width: double.infinity,
      decoration: BoxDecoration(
        color: IdColors.backgroundDefault,
        border: Border.all(width: 1, color: IdColors.borderDefault),
      ),
      child: Row(
        children: [
          boardHeaderContent(5, 1, 'no', 'text', '', 0, 0),
          boardHeaderContent(3, 0, '선택', 'text', '', 0, 0),
          boardHeaderContent(7, 0, '이름', 'button', '', 1, nameOrder),
          boardHeaderContent(10, 0, '소속', 'button', '', 2, officeOrder),
          boardHeaderContent(13, 0, '등록일시', 'button', '', 3, startDateOrder),
          boardHeaderContent(13, 0, '만료일시', 'button', '', 4, endDateOrder),
          boardHeaderContent(27, 0, '주소', 'text', '', 0, 0),
          boardHeaderContent(8, 0, 'Asking', 'button', '억원', 5, askingOrder),
          boardHeaderContent(7, 0, '연면적', 'button', '㎡', 6, totalLotOrder),
          boardHeaderContent(7, 1, '대지면적', 'button', '㎡', 7, lotOrder),
        ],
      ),
    );
  }

  String imgPathStr(int row) {
    String result = '';
    if (checkBoxList.isNotEmpty) {
      if (checkBoxList[row]) {
        result = 'assets/img/icon_checkbox_checked.png';
      } else {
        result = 'assets/img/icon_checkbox_noneCheck.png';
      }
    } else {
      result = 'assets/img/icon_checkbox_noneCheck.png';
    }

    return result;
  }

  @override
  Widget build(BuildContext context) {
    uiCommon.setScreen(context);
    if (_dealDomiDs[0].data == null) {
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
    _dealDomiSvcDS = makeRows();

    var pages = _dealDomiSvcDS.isNotEmpty
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

    Widget boardGrid123 = _dealDomiSvcDS.isNotEmpty
        ? IdGrid(
            width: (webWidth - 50),
            internalGrid: false,
            headerColumns: const ['NO', '선택', '이름', '소속', '등록일', '만료일시', '주소', 'Asking', '연면적', '대지면적'],
            columnWidthsPercentages: const <double>[5, 3, 7, 10, 13, 13, 27, 8, 7, 7],
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
                          child: (cell == 1)
                              ? IdNormalBtn(
                                  onBtnPressed: () {
                                    if (checkBoxList[row] == true) {
                                      checkBoxList[row] = false;
                                      dealNoParamList.removeWhere((str) => str == content);
                                    } else {
                                      checkBoxList[row] = true;
                                      dealNoParamList.add(content);
                                    }

                                    setState(() {});
                                  },
                                  childWidget:
                                      IdImageBox(imagePath: imgPathStr(row), imageWidth: 16, imageHeight: 16, imageFit: BoxFit.cover),
                                )
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
              GV.pStrg.putXXX(Param_beforePage, 'dealDomi');
              GV.pStrg.putXXX(Param_dealNoString, dealNoList[index]);
              GV.pStrg.putXXX(Param_typeString, typeList[index]);
              GV.pStrg.putXXX(Param_dealDomiNoString, dealDomiNoList[index]);
              uiCommon.IdMovePage(context, PAGE_DEAL_DETAIL_PAGE);
              setState(() {});
            },
            data: _dealDomiSvcDS)
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
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: IdColors.ligthGreen,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        width: 1,
                        color: IdColors.borderDefault,
                      ),
                    ),
                    child: Row(
                      children: [
                        uiCommon.styledText('딜 등록일', 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                        datePickerBtn(_startDate.toString()),
                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                        uiCommon.styledText('-', 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                        const IdSpace(spaceWidth: 8, spaceHeight: 0),
                        datePickerBtn(_endDate.toString()),
                        const IdSpace(spaceWidth: 16, spaceHeight: 0),
                        dropdown1(_focusDropDown1, '선택하세요', _items1, changeDropdown1, 'searchType1'),
                        const IdSpace(spaceWidth: 16, spaceHeight: 0),
                        (searchType1.toUpperCase() == 'status'.toUpperCase() || searchType1.toUpperCase() == 'progress'.toUpperCase())
                            ? dropdown1(_focusDropDown2, '선택하세요', (searchType1.toUpperCase() == 'status'.toUpperCase()) ? _items2 : _items3,
                                changeDropdown2, 'searchType2')
                            : Container(
                                width: 140,
                                height: 40,
                                padding: EdgeInsets.fromLTRB(15, 4, 11, 4),
                                decoration: BoxDecoration(
                                  color: IdColors.backgroundDefault,
                                  border: Border.all(
                                    width: 1,
                                    color: IdColors.borderDefault,
                                  ),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: uiCommon.styledText('선택하세요', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
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
                            child: Center(child: uiCommon.styledText('검색', 16, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.center)),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const IdSpace(spaceWidth: 0, spaceHeight: 16),
                  //본문
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(24),
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
                                    IdSpace(spaceWidth: 16, spaceHeight: 0),
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
                                        IdSpace(spaceWidth: 8, spaceHeight: 0),
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
                        IdSpace(spaceWidth: 0, spaceHeight: 16),
                        boardHeader(),
                        SizedBox(
                          width: double.infinity,
                          child: boardGrid123,
                        ),
                        const IdSpace(spaceWidth: 0, spaceHeight: 16),
                        SizedBox(
                          width: double.infinity,
                          height: 40,
                          child: Row(
                            children: [
                              const Expanded(child: SizedBox()),
                              IdNormalBtn(
                                onBtnPressed: () {
                                  alertPopupVisible = true;

                                  setState(() {});
                                },
                                childWidget: Container(
                                  width: 135,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: IdColors.green,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Center(
                                    child: uiCommon.styledText('독점보호 승인', 16, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.center),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        const IdSpace(spaceWidth: 0, spaceHeight: 16),
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
              : const SizedBox(),
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
                        (dealNoParamList.isNotEmpty)
                            ? AlertPopup(
                                popupTitle: '독점보호 승인',
                                content: '${dealNoParamList.length}건의 딜의 독점승인을 진행하시겠습니까?',
                                onlyCloseFunction: () {
                                  alertPopupVisible = false;
                                  setState(() {});
                                },
                                activeFunction: () async {
                                  if (await setDomi()) {
                                    alertPopupVisible = false;
                                    fetchData();
                                  } else {
                                    GV.d('실패');
                                  }
                                })
                            : AlertPopup(
                                popupTitle: '에러',
                                content: '1건 이상의 요청된 딜을 체크해 주세요.',
                                onlyCloseFunction: () {
                                  alertPopupVisible = false;
                                  setState(() {});
                                },
                                activeFunction: () {
                                  alertPopupVisible = false;
                                  setState(() {});
                                }),
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
