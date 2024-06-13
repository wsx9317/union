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
import 'package:unionCDPP/id_widget/IdPageTopSection.dart';
import 'package:unionCDPP/id_widget/IdPagination.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:unionCDPP/modelVO/noticeResponse.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';

class _NoticeList {
  NoticeResponse? data;
}

class Notice extends StatefulWidget {
  const Notice({super.key});

  @override
  IdState<Notice> createState() => _NoticeState();
}

class _NoticeState extends IdState<Notice> {
  List<List<String>> _noticeSvcDS = [];
  List<_NoticeList> _noticeDs = [];
  List menuNavigator = [];
  List menuNavigatorLink = [];

  int currentRowsCnt = 0;
  int totalRowsCnt = 0;

  int totalPage = 0;
  int acturalPage = 1;

  String searchType = '';
  String searchVal = '';

  var _focusDropDown = FocusNode();
  bool changeDropdown = false;
  List<DropdownMenuItem> _items = [];

  TextEditingController _searchValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GV.pStrg.putXXX(Param_pageType, 'notice');
    _noticeDs.add(_NoticeList());
    GV.pStrg.putXXX(Param_nowPage, '현재페이지');
    menuNavigator = ['home', '공지사항'];
    menuNavigatorLink = [
      () {
        uiCommon.IdMovePage(context, PAGE_NOTICE_PAGE);
      }
    ];
    itemList();
    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
    _searchValueController.dispose();
  }

  Future<void> fetchData() async {
    final NoticeResponse? ret1 =
        await IdApi.getNotice(SearchOptionItme(rowSize: 10, page: acturalPage, searchType: searchType, searchVal: searchVal));
    if (ret1 != null) {
      _noticeDs[0].data = ret1;
      Map<String, dynamic> commonInfo = _noticeDs[0].data!.commonInfo!;
      totalRowsCnt = commonInfo['totalCnt'];
      if (totalRowsCnt % 10 == 0) {
        totalPage = int.tryParse((totalRowsCnt / 10).toString()) ?? 1;
      } else {
        totalPage = (int.tryParse((totalRowsCnt / 10).toString().split('.')[0]) ?? 1) + 1;
      }
    } else {
      _noticeDs[0].data = NoticeResponse(list: [], commonInfo: {});
    }
    setState(() {});
    makeRows();
  }

  List<List<String>> makeRows() {
    List<List<String>> results = [];
    // if (noticeList.isEmpty) return results;

    currentRowsCnt = 0;
    for (var i = 0; i < _noticeDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _noticeDs[0].data!.list![i];
      row1.add(item1.noticeNo.toString());
      row1.add(item1.title!);
      row1.add(item1.creator!);
      row1.add(item1.createDate!);
      results.add(row1);
    }
    currentRowsCnt = results.length;
    setState(() {});

    return results;
  }

  void itemList() {
    _items = [
      const DropdownMenuItem(
        value: '',
        child: Text('전체', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'title',
        child: Text('제목', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'content',
        child: Text('내용', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
  }

  Widget dropDown1(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown) {
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

  @override
  Widget idBuild(BuildContext context) {
    if (_noticeDs[0].data == null) {
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
    _noticeSvcDS = makeRows();

    var pages = _noticeSvcDS.isNotEmpty
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

    Widget boardGrid123 = _noticeSvcDS.isNotEmpty
        ? IdGrid(
            width: 1224,
            internalGrid: false,
            headerColumns: const ['NO', '제목', '작성자', '일시'],
            columnWidthsPercentages: const <double>[8, 69, 10, 13],
            headerBorderColor: const Color(0xffffff).withOpacity(0),
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 16,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 58,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 98,
            rowCnt: double.tryParse(currentRowsCnt.toString()) ?? 0,
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
            hoverColor: IdColors.green5,
            rowsCellRenderer: (row, cell, content) {
              return SizedBox(
                height: 98,
                // color: IdColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Text(content,
                          textAlign: (cell == 1) ? TextAlign.start : TextAlign.center,
                          maxLines: 2,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontFamily: 'Pretendard',
                            color: IdColors.textDefault,
                            fontSize: (cell == 0)
                                ? 18
                                : (cell == 1)
                                    ? 20
                                    : 16,
                          ),
                          softWrap: true),
                    ),
                  ],
                ),
              );
            },
            noContentWidget: const SizedBox(), //Center(child: Container(width: 30, height: 30, child: CircularProgressIndicator())),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              GV.pStrg.putXXX(Param_noticeNo, _noticeDs[0].data!.list![index].noticeNo.toString());
              GV.pStrg.putXXX(Param_nowPage, acturalPage.toString());
              setState(() {});
              uiCommon.IdMovePage(context, PAGE_NOTICE_DETAIL_PAGE);
            },
            data: _noticeSvcDS)
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
                        color: IdColors.pageTopBackground,
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 1224,
                            ),
                            child: Column(
                              children: [
                                IdTopNavigator(navigatorMenu: menuNavigator, navigatorLink: menuNavigatorLink),
                                const IdPageTopSection(
                                  menuName: 'NOTICE',
                                  pageDesc: '유용한 정보와 소식이\n알차게 준비되어 있습니다.',
                                  imgBoxWidget: IdImageBox(
                                      imagePath: 'assets/img/img_notice.png',
                                      imageWidth: 180.96,
                                      imageHeight: 253.41,
                                      imageFit: BoxFit.cover),
                                  navigator: SizedBox(),
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
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 1224),
                            child: Column(
                              children: [
                                const IdSpace(spaceWidth: 0, spaceHeight: 100),
                                //상단 검색
                                Stack(
                                  children: [
                                    const SizedBox(
                                      width: double.infinity,
                                      height: 44,
                                    ),
                                    Positioned(
                                      bottom: 0,
                                      left: 0,
                                      child: IdBoardCnt(currentCnt: currentRowsCnt, totalCnt: totalRowsCnt),
                                    ),
                                    Positioned(
                                      top: 0,
                                      right: 0,
                                      child: Row(
                                        children: [
                                          dropDown1(_focusDropDown, '선택', _items, changeDropdown),
                                          const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                          idSearchInputBox(searchType, _searchValueController),
                                          const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                          idSearchBtn(() {
                                            searchVal = _searchValueController.text;
                                            fetchData();
                                          }),
                                        ],
                                      ),
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
                                const IdSpace(spaceWidth: 0, spaceHeight: 156),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //풋터
                      idCommonFooter(),
                    ],
                  ),
                ),
                //헤더
                idCommonHeader(),
              ],
            ),
          ),
        ));
  }
}
