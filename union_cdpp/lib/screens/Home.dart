import 'dart:async';

import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdGrid.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdImageBox2.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPjtListDropdown.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/modelVO/dealCountItem.dart';
import 'package:unionCDPP/modelVO/myAlarmResponse.dart';
import 'package:unionCDPP/modelVO/myDealResponse.dart';
import 'package:unionCDPP/modelVO/myInfoItem.dart';
import 'package:unionCDPP/modelVO/noticeResponse.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:unionCDPP/modelVO/searchiInfoItem.dart';

class _MyDealList {
  MyDealResponse? data;
}

class _MyAlarmList {
  MyAlarmResponse? data;
}

class _NoticeList {
  NoticeResponse? data;
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  IdState<Home> createState() => _HomeState();
}

class _HomeState extends IdState<Home> {
  List<List<String>> _myDealSvcDS = [];
  List<_MyDealList> _myDealDs = [];
  List<List<String>> _myAlarmSvcDS = [];
  List<_MyAlarmList> _myAlarmDs = [];
  List<List<String>> _noticeSvcDS = [];
  List<_NoticeList> _noticeDs = [];

  MyInfoItem user1 = GV.myInfoItem;
  String userNo = '';

  List rowStatusList = [];
  List titleList1 = [];
  List createDateTimeList1 = [];
  List titleList2 = [];
  List createDateTimeList2 = [];

  //TODO 지금은 임의 데이터를 init에서 add할 예정
  List pjtNameList1 = [];
  List pjtColorList1 = [];
  List pjtNameList2 = [];
  List pjtColorList2 = [];
  List pjtNameList3 = [];
  List pjtColorList3 = [];

  int slideImgPage = 0;

  String normalCnt = '';
  String domiCnt = '';
  String endCnt = '';

  List dealNoList = [];
  List dealTypeList = [];
  List dealCategoryList = [];
  List dealImgList = [];
  List dealAddressList = [];
  List dealStatusList = [];
  List dealTitleList = [];

  List myAlarmLogNoList = [];
  List myAlarmStatusList = [];
  List myAlarmTitleList = [];
  List myAlarmContentList = [];
  List noticeNoList = [];

  PageController pageController = PageController();

  Timer? rotator;

  @override
  void dispose() {
    GV.d('dispose HomeScreen');
    rotator?.cancel();
    // html.window.removeEventListener(htmlListener);
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    GV.pStrg.putXXX(Param_pageType, 'dealPage');
    if (user1.isNotEmpty()) {
      userNo = user1.userNo!;
    }

    pageController = PageController(
      initialPage: slideImgPage,
    );
    _myDealDs.add(_MyDealList());
    _myAlarmDs.add(_MyAlarmList());
    _noticeDs.add(_NoticeList());
    //TODO 나중에 수정할 부분
    pjtNameList1 = [];
    pjtColorList1 = [];
    pjtNameList2 = [];
    pjtColorList2 = [];
    pjtNameList3 = [];
    pjtColorList3 = [];

    rotator = Timer.periodic(const Duration(milliseconds: 5000), (timer) {
      var prePage = slideImgPage;
      slideImgPage = (slideImgPage + 1) == 3 ? 0 : slideImgPage + 1;
      (prePage - slideImgPage).abs() == 1
          ? pageController.animateToPage(slideImgPage, duration: Duration(milliseconds: 350), curve: Curves.easeIn)
          : pageController.jumpToPage(slideImgPage);
      setState(() {});
    });
    fetchData();
  }

  Future<void> fetchData() async {
    final DealCountItem? ret1 = await IdApi.getDealCount(userNo);
    final MyDealResponse? ret2 =
        await IdApi.getMydael(userNo, SearchOptionItme(page: 1, rowSize: 3), SearchInfoItem(filterTypeList: ['MATCH']));
    final MyAlarmResponse? ret3 = await IdApi.getMyalarm(userNo, SearchOptionItme(page: 1, rowSize: 3, searchType: 'NOT_CHECK'));
    final NoticeResponse? ret4 = await IdApi.getNotice(SearchOptionItme(page: 1, rowSize: 3));

    if (ret1 != null) {
      normalCnt = ret1.normalCnt.toString();
      domiCnt = ret1.domiCnt.toString();
      endCnt = ret1.endCnt.toString();
    } else {
      normalCnt = 0.toString();
      domiCnt = 0.toString();
      endCnt = 0.toString();
    }

    if (ret2 != null) {
      _myDealDs[0].data = ret2;

      for (var i = 0; i < _myDealDs[0].data!.list!.length; i++) {
        pjtNameList1 = [];
        pjtNameList2 = [];
        pjtNameList3 = [];
        pjtColorList1 = [];
        pjtColorList2 = [];
        pjtColorList3 = [];
        if (_myDealDs[0].data!.list![i].s3FileUrl == null) {
          dealImgList.add('');
        } else {
          dealImgList.add('${_myDealDs[0].data!.list![i].s3FileUrl!}');
        }
        if (_myDealDs[0].data!.list![i].title == null) {
          dealTitleList.add('');
        } else {
          dealTitleList.add(_myDealDs[0].data!.list![i].title!);
        }
        dealNoList.add(_myDealDs[0].data!.list![i].dealNo!);
        dealTypeList.add(_myDealDs[0].data!.list![i].type!);
        dealCategoryList.add(_myDealDs[0].data!.list![i].category!);
        dealStatusList.add(_myDealDs[0].data!.list![i].statusNm!);
        dealAddressList.add('${_myDealDs[0].data!.list![i].address!} ${_myDealDs[0].data!.list![i].addressDtl!}');
        if (_myDealDs[0].data!.list!.length >= 1) {
          if (_myDealDs[0].data!.list![0].labelList != null) {
            for (var i = 0; i < _myDealDs[0].data!.list![0].labelList!.length; i++) {
              pjtNameList1.add(_myDealDs[0].data!.list![0].labelList![i].label);
              pjtColorList1.add(_myDealDs[0].data!.list![0].labelList![i].labelColor);
            }
          }
          if (_myDealDs[0].data!.list!.length >= 2) {
            if (_myDealDs[0].data!.list![1].labelList != null) {
              for (var i = 0; i < _myDealDs[0].data!.list![1].labelList!.length; i++) {
                pjtNameList2.add(_myDealDs[0].data!.list![1].labelList![i].label);
                pjtColorList2.add(_myDealDs[0].data!.list![1].labelList![i].labelColor);
              }
            }
            if (_myDealDs[0].data!.list!.length >= 3) {
              if (_myDealDs[0].data!.list![2].labelList != null) {
                for (var i = 0; i < _myDealDs[0].data!.list![2].labelList!.length; i++) {
                  pjtNameList3.add(_myDealDs[0].data!.list![2].labelList![i].label);
                  pjtColorList3.add(_myDealDs[0].data!.list![2].labelList![i].labelColor);
                }
              }
            }
          }
        }
      }
    } else {
      _myDealDs[0].data = MyDealResponse(list: []);
    }

    if (ret3 != null) {
      _myAlarmDs[0].data = ret3;
    } else {
      _myAlarmDs[0].data = MyAlarmResponse(list: []);
    }
    if (ret4 != null) {
      _noticeDs[0].data = ret4;
    } else {
      _noticeDs[0].data = NoticeResponse(list: []);
    }

    setState(() {});
  }

  List<List<String>> makeRows1() {
    List<List<String>> results = [];
    // if (noticeList.isEmpty) return results;

    for (var i = 0; i < _myAlarmDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _myAlarmDs[0].data!.list![i];
      setState(() {
        myAlarmLogNoList.add(item1.dealLogNo);
        myAlarmStatusList.add(item1.status);
        myAlarmTitleList.add(item1.title);
        myAlarmContentList.add(item1.etc);
        if (item1.status! == '0') {
          rowStatusList.add('일반');
        } else {
          rowStatusList.add('딜');
        }
        titleList1.add(item1.title);
        createDateTimeList1.add(item1.createDate);
      });
      row1.add(i.toString());
      results.add(row1);
    }

    return results;
  }

  List<List<String>> makeRows2() {
    List<List<String>> results = [];
    // if (noticeList.isEmpty) return results;

    for (var i = 0; i < _noticeDs[0].data!.list!.length; i++) {
      List<String> row1 = [];
      var item1 = _noticeDs[0].data!.list![i];
      setState(() {
        noticeNoList.add(item1.noticeNo);
        titleList2.add(item1.title);
        createDateTimeList2.add(item1.createDate);
      });
      row1.add(i.toString());
      results.add(row1);
    }

    return results;
  }

  Widget directLinkBtn(String btnTitle, Function() onPressed) {
    return IdNormalBtn(
      onBtnPressed: onPressed,
      childWidget: Row(
        children: [
          uiCommon.styledText(btnTitle, 14, 0, 1, FontWeight.w500, IdColors.textTertiary, TextAlign.left),
          const IdSpace(spaceWidth: 2, spaceHeight: 0),
          const IdImageBox(imagePath: 'assets/img/icon_movePage.png', imageWidth: 16, imageHeight: 16, imageFit: BoxFit.cover)
        ],
      ),
    );
  }

  Widget dashboardTitle(String title, double width, String linkTitle, Function() onPressed) {
    return SizedBox(
      width: width,
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              child: uiCommon.styledText(title, 18, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.left),
            ),
          ),
          directLinkBtn(linkTitle, onPressed)
        ],
      ),
    );
  }

  Widget cntWidget(String cnt, String title, int widgetNum) {
    return Stack(
      children: [
        const SizedBox(
          width: 188,
          height: 140,
        ),
        Positioned(
          top: 0,
          left: 24,
          child: Container(
            width: 140,
            height: 140,
            decoration: const BoxDecoration(shape: BoxShape.circle, color: IdColors.backgroundDefault),
          ),
        ),
        Positioned(
          top: 24,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              uiCommon.styledText(title, 16, 0, 1, FontWeight.w600, IdColors.green2, TextAlign.left),
              Row(
                children: [
                  uiCommon.styledText(cnt, 40, 0, 1.3, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                  const IdSpace(spaceWidth: 4, spaceHeight: 0),
                  uiCommon.styledText('건', 18, 0, 1.6, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                ],
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          right: 0,
          child: IdImageBox(
              imagePath: (widgetNum == 1)
                  ? 'assets/img/img_home_cnt_01.png'
                  : (widgetNum == 2)
                      ? 'assets/img/img_home_cnt_02.png'
                      : 'assets/img/img_home_cnt_03.png',
              imageHeight: 80,
              imageWidth: 80,
              imageFit: BoxFit.cover),
        )
      ],
    );
  }

  Widget matchingDeal(String imgPath, List pjtNameList, List pjtColorList, String address, String dealStatus, String dealTitle) {
    //각 매칭딜 정보
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            (imgPath != '')
                ? Container(
                    width: 210,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: IdColors.black8Per,
                    ),
                    child: IdImageBox2(imagePath: imgPath, imageWidth: 210, imageHeight: 140, round: 8, imageFit: BoxFit.fitHeight),
                  )
                : Container(
                    width: 210,
                    height: 140,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      color: IdColors.gray,
                    ),
                  ),
            const IdSpace(spaceWidth: 0, spaceHeight: 58),
            SizedBox(
              width: 210,
              child: uiCommon.styledText(address, 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
            ),
            const IdSpace(spaceWidth: 0, spaceHeight: 8),
            SizedBox(
              width: 210,
              height: 1,
              child: CustomPaint(
                painter: DashedLinePainter1(),
              ),
            ),
            const IdSpace(spaceWidth: 0, spaceHeight: 8),
            SizedBox(
              width: 210,
              child: uiCommon.styledText('[$dealStatus] $dealTitle', 14, 0, 1.6, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
            )
          ],
        ),
        Positioned(
          top: 164,
          left: 0,
          child: IdPjtDropdown(pjtDataList: pjtNameList, pjtDataColorList: pjtColorList, pageName: 'HOME'),
        ),
      ],
    );
  }

  Widget emptyData() {
    return Container(
      width: 332,
      height: 212,
      decoration: BoxDecoration(
        color: IdColors.backgroundDefault,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IdImageBox(imagePath: 'assets/img/icon_empty_data.png', imageWidth: 60, imageHeight: 60, imageFit: BoxFit.cover),
            IdSpace(spaceWidth: 0, spaceHeight: 16),
            uiCommon.styledText('게시물이 존재하지 않습니다.', 14, 0, 1.6, FontWeight.w400, IdColors.textTertiary, TextAlign.center)
          ],
        ),
      ),
    );
  }

  //TODO 슬라이드 이미지 관련
  Widget slideImg(int pageNum) {
    return (pageNum == 0)
        ? ClipRRect(
            borderRadius: BorderRadius.circular(24),
            child: IdImageBox(imagePath: 'assets/img/img_home_main_slide_01.png', imageFit: BoxFit.cover),
          )
        : Container(
            width: 624,
            height: 910,
            decoration: BoxDecoration(color: (pageNum == 1) ? IdColors.black : IdColors.red, borderRadius: BorderRadius.circular(24)),
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
    _myAlarmSvcDS = makeRows1();
    Widget boardGrid1 = _myAlarmSvcDS.isNotEmpty
        ? IdGrid(
            width: 332,
            internalGrid: false,
            headerColumns: const [''],
            columnWidthsPercentages: const <double>[100],
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 0,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 1,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 68,
            rowCnt: 3,
            headerBodyInterval: 0,
            rowDecoration: const BoxDecoration(
              border: Border(),
            ),
            rowInterval: 0,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowsCellRenderer: (row, cell, content) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        uiCommon.styledText(
                            rowStatusList[int.tryParse(content) ?? 0], 16, 0, 1.6, FontWeight.w700, IdColors.textDefault, TextAlign.left),
                        const IdSpace(spaceWidth: 4, spaceHeight: 0),
                        uiCommon.styledText(
                            (titleList1[int.tryParse(content) ?? 0].toString().length >= 25)
                                ? '${titleList1[int.tryParse(content) ?? 0].toString().substring(0, 25)}...'
                                : titleList1[int.tryParse(content) ?? 0],
                            16,
                            0,
                            1.6,
                            FontWeight.w400,
                            IdColors.textDefault,
                            TextAlign.left),
                      ],
                    ),
                    uiCommon.styledText(createDateTimeList1[int.tryParse(content) ?? 0], 16, 0, 1.6, FontWeight.w400, IdColors.textTertiary,
                        TextAlign.left),
                    IdSpace(spaceWidth: 0, spaceHeight: 4),
                    SizedBox(
                      width: double.infinity,
                      height: 1,
                      child: CustomPaint(
                        painter: DashedLinePainter1(),
                      ),
                    ),
                  ],
                ),
              );
            },
            noContentWidget: const SizedBox(),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              GV.pStrg.putXXX(Param_openMyalarmPop, 'Y');
              GV.pStrg.putXXX(Param_myAlarmLogNo, myAlarmLogNoList[index]);
              GV.pStrg.putXXX(Param_myAlarmStatus, myAlarmStatusList[index]);
              GV.pStrg.putXXX(Param_myAlarmTitle, myAlarmTitleList[index]);
              GV.pStrg.putXXX(Param_myalarmContent, myAlarmContentList[index]);

              uiCommon.IdMovePage(context, PAGE_MYALARM_PAGE);
              setState(() {});
            },
            data: _myAlarmSvcDS)
        :
        //데이터 없을때
        emptyData();

    _noticeSvcDS = makeRows2();
    Widget boardGrid2 = _noticeSvcDS.isNotEmpty
        ? IdGrid(
            width: 332,
            internalGrid: false,
            headerColumns: const [''],
            columnWidthsPercentages: const <double>[100],
            headerStyle: IdGrid.baseHeaderStyle.copyWith(
              fontSize: 0,
              color: IdColors.textDefault,
            ), //header font
            headerInternalGrid: false,
            headerHeight: 1,
            headerAlignmentByCells: (i) => Alignment.centerLeft,
            heightByRow: (i) => 68,
            rowCnt: 3,
            headerBodyInterval: 0,
            rowDecoration: const BoxDecoration(
              border: Border(),
            ),
            rowInterval: 0,
            alignmentByRow: (row, cell) => Alignment.centerLeft,
            rowsCellRenderer: (row, cell, content) {
              return SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const IdSpace(spaceWidth: 4, spaceHeight: 0),
                        uiCommon.styledText(
                            (titleList2[int.tryParse(content) ?? 0].toString().length >= 25)
                                ? '${titleList2[int.tryParse(content) ?? 0].toString().substring(0, 25)}...'
                                : titleList2[int.tryParse(content) ?? 0],
                            16,
                            0,
                            1.6,
                            FontWeight.w400,
                            IdColors.textDefault,
                            TextAlign.left),
                      ],
                    ),
                    uiCommon.styledText(createDateTimeList2[int.tryParse(content) ?? 0], 16, 0, 1.6, FontWeight.w400, IdColors.textTertiary,
                        TextAlign.left),
                    IdSpace(spaceWidth: 0, spaceHeight: 4),
                    SizedBox(
                      width: double.infinity,
                      height: 1,
                      child: CustomPaint(
                        painter: DashedLinePainter1(),
                      ),
                    ),
                  ],
                ),
              );
            },
            noContentWidget: const SizedBox(),
            rowCellsPadding: IdGrid.baseRowCellsPadding.copyWith(left: 2),
            onRowClick: (index) {
              GV.pStrg.putXXX(Param_noticeNo, noticeNoList[index]);
              uiCommon.IdMovePage(context, PAGE_NOTICE_DETAIL_PAGE);
              setState(() {});
            },
            data: _noticeSvcDS)
        :
        //데이터 없을때
        emptyData();

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
                      Stack(
                        children: [
                          Container(
                            width: double.infinity,
                            height: 1050,
                            color: IdColors.green2,
                            child: const IdImageBox(
                                imagePath: 'assets/img/img_home_main.png', imageWidth: double.infinity, imageFit: BoxFit.fitWidth),
                          ),
                          Positioned(
                            top: 114,
                            left: 0,
                            right: 0,
                            child: SizedBox(
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Stack(
                                      children: [
                                        Container(
                                          width: 624,
                                          height: 907,
                                          decoration: BoxDecoration(color: IdColors.black, borderRadius: BorderRadius.circular(24)),
                                          child: PageView(
                                            clipBehavior: Clip.none,
                                            controller: pageController,
                                            onPageChanged: (pageIndex) {
                                              slideImgPage = pageIndex;
                                            },
                                            children: [
                                              slideImg(0),
                                              slideImg(1),
                                              slideImg(2),
                                            ],
                                          ),
                                        ),
                                        Positioned(
                                          child: Container(
                                            width: 624,
                                            height: 830,
                                            padding: const EdgeInsets.fromLTRB(60, 50, 60, 0),
                                            decoration: const BoxDecoration(
                                              gradient: LinearGradient(
                                                begin: Alignment.topCenter,
                                                end: Alignment.bottomCenter,
                                                colors: [
                                                  Color.fromRGBO(0, 0, 0, 0.5),
                                                  Color.fromRGBO(0, 0, 0, 0.4),
                                                  Color.fromRGBO(0, 0, 0, 0.1),
                                                  Color.fromRGBO(0, 0, 0, 0)
                                                ],
                                              ),
                                              borderRadius: BorderRadius.vertical(
                                                top: Radius.circular(24),
                                              ),
                                            ),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                uiCommon.styledText(
                                                    '도심속 작은 숲을 품은', 24, 0, 1.6, FontWeight.w700, IdColors.white, TextAlign.justify),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 8),
                                                uiCommon.styledText('백련 타운하우스의\n건물주를 모집합니다.', 40, 0, 1.3, FontWeight.w700, IdColors.white,
                                                    TextAlign.justify),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 72),
                                                IdNormalBtn(
                                                  childWidget: Container(
                                                    width: 226,
                                                    height: 44,
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                        width: 1,
                                                        color: IdColors.white,
                                                      ),
                                                      borderRadius: BorderRadius.circular(8),
                                                    ),
                                                    child: Center(
                                                      child: uiCommon.styledText(
                                                          '프로젝트 상세 내용 확인하기', 16, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
                                                    ),
                                                  ),
                                                ),
                                                const IdSpace(spaceWidth: 0, spaceHeight: 80),
                                                Row(
                                                  children: List.generate(
                                                    3,
                                                    (index) => Row(
                                                      children: [
                                                        IdNormalBtn(
                                                          onBtnPressed: () {
                                                            slideImgPage = index;
                                                            pageController.animateToPage(
                                                              slideImgPage,
                                                              duration: Duration(milliseconds: 350),
                                                              curve: Curves.easeIn,
                                                            );
                                                            setState(() {});
                                                          },
                                                          childWidget: (index == slideImgPage)
                                                              ? Container(
                                                                  width: 24,
                                                                  height: 6,
                                                                  decoration: BoxDecoration(
                                                                    color: IdColors.white,
                                                                    borderRadius: BorderRadius.circular(18),
                                                                  ),
                                                                )
                                                              : Opacity(
                                                                  opacity: 0.6,
                                                                  child: Container(
                                                                    width: 6,
                                                                    height: 6,
                                                                    decoration:
                                                                        BoxDecoration(color: IdColors.white, shape: BoxShape.circle),
                                                                  ),
                                                                ),
                                                        ),
                                                        IdSpace(spaceWidth: 6, spaceHeight: 0)
                                                      ],
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const IdSpace(spaceWidth: 16, spaceHeight: 0),
                                    Container(
                                      height: 907,
                                      constraints: const BoxConstraints(
                                        maxWidth: 800,
                                      ),
                                      padding: const EdgeInsets.fromLTRB(50, 60, 40, 60),
                                      decoration: BoxDecoration(color: IdColors.white, borderRadius: BorderRadius.circular(24)),
                                      child: Column(
                                        children: [
                                          //딜 카운트
                                          Row(
                                            children: [
                                              cntWidget(normalCnt, '일반 딜', 1),
                                              const IdSpace(spaceWidth: 48, spaceHeight: 0),
                                              cntWidget(domiCnt, '안심중개권 딜', 2),
                                              const IdSpace(spaceWidth: 48, spaceHeight: 0),
                                              cntWidget(endCnt, '완료 딜', 3),
                                            ],
                                          ),
                                          const IdSpace(spaceWidth: 0, spaceHeight: 24),
                                          //매칭 딜
                                          Column(
                                            children: [
                                              dashboardTitle('매칭 딜', double.infinity, '매칭 딜 전체보기', () {
                                                uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
                                              }),
                                              const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                              SizedBox(
                                                width: double.infinity,
                                                height: 311,
                                                child: (dealTitleList.isNotEmpty)
                                                    ? Row(
                                                        children: List.generate(
                                                          dealImgList.length,
                                                          (index) => Row(
                                                            children: [
                                                              IdNormalBtn(
                                                                  onBtnPressed: () {
                                                                    GV.pStrg.putXXX(Param_myDealNo, dealNoList[index]);
                                                                    GV.pStrg.putXXX(Param_dealType, dealTypeList[index]);
                                                                    GV.pStrg.putXXX(Param_dealCategory, dealCategoryList[index]);
                                                                    uiCommon.IdMovePage(context, PAGE_MYDEAL_DETAIL_PAGE);
                                                                  },
                                                                  childWidget: matchingDeal(
                                                                      dealImgList[index],
                                                                      (index == 0)
                                                                          ? pjtNameList1
                                                                          : (index == 1)
                                                                              ? pjtNameList2
                                                                              : pjtNameList3,
                                                                      (index == 0)
                                                                          ? pjtColorList1
                                                                          : (index == 1)
                                                                              ? pjtColorList2
                                                                              : pjtColorList3,
                                                                      dealAddressList[index],
                                                                      dealStatusList[index],
                                                                      dealTitleList[index])),
                                                              (index != dealImgList.length - 1)
                                                                  ? const IdSpace(spaceWidth: 24, spaceHeight: 0)
                                                                  : SizedBox(),
                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    : Container(
                                                        width: double.infinity,
                                                        height: double.infinity,
                                                        decoration: BoxDecoration(
                                                          color: IdColors.backgroundDefault,
                                                          borderRadius: BorderRadius.circular(8),
                                                        ),
                                                        child: Column(
                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                          children: [
                                                            IdImageBox(
                                                                imagePath: 'assets/img/icon_empty_data.png',
                                                                imageWidth: 60,
                                                                imageHeight: 60,
                                                                imageFit: BoxFit.cover),
                                                            IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                            uiCommon.styledText('게시물이 존재하지 않습니다.', 14, 0, 1.6, FontWeight.w400,
                                                                IdColors.textTertiary, TextAlign.center)
                                                          ],
                                                        ),
                                                      ),
                                              ),
                                              const IdSpace(spaceWidth: 0, spaceHeight: 32),
                                              Row(
                                                children: [
                                                  //미확인 알림
                                                  Column(
                                                    children: [
                                                      dashboardTitle('미확인 알림', 332, '전체보기', () {
                                                        uiCommon.IdMovePage(context, PAGE_MYALARM_PAGE);
                                                      }),
                                                      const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                      boardGrid1,
                                                    ],
                                                  ),
                                                  IdSpace(spaceWidth: 16, spaceHeight: 0),
                                                  //공지사항
                                                  Column(
                                                    children: [
                                                      dashboardTitle('공지사항', 332, '전체보기', () {
                                                        uiCommon.IdMovePage(context, PAGE_NOTICE_PAGE);
                                                      }),
                                                      const IdSpace(spaceWidth: 0, spaceHeight: 16),
                                                      boardGrid2,
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      idCommonFooter(),
                    ],
                  ),
                ),
                //헤더
                idCommonHeader(),
                idFloatDealRegistBtn(),
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
