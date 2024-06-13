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
import 'package:unionCDPP/modelVO/faqResponse.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';

class _FaqList {
  FaqResponse? data;
}

class FAQ extends StatefulWidget {
  const FAQ({super.key});

  @override
  IdState<FAQ> createState() => _FAQState();
}

class _FAQState extends IdState<FAQ> {
  List<List<String>> _faqSvcDS = [];
  List<_FaqList> _faqDs = [];
  List menuNavigator = [];
  List menuNavigatorLink = [];

  int currentRowsCnt = 0;
  int totalRowsCnt = 0;

  int totalPage = 0;
  int acturalPage = 1;

  String searchType = '';
  String searchValue = '';

  var _focusDropDown = FocusNode();
  bool changeDropdown = false;
  List<DropdownMenuItem> _items = [];

  List seqList = [];
  List categoryList = [];
  List questionList = [];
  List answerList = [];
  List answerDescList = [];
  List contentList = [];

  int clickNumber = 0;

  TextEditingController _searchValueController = TextEditingController();

  @override
  void initState() {
    super.initState();
    GV.pStrg.putXXX(Param_pageType, 'faq');
    _faqDs.add(_FaqList());
    menuNavigator = ['home', 'FAQ'];
    menuNavigatorLink = [
      () {
        uiCommon.IdMovePage(context, PAGE_FAQ_PAGE);
      }
    ];
    itemList();
    fetchData();
  }

  Future<void> fetchData() async {
    final FaqResponse? ret1 =
        await IdApi.getFaq(SearchOptionItme(rowSize: 10, page: acturalPage, searchType: searchType, searchVal: searchValue));
    if (ret1 != null) {
      _faqDs[0].data = ret1;

      totalRowsCnt = _faqDs[0].data!.commonInfo!['totalCnt'];
      if (totalRowsCnt % 10 == 0) {
        totalPage = int.tryParse((totalRowsCnt / 10).toString()) ?? 1;
      } else {
        totalPage = (int.tryParse((totalRowsCnt / 10).toString().split('.')[0]) ?? 1) + 1;
      }
    }
    makeRows();
    setState(() {});
  }

  List<List<String>> makeRows() {
    List<List<String>> results = [];
    seqList = [];
    categoryList = [];
    questionList = [];
    answerList = [];
    answerDescList = [];
    contentList = [];
    currentRowsCnt = 0;
    for (var i = 0; i < _faqDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _faqDs[0].data!.list![i];
      setState(() {
        seqList.add(item1.faqNo);
        categoryList.add(item1.section);
        questionList.add(item1.question);
        answerList.add(item1.answer);
        answerDescList.add(item1.answerDesc);

        contentList.add(i);
      });
      row1.add(i.toString());
      results.add(row1);
    }
    currentRowsCnt = results.length;
    return results;
  }

  void itemList() {
    _items = [
      const DropdownMenuItem(
        value: '',
        child: Text('전체', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'question',
        child: Text('질문', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
      const DropdownMenuItem(
        value: 'answer',
        child: Text('답변', style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ),
    ];
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
    if (_faqDs[0].data == null) {
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
    _faqSvcDS = makeRows();

    var pages = _faqSvcDS.isNotEmpty
        ?

        // Idpagination2(totalPageCnt: totalListCnt)

        IdPaginationWidget(
            buttonColor: const Color.fromRGBO(0, 0, 0, 0),
            buttonTextColor: IdColors.black,
            buttonFontSize: 18,
            actualPage: acturalPage,
            countToDisplay: 10,
            totalPages: totalPage,
            onPageChange: (page) async {
              print(page);
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

    Widget boardGrid123 = _faqSvcDS.isNotEmpty
        ? IdGrid(
            width: 1224,
            internalGrid: false,
            headerColumns: const [''],
            columnWidthsPercentages: const <double>[100],
            headerDecoration: const BoxDecoration(
              border: Border(
                top: BorderSide(color: IdColors.black, width: 2),
              ),
            ),
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 0,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 1,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => (clickNumber == i + 1) ? 300 : 191,
            rowCnt: double.tryParse(currentRowsCnt.toString()) ?? 0,
            headerBodyInterval: 0,
            rowDecoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(width: 1, color: IdColors.borderDefault),
              ),
            ),
            rowInterval: 0,
            rowColor: IdColors.white,
            hoverColor: IdColors.green4,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowsCellRenderer: (row, cell, content) {
              return Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const IdSpace(spaceWidth: 0, spaceHeight: 37),
                    uiCommon.styledText(
                        categoryList[int.tryParse(content) ?? 1], 16, 0.14, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                    const IdSpace(spaceWidth: 0, spaceHeight: 12),
                    SizedBox(
                      width: double.infinity,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: SizedBox(
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      uiCommon.styledText('Q.', 20, 0, 1.6, FontWeight.w800, IdColors.green1, TextAlign.left),
                                      const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                        child: uiCommon.styledText(questionList[int.tryParse(content) ?? 0], 20, 0, 1.6, FontWeight.w800,
                                            IdColors.textDefault, TextAlign.left),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              IdImageBox(
                                  imagePath: (clickNumber == row + 1) ? 'assets/img/icon_fold.png' : 'assets/img/icon_expand.png',
                                  imageWidth: 24,
                                  imageHeight: 24,
                                  imageFit: BoxFit.cover),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: (clickNumber == row + 1) ? true : false,
                      child: Column(
                        children: [
                          const IdSpace(spaceWidth: 0, spaceHeight: 16),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 28),
                            decoration: BoxDecoration(
                              color: IdColors.green5,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    uiCommon.styledText('A.', 20, 0, 1.6, FontWeight.w800, IdColors.textDefault, TextAlign.left),
                                    const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 1.5),
                                      child: uiCommon.styledText(answerList[int.tryParse(content) ?? 0], 18, 0, 1.6, FontWeight.w400,
                                          IdColors.textDefault, TextAlign.left),
                                    ),
                                  ],
                                ),
                                uiCommon.styledText(answerDescList[int.tryParse(content) ?? 0], 18, 0, 1.6, FontWeight.w400,
                                    IdColors.textDefault, TextAlign.left),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                    const IdSpace(spaceWidth: 0, spaceHeight: 32),
                  ],
                ),
              );
            },
            noContentWidget: const SizedBox(),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              if (clickNumber == index + 1) {
                clickNumber = 0;
              } else {
                clickNumber = index + 1;
              }
              setState(() {});
            },
            data: _faqSvcDS)
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
                                  menuName: 'FAQ',
                                  pageDesc: '자주묻는 질문으로\n궁금증을 해소해보세요!',
                                  imgBoxWidget: IdImageBox(
                                      imagePath: 'assets/img/img_FAQ.png', imageWidth: 231.13, imageHeight: 241.16, imageFit: BoxFit.cover),
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
                                            searchValue = _searchValueController.text;
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
                                const IdSpace(spaceWidth: 0, spaceHeight: 200),
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
                idCommonHeader()
              ],
            ),
          ),
        ));
  }
}
