import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/common/utils.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDivider.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:flutter/material.dart';
import 'package:unionCDPP/modelVO/myAlarmResponse.dart';
import 'package:unionCDPP/modelVO/myInfoItem.dart';
import 'package:unionCDPP/modelVO/search_option_item.dart';
import 'package:webviewx_plus/webviewx_plus.dart';
import 'dart:html' as html;
import 'package:flutter_svg/flutter_svg.dart';
import '../screens/HtmlWebPage.dart';

class _MyAlarmList {
  MyAlarmResponse? data;
}

class IdCommonHeader extends StatefulWidget {
  final Color? backgroundColor;
  const IdCommonHeader({super.key, this.backgroundColor});

  @override
  State<IdCommonHeader> createState() => _IdCommonHeaderState();
}

class _IdCommonHeaderState extends State<IdCommonHeader> {

  List<_MyAlarmList> _myAlarmDs = [];
  double screenWidth = GV.screen.width;
  double screenHeight = GV.screen.height;
  MyInfoItem user1 = GV.myInfoItem;

  double webWidth = 0;

  String userNo = '';
  int grade = 0;
  String office = '';
  String userName = 'guest';
  String userId = 'guest';
  String alarm = '';

  List subMenuNameList = ['내 정보', '내가 등록한 딜', '알림', '로그아웃'];
  List subMenuLinkList = [];

  bool submenuVisible = false;

  @override
  void initState() {
    super.initState();

    if (user1.isNotEmpty()) {
      grade = int.tryParse(user1.grade!) ?? 1;
      office = user1.office!;
      userName = user1.userName!;
      userId = user1.userId!;
      if (userId.startsWith("NAVER_")) {
        userId = "네이버회원";
      } else if (userId.startsWith("KAKAO_")) {
        userId = "카카오회원";
      }
      userNo = user1.userNo!;
      GV.pStrg.putXXX(Param_commonUserId, userId);
      GV.pStrg.putXXX(Param_commonUserNo, userNo);
      GV.pStrg.putXXX(Param_commonUserName, userName);
      GV.pStrg.putXXX(Param_commonUserOffice, office);
      // if (user1.newsPushYn == null) {
      //   alarm = '';
      // } else {
      //   // alarm = user1.newsPushYn!;
      // }
      setState(() {});
    }
    _myAlarmDs.add(_MyAlarmList());

    GV.pStrg.putXXX(Param_commonUserNo, userNo);
    fetchData();
  }

  Future<void> fetchData() async {
    final dynamic ret2 = await IdApi.getMyalarm(userNo, SearchOptionItme(page: 1, rowSize: 1));
    if (ret2 != null) {
      _myAlarmDs[0].data = ret2;
      if (_myAlarmDs[0].data!.list!.isNotEmpty && _myAlarmDs[0].data!.list![0].checkYn == 'Y') {
        // if (_myAlarmDs[0].data!.list!.isNotEmpty && _myAlarmDs[0].data!.list![0].checkYn == 'Y' && user1.newsPushYn == 'Y') {
        alarm = 'Y';
      } else {
        alarm = 'N';
      }
    }
  }

  Widget subMenuBtn(String btnName, Function() onPressed) {
    return IdNormalBtn(
      onBtnPressed: onPressed,
      childWidget: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        width: 96,
        child: uiCommon.styledText(btnName, 14, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
      ),
    );
  }

  String userGradeStr(int grade) {
    String result = '';
    if (grade == 1) {
      result = '일반회원';
    } else if (grade == 2) {
      result = '정회원';
    } else if (grade == 3) {
      result = '준회원';
    } else {
      result = '손님';
    }
    return result;
  }

  Widget headerLogo() {
    return IdNormalBtn(
      onBtnPressed: () {
        user1.isNotEmpty() ? uiCommon.IdMovePage(context, PAGE_HOME_PAGE) : 1 == 1;
      },
      childWidget: SvgPicture.asset(
        (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? 'assets/img/logo_black.svg' : 'assets/img/logo.svg',
        semanticsLabel: 'SVG Image',
        placeholderBuilder: (BuildContext context) => CircularProgressIndicator(),
        fit: BoxFit.cover,
        width: 146,
        height: 44,
      ),
      // IdImageBox(
      //     imagePath: (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? 'assets/img/logo_black.svg' : 'assets/img/logo.svg',
      //     imageWidth: 146,
      //     imageHeight: 44,
      //     imageFit: BoxFit.cover),
    );
  }

  Widget headerMenu() {
    return SizedBox(
      child: Row(
        children: [
          IdNormalBtn(
            onBtnPressed: () {
              user1.isNotEmpty() ? uiCommon.IdMovePage(context, PAGE_LOGGED_INTRO) : uiCommon.IdMovePage(context, PAGE_INTRO);
            },
            childWidget: uiCommon.styledText('서비스 소개', 18, 0, 1.6, FontWeight.w700,
                (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.textDefault : IdColors.white, TextAlign.left),
          ),
          const IdSpace(spaceWidth: 40, spaceHeight: 0),
          IdNormalBtn(
            onBtnPressed: () {
              user1.isNotEmpty() ? uiCommon.IdMovePage(context, PAGE_LOGGED_INTRO2) : uiCommon.IdMovePage(context, PAGE_INTRO2);
            },
            childWidget: uiCommon.styledText('이용안내', 18, 0, 1.6, FontWeight.w700,
                (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.textDefault : IdColors.white, TextAlign.left),
          ),
          const IdSpace(spaceWidth: 40, spaceHeight: 0),
          IdNormalBtn(
            onBtnPressed: () {
              user1.isNotEmpty() ? uiCommon.IdMovePage(context, PAGE_LOGGED_INTRO3) : uiCommon.IdMovePage(context, PAGE_INTRO3);
            },
            childWidget: uiCommon.styledText('파트너스', 18, 0, 1.6, FontWeight.w700,
                (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.textDefault : IdColors.white, TextAlign.left),
          ),
          IdSpace(spaceWidth: 100, spaceHeight: 0)
        ],
      ),
    );
  }

  Widget headerMember() {
    return Row(
      children: [
        Container(
          width: userGradeStr(grade).length >= 4 ? 88 : 78,
          height: 26,
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
          decoration: ShapeDecoration(
            color: IdColors.textDefault,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IdImageBox(imagePath: 'assets/img/icon_user.png', imageWidth: 14, imageHeight: 14, imageFit: BoxFit.cover),
              const IdSpace(spaceWidth: 4, spaceHeight: 0),
              uiCommon.styledText(userGradeStr(grade), 14, 0, 1, FontWeight.w500, IdColors.backgroundDefault, TextAlign.left),
            ],
          ),
        ),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        (GV.pStrg.getXXX(Param_pageType) == 'introPage')
            ? uiCommon.styledText(
                '$office  <name2>$userName</name2>($userId)님', 15, 0, 1, FontWeight.w400, IdColors.darkGray2, TextAlign.left)
            : uiCommon.styledText('$office  <name>$userName</name>($userId)님', 15, 0, 1, FontWeight.w400, IdColors.white, TextAlign.left),
        const IdSpace(spaceWidth: 8, spaceHeight: 0),
        IdNormalBtn(
          onBtnPressed: (alarm == 'Y')
              ? () {
                  GV.pStrg.putXXX(Param_pageType, 'dealPage');
                  uiCommon.IdMovePage(context, PAGE_MYALARM_PAGE);
                }
              : () {},
          childWidget: Stack(
            children: [
              const SizedBox(
                width: 24,
                height: 26,
              ),
              Positioned(
                top: 2,
                left: 0,
                child: IdImageBox(
                    imagePath:
                        (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? 'assets/img/icon_noti_black.png' : 'assets/img/icon_noti.png',
                    imageWidth: 22,
                    imageHeight: 22,
                    imageFit: BoxFit.cover),
              ),
              Visibility(
                visible: (alarm == 'Y') ? true : false,
                child: Positioned(
                  right: 0,
                  top: 2,
                  child: Container(
                    width: 6,
                    height: 6,
                    decoration: BoxDecoration(color: Color(0xFFD42424), shape: BoxShape.circle),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget headerSubMenu() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        user1.isNotEmpty()
            ? IdNormalBtn(
                onBtnPressed: () {
                  submenuVisible = !submenuVisible;
                  setState(() {});
                },
                childWidget: uiCommon.styledText('My Page', 14, 0, 1.6, FontWeight.w500,
                    (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.textDefault : IdColors.white, TextAlign.left))
            : IdNormalBtn(
                onBtnPressed: () {
                  uiCommon.IdMovePage(context, PAGE_LOGIN);
                },
                childWidget: uiCommon.styledText('로그인', 14, 0, 1.6, FontWeight.w500,
                    (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.textDefault : IdColors.white, TextAlign.left)),
        const IdDivider(),
        Visibility(
            visible: user1.isNotEmpty(),
            child: IdNormalBtn(
                onBtnPressed: () {
                  GV.pStrg.putXXX(Param_pageType, 'dealPage');
                  uiCommon.IdMovePage(context, PAGE_DEAL_STEP_01_PAGE);
                },
                childWidget: uiCommon.styledText('딜등록', 14, 0, 1.6, FontWeight.w500,
                    (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.textDefault : IdColors.white, TextAlign.left))),
        Visibility(visible: user1.isNotEmpty(), child: const IdDivider()),
        IdNormalBtn(
            onBtnPressed: () {
              GV.pStrg.putXXX(Param_pageType, 'dealPage');
              uiCommon.IdMovePage(context, PAGE_NOTICE_PAGE);
            },
            childWidget: uiCommon.styledText('공지사항', 14, 0, 1.6, FontWeight.w500,
                (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.textDefault : IdColors.white, TextAlign.left)),
        const IdDivider(),
        IdNormalBtn(
            onBtnPressed: () {
              GV.pStrg.putXXX(Param_pageType, 'dealPage');
              uiCommon.IdMovePage(context, PAGE_FAQ_PAGE);
            },
            childWidget: uiCommon.styledText('FAQ', 14, 0, 1.6, FontWeight.w500,
                (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.textDefault : IdColors.white, TextAlign.left)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
  
    subMenuLinkList = [
      () {
        GV.pStrg.putXXX(Param_commonUserNo, userNo);
        GV.pStrg.putXXX(Param_pageType, 'dealPage');
        uiCommon.IdMovePage(context, PAGE_MYINFO_PAGE);
      },
      () {
        GV.pStrg.putXXX(Param_pageType, 'dealPage');
        uiCommon.IdMovePage(context, PAGE_MYDEAL_PAGE);
      },
      () {
        GV.pStrg.putXXX(Param_pageType, 'dealPage');
        uiCommon.IdMovePage(context, PAGE_MYALARM_PAGE);
      },
      () {
        IdUtil.logout();
        GV.pStrg.putXXX(Param_pageType, 'introPage');
        uiCommon.IdMovePage(context, PAGE_INTRO);
      }
    ];

    Widget wg1 = Stack(
      children: [
        Container(
          width: 1700,
          height: 220,
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            width: double.infinity,
            height: 74,
            decoration: BoxDecoration(
              color: (GV.pStrg.getXXX(Param_pageType) == 'introPage') ? IdColors.white : IdColors.green2,
            ),
            child: Center(
              child: SizedBox(
                width: 1920,
                child: Row(
                  children: [
                    IdSpace(spaceWidth: 134, spaceHeight: 0),
                    headerLogo(),
                    IdSpace(spaceWidth: 53, spaceHeight: 0),
                    headerMenu(),
                    Expanded(child: SizedBox()),
                    headerMember(),
                    IdSpace(spaceWidth: 48, spaceHeight: 0),
                    headerSubMenu(),
                    IdSpace(spaceWidth: 120, spaceHeight: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Visibility(
          visible: submenuVisible,
          child: Positioned(
            top: 63,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 1920,
                child: Row(
                  children: [
                    IdSpace(spaceWidth: 1100, spaceHeight: 0),
                    Expanded(child: SizedBox()),
                    WebViewAware(
                        child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: IdColors.white,
                        borderRadius: BorderRadius.circular(8),
                        boxShadow: const [
                          BoxShadow(blurRadius: 12, offset: Offset(0, 0), color: IdColors.black16Per, spreadRadius: 0),
                        ],
                      ),
                      child: Column(
                        children: List.generate(
                          subMenuNameList.length,
                          (index) => subMenuBtn(
                            subMenuNameList[index],
                            subMenuLinkList[index],
                          ),
                        ),
                      ),
                    )),
                    IdSpace(spaceWidth: 250, spaceHeight: 0),
                  ],
                ),
              ),
            ),
          ),
        ),
        Center(
          child: Builder(
            builder: (context) {
              // 화면 크기 변경 시 호출되는 이벤트 핸들러 등록
              html.window.onResize.listen((event) {
                webWidth = double.tryParse(html.window.innerWidth.toString()) ?? 0;
                // 현재 창의 너비 출력
              });

              return SizedBox();
            },
          ),
        ),
      ],
    );
    return wg1;
  }
}
