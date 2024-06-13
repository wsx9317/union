import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdCommmonFooter.dart';
import 'package:unionCDPP/id_widget/IdCommonHeader.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageTopSection.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdSubNavigator.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';

import '../../api/id_api.dart';
import '../../common/globalvar.dart';
import '../IdTopToast.dart';

abstract class IdState<T extends StatefulWidget> extends State<T> {
  bool _toastVisible = false;
  String _toastMessageStr = '';
  late Timer _timer;
  var _loggedPages123 = [
    PAGE_HOME_PAGE,
    PAGE_MYINFO_PAGE,
    PAGE_MYDEAL_PAGE,
    PAGE_MYDEAL_DETAIL_PAGE,
    PAGE_MYALARM_PAGE,
    PAGE_DEAL_STEP_01_PAGE,
    PAGE_DEAL_STEP_02_1_PAGE,
    PAGE_DEAL_STEP_02_2_PAGE,
    PAGE_DEAL_STEP_03_1_PAGE,
    PAGE_DEAL_STEP_03_2_PAGE,
    PAGE_DEAL_STEP_04_1_PAGE,
    PAGE_DEAL_STEP_04_2_PAGE,
    PAGE_DEAL_STEP_04_3_PAGE,
    PAGE_DEAL_STEP_04_4_PAGE,
    PAGE_TM_PDF_PAGE,
    PAGE_CERT_PDF_PAGE,
    PAGE_LOGGED_INTRO,
    PAGE_LOGGED_INTRO2,
    PAGE_LOGGED_INTRO3,
  ];

  void activeToast(String message) {
    _toastVisible = true;
    _toastMessageStr = message;
    setState(() {});
    disappearToast();
  }

  void disappearToast() {
    Future.delayed(Duration(milliseconds: 1500), () {
      _toastVisible = false;
      setState(() {});
    });
  }

  Widget idCommonHeader() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: IdCommonHeader(),
    );
  }

  Widget idCommonFooter() {
    return IdCommonFooter();
  }

  Widget idHeadToastWidget() {
    return Visibility(
      visible: _toastVisible,
      child: Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: IdTopToast(toastMessage: _toastMessageStr),
      ),
    );
  }

  Widget idFloatDealRegistBtn() {
    return Positioned(
      right: 50,
      bottom: 50,
      child: IdNormalBtn(
        onBtnPressed: () {
          uiCommon.IdMovePage(context, PAGE_DEAL_STEP_01_PAGE);
        },
        childWidget: Container(
          width: 94,
          height: 94,
          decoration: const BoxDecoration(
            shape: BoxShape.circle,
            color: IdColors.orange1,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IdImageBox(imagePath: 'assets/img/icon_pencile_white.png', imageWidth: 32, imageHeight: 32, imageFit: BoxFit.cover),
              uiCommon.styledText('딜등록', 18, -2, 1.6, FontWeight.w800, IdColors.white, TextAlign.left)
            ],
          ),
        ),
      ),
    );
  }

  void _checkLoginLogin() {
    var curMenu = GV.pStrg.getPage1(n: 1);
    if (IdApi.LoggedUser() == null && _loggedPages123.contains(curMenu)) {
      Future.delayed(Duration(milliseconds: 10), () {
        uiCommon.IdMovePage(context, PAGE_INTRO);
      });
    }
  }

  Widget idSearchBtn(Function() onBtnPressed) {
    return IdNormalBtn(
      onBtnPressed: onBtnPressed,
      childWidget: Container(
        height: 44,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
        decoration: BoxDecoration(
          color: IdColors.green2,
          borderRadius: BorderRadius.circular(40),
        ),
        child: Row(
          children: [
            const IdImageBox(imagePath: 'assets/img/icon_search_white.png', imageWidth: 14.71, imageHeight: 15.34, imageFit: BoxFit.cover),
            const IdSpace(spaceWidth: 6, spaceHeight: 0),
            uiCommon.styledText('검색', 16, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left)
          ],
        ),
      ),
    );
  }

  Widget idSearchInputBox(String searchType, TextEditingController controller) {
    return IdInputValidation(
        width: 300,
        height: 44,
        inputColor: (searchType == '') ? IdColors.borderDefault : IdColors.white,
        borderColor: IdColors.borderDefault,
        round: 40,
        textAlign: 'start',
        hintText: '검색해 주세요.',
        controller: controller,
        hintTextFontSize: 18,
        hintTextfontWeight: FontWeight.w400,
        hintTextFontColor: IdColors.textTertiary,
        keyboardType: 'text',
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: (searchType == '') ? false : true);
  }

  Widget idTopContent1(Color backgroundColor, List navigatorMenuList, List menuNavigatorLinkList, String menuNameStr, String pageDescStr,
      String pageNameStr, Widget imgWidget, List subMenuNameList, List submenuNavigatorLink) {
    return Container(
      width: double.infinity,
      height: 500,
      color: backgroundColor,
      child: Center(
        child: Container(
          constraints: const BoxConstraints(
            maxWidth: 1224,
          ),
          child: Column(
            children: [
              IdTopNavigator(navigatorMenu: navigatorMenuList, navigatorLink: menuNavigatorLinkList),
              IdPageTopSection(
                menuName: menuNameStr,
                pageDesc: pageDescStr,
                imgBoxWidget: imgWidget,
                navigator: IdSubNavigator(pageName: pageNameStr, subMenu: subMenuNameList, subMenuLink: submenuNavigatorLink),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    GV.pStrg.putXXX(Param_classType, this.runtimeType.toString());
    _timer = Timer.periodic(Duration(seconds: 60), (timer) {
      _checkLoginLogin();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  Widget idBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    uiCommon.setScreen(context);
    return idBuild(context);
  }
}
