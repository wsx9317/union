import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdBoardCnt.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdGrid.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageTopSection.dart';
import 'package:unionCDPP/id_widget/IdPagination.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdSubNavigator.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:unionCDPP/modelVO/myAlarmResponse.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';
import 'package:unionCDPP/popup/myAlarmPopup_01.dart';
import 'package:unionCDPP/popup/myAlarmPopup_02.dart';

class _MyAlarmList {
  MyAlarmResponse? data;
}

class MyAlarm extends StatefulWidget {
  const MyAlarm({super.key});

  @override
  IdState<MyAlarm> createState() => _MyAlarmState();
}

class _MyAlarmState extends IdState<MyAlarm> {
  List<List<String>> _myAlarmSvcDS = [];
  List<_MyAlarmList> _myAlarmDs = [];
  List menuNavigator = [];
  List menuNavigatorLink = [];
  List submenuNameList = [];
  List submenuNavigatorLink = [];

  String userNo = GV.pStrg.getXXX(Param_commonUserNo);
  String dealLogNo = '';

  int currentRows = 0;
  int totalRowsCnt = 0;

  int totalPage = 0;
  int acturalPage = 1;

  String normalPopupTitle = '';
  String normalPopupContent = '';

  String dealPopupTitle = '';
  String dealPopupContent = '';

  List rowStatusList = [];

  bool popup01Visible = false;
  bool popup02Visible = false;

  var _focusDropDown = FocusNode();
  bool changeDropdown = false;
  List<DropdownMenuItem> _items = [];

  String searchType = '';
  String searchValue = '';

  TextEditingController _searchValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _myAlarmDs.add(_MyAlarmList());

    menuNavigator = ['home', 'My Page', '알림'];
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
    openPagePopup();
    itemList();
    fetchData();
  }

  Future<void> fetchData() async {
    final MyAlarmResponse? ret1 =
        await IdApi.getMyalarm(userNo, SearchOptionItme(rowSize: 10, page: acturalPage, searchType: searchType, searchVal: searchValue));

    if (ret1 != null) {
      _myAlarmDs[0].data = ret1;
      Map<String, dynamic> commonInfo = _myAlarmDs[0].data!.commonInfo!;
      totalRowsCnt = commonInfo['totalCnt'];
      if (totalRowsCnt % 10 == 0) {
        totalPage = int.tryParse((totalRowsCnt / 10).toString()) ?? 1;
      } else {
        totalPage = (int.tryParse((totalRowsCnt / 10).toString().split('.')[0]) ?? 1) + 1;
      }
    } else {
      _myAlarmDs[0].data = MyAlarmResponse(list: []);
    }
    setState(() {});
  }

  Future<void> openPagePopup() async {
    if (GV.pStrg.getXXX(Param_openMyalarmPop) == 'Y') {
      dealLogNo = GV.pStrg.getXXX(Param_myAlarmLogNo);
      dealPopupTitle = GV.pStrg.getXXX(Param_myAlarmTitle);
      dealPopupContent = GV.pStrg.getXXX(Param_myalarmContent);
      if (await updateCheck()) {
        if (GV.pStrg.getXXX(Param_myAlarmStatus) == '0') {
          popup01Visible = true;
          popup02Visible = false;
        } else {
          popup01Visible = false;
          popup02Visible = true;
        }
      }
    } else {
      popup01Visible = false;
      popup02Visible = false;
    }
  }

  void itemList() {
    _items = [
      const DropdownMenuItem(
        value: '',
        child: Text('전체', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'NORMAL',
        child: Text('일반', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'DEAL',
        child: Text('딜', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
  }

  Future<bool> updateCheck() async {
    final result = await IdApi.updateMyalarm(userNo, dealLogNo);
    if (result == null) return false;
    return true;
  }

  List<List<String>> makeRows() {
    List<List<String>> results = [];
    // if (noticeList.isEmpty) return results;

    currentRows = 0;
    for (var i = 0; i < _myAlarmDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _myAlarmDs[0].data!.list![i];
      if (item1.status! == '0') {
        row1.add('일반');
        rowStatusList.add('일반');
      } else {
        row1.add('딜');
        rowStatusList.add('딜');
      }
      row1.add(item1.title!);
      row1.add(item1.checkYn!);

      row1.add(item1.createDate!);

      results.add(row1);
    }
    currentRows = results.length;
    setState(() {});

    return results;
  }

  Widget topDropDownBtn(Function() onPresedBtn, Widget childWidget, Color btnColor, Color borderColor) {
    return IdNormalBtn(
      onBtnPressed: onPresedBtn,
      childWidget: Container(
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

  Widget dropDown1(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown) {
    return Container(
      width: 112,
      height: 44,
      padding: const EdgeInsets.symmetric(vertical: 9),
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

  @override
  Widget idBuild(BuildContext context) {
    if (_myAlarmDs[0].data == null) {
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
    _myAlarmSvcDS = makeRows();

    var pages = _myAlarmSvcDS.isNotEmpty
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

    Widget boardGrid123 = _myAlarmSvcDS.isNotEmpty
        ? IdGrid(
            width: 1224,
            internalGrid: false,
            headerColumns: const ['구분', '제목', '상태', '일시'],
            columnWidthsPercentages: const <double>[8, 69, 10, 13],
            headerBorderColor: IdColors.borderDefault,
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 16,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 58,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 98,
            rowCnt: double.tryParse(currentRows.toString()) ?? 0,
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
            rowColor: IdColors.green1,
            rowsCellRenderer: (row, cell, content) {
              return SizedBox(
                height: 98,
                // color: IdColors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    (cell == 2)
                        ? Container(
                            decoration: BoxDecoration(
                              color: (content == 'Y') ? IdColors.white : IdColors.orange5,
                              border: Border.all(width: 1, color: IdColors.borderDefault),
                              borderRadius: BorderRadius.circular(40),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                              child: uiCommon.styledText((content == 'Y') ? '확인' : '미확인', 16, 0, 0, FontWeight.w500,
                                  (content == 'Y') ? IdColors.textTertiary : IdColors.orange1, TextAlign.left),
                            ),
                          )
                        : Expanded(
                            child: Text(content,
                                textAlign: (cell == 1) ? TextAlign.start : TextAlign.center,
                                maxLines: 2,
                                style: TextStyle(
                                  fontWeight: (cell == 0) ? FontWeight.w700 : FontWeight.w400,
                                  fontFamily: 'Pretendard',
                                  color: (cell == 0 && content == '딜')
                                      ? IdColors.green2
                                      : (cell == 3)
                                          ? IdColors.textTertiary
                                          : IdColors.textDefault,
                                  fontSize: (cell == 3) ? 16 : 18,
                                ),
                                softWrap: true),
                          ),
                  ],
                ),
              );
            },
            noContentWidget: const SizedBox(), //Center(child: Container(width: 30, height: 30, child: CircularProgressIndicator())),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) async {
              dealLogNo = _myAlarmDs[0].data!.list![index].dealLogNo!;
              if (await updateCheck()) {
                if (_myAlarmDs[0].data!.list![index].status == '0') {
                  popup01Visible = true;
                  normalPopupTitle = _myAlarmDs[0].data!.list![index].title!;
                  if (normalPopupTitle.contains('회원가입')) {
                    normalPopupContent = GV.pStrg.getXXX(Param_commonUserId) + _myAlarmDs[0].data!.list![index].etc!;
                  } else {
                    normalPopupContent = _myAlarmDs[0].data!.list![index].etc!;
                  }
                } else {
                  popup02Visible = true;
                  dealPopupTitle = _myAlarmDs[0].data!.list![index].title!;
                  dealPopupContent = _myAlarmDs[0].data!.list![index].etc!;
                }
              }

              setState(() {});
            },
            data: _myAlarmSvcDS)
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
                                  navigator: IdSubNavigator(pageName: '알림', subMenu: submenuNameList, subMenuLink: submenuNavigatorLink),
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
                            Container(
                              constraints: const BoxConstraints(maxWidth: 1224),
                              child: Column(
                                children: [
                                  const IdSpace(spaceWidth: 0, spaceHeight: 100),
                                  Stack(
                                    children: [
                                      const SizedBox(
                                        width: double.infinity,
                                        height: 44,
                                      ),
                                      Positioned(
                                        top: 0,
                                        left: 0,
                                        child: IdBoardCnt(currentCnt: currentRows, totalCnt: totalRowsCnt),
                                      ),
                                      Positioned(
                                        top: 0,
                                        right: 0,
                                        child: Row(
                                          children: [
                                            dropDown1(_focusDropDown, '전체', _items, changeDropdown),
                                            const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                            idSearchInputBox(searchType, _searchValueController),
                                            const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                            idSearchBtn(() {
                                              searchValue = _searchValueController.text;
                                              fetchData();
                                            }),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const IdSpace(spaceWidth: 0, spaceHeight: 24),
                                  SizedBox(
                                    width: double.infinity,
                                    child: boardGrid123,
                                  ),
                                  const IdSpace(spaceWidth: 0, spaceHeight: 24),
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
                                  const IdSpace(spaceWidth: 0, spaceHeight: 180),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      //푸터
                      idCommonFooter(),
                    ],
                  ),
                ),
                //헤더
                idCommonHeader(),
                Visibility(
                  visible: popup01Visible,
                  child: MyAlarmPopup_01(
                    closeFunction: () {
                      if (popup01Visible) {
                        popup01Visible = false;
                      } else {
                        popup01Visible = true;
                      }
                      GV.pStrg.putXXX(Param_openMyalarmPop, 'N');
                      GV.pStrg.putXXX(Param_myAlarmLogNo, '알람로그넘버');
                      GV.pStrg.putXXX(Param_myAlarmStatus, '알람상태');
                      GV.pStrg.putXXX(Param_myAlarmTitle, '알람타이틀');
                      GV.pStrg.putXXX(Param_myalarmContent, '알람컨텐츠');
                      setState(() {});
                      // fetchData();
                      uiCommon.IdMovePage(context, PAGE_MYALARM_PAGE);
                    },
                    title: normalPopupTitle,
                    content: normalPopupContent,
                  ),
                ),
                Visibility(
                  visible: popup02Visible,
                  child: MyAlarmPopup_02(
                    closeFunction: () {
                      if (popup02Visible) {
                        popup02Visible = false;
                      } else {
                        popup02Visible = true;
                      }

                      GV.pStrg.putXXX(Param_openMyalarmPop, 'N');
                      GV.pStrg.putXXX(Param_myAlarmLogNo, '알람로그넘버');
                      GV.pStrg.putXXX(Param_myAlarmStatus, '알람상태');
                      GV.pStrg.putXXX(Param_myAlarmTitle, '알람타이틀');
                      GV.pStrg.putXXX(Param_myalarmContent, '알람컨텐츠');
                      setState(() {});
                      fetchData();
                    },
                    title: dealPopupTitle,
                    content: dealPopupContent,
                    dealCheckLink: () {},
                  ),
                ),
              ],
            ),
          ),
        ));
  }
  

  
  
}
