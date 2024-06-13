import 'dart:html';
import 'dart:io';

// import 'package:unionCDPP/screens/HtmlMember.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/screens/HtmlWebPage.dart';
import 'package:unionCDPP/screens/DealStep01.dart';
import 'package:unionCDPP/screens/DealStep02_1.dart';
import 'package:unionCDPP/screens/DealStep02_2.dart';
import 'package:unionCDPP/screens/DealStep03_1.dart';
import 'package:unionCDPP/screens/DealStep03_2.dart';
import 'package:unionCDPP/screens/DealStep04_1.dart';
import 'package:unionCDPP/screens/DealStep04_2.dart';
import 'package:unionCDPP/screens/DealStep04_3.dart';
import 'package:unionCDPP/screens/DealStep04_4.dart';
import 'package:unionCDPP/screens/FAQ.dart';
import 'package:unionCDPP/screens/Home.dart';

import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:unionCDPP/screens/FirstPage.dart';
import 'package:unionCDPP/screens/MyAlarm.dart';
import 'package:unionCDPP/screens/MyDeal.dart';
import 'package:unionCDPP/screens/MyDealDetail.dart';
import 'package:unionCDPP/screens/MyInfo.dart';
import 'package:unionCDPP/screens/Notice.dart';
import 'package:unionCDPP/screens/Notice_detail.dart';
import 'package:unionCDPP/screens/PDF/tmPdf.dart';
import 'package:unionCDPP/screens/Pdf.dart';
import 'package:unionCDPP/screens/error/Error404.dart';
import 'package:unionCDPP/screens/error/Error500.dart';
import 'package:unionCDPP/screens/error/ErrorNull.dart';
import 'package:uuid/uuid.dart';
// import 'package:unionCDPP/screens/test.dart';

import 'common/globalvar.dart';
import 'constants/constants.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");
  var runLevel = dotenv.env['RUNLEVEL'];
  var tdiff1 = int.tryParse(dotenv.env['TIMEDIFF']!) ?? 0;
  var mainpage = dotenv.env['MAIN'];
  var logLevel = dotenv.env['LOGLEVEL'];

  ID_BASE_URI = dotenv.env['BASE_URI_$runLevel'] ?? 'http://localhost:8082';
  ID_SSO_URI = dotenv.env['SSO_URI_$runLevel'] ?? 'http://localhost:8081';
  ID_WEB_URI = dotenv.env['WEB_URI_$runLevel'] ?? 'ws://localhost:8082/internal/socket-check';

  await GV.init(logLevel as String);

  var uuidStr = const Uuid().v4();
  GV.pStrg.putXXX(key_gv_mainpage, mainpage!);
  GV.pStrg.putTimediff(tdiff1);
  GV.pStrg.putXXX(key_gv_uuid, uuidStr);
  var user1 = IdApi.LoggedUser();
  if (user1 != null) GV.myInfoItem = user1;

  var curpage = window.location.href;
  var curpages = curpage.replaceAll('#/', '').replaceAll('//', '').split('/');

  if (curpages.length >= 2 && curpages[1].isNotEmpty) {
    mainpage = curpages[1].replaceAll('#', '');
  } else {
    GV.pStrg.clearPage1();
  }

  GV.d(window.location.href, curpage, curpages, mainpage);

  runApp(MyApp(mainPage: mainpage));
}

class MyApp extends StatelessWidget {
  final String? mainPage;
  const MyApp({super.key, required this.mainPage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    GV.pStrg.getHistoryPages().isEmpty ? uiCommon.IdPushPage(context, mainPage!) : 1 == 1;
    PageTransitionsTheme _removeTransitions() {
      return PageTransitionsTheme(
        builders: {
          for (final platform in TargetPlatform.values) platform: const _NoTransitionsBuilder(),
        },
      );
    }

    return MaterialApp(
      title: 'DealStation',
      // theme:  ThemeData(pageTransitionsTheme: _removeTransitions()),
      initialRoute: "/${mainPage!}",
      debugShowCheckedModeBanner: false,
      routes: {
        "/$PAGE_HOME_PAGE": (context) => const Home(),
        "/$PAGE_MYINFO_PAGE": (context) => const MyInfo(),
        "/$PAGE_MYDEAL_PAGE": (context) => const MyDeal(),
        "/$PAGE_MYDEAL_DETAIL_PAGE": (context) => const MyDealDetail(),
        "/$PAGE_MYALARM_PAGE": (context) => const MyAlarm(),
        "/$PAGE_DEAL_STEP_01_PAGE": (context) => const DealStep01(),
        "/$PAGE_DEAL_STEP_02_1_PAGE": (context) => const DealStep02_1(),
        "/$PAGE_DEAL_STEP_02_2_PAGE": (context) => const DealStep02_2(),
        "/$PAGE_DEAL_STEP_03_1_PAGE": (context) => const DealStep03_1(),
        "/$PAGE_DEAL_STEP_03_2_PAGE": (context) => const DealStep03_2(),
        "/$PAGE_DEAL_STEP_04_1_PAGE": (context) => const DealStep04_1(),
        "/$PAGE_DEAL_STEP_04_2_PAGE": (context) => const DealStep04_2(),
        "/$PAGE_DEAL_STEP_04_3_PAGE": (context) => const DealStep04_3(),
        "/$PAGE_DEAL_STEP_04_4_PAGE": (context) => const DealStep04_4(),
        "/$PAGE_TM_PDF_PAGE": (context) => const Pdf(),
        "/$PAGE_CERT_PDF_PAGE": (context) => const Pdf(),
        "/$PAGE_LOGGED_INTRO": (context) => HtmlWebPage(param: "IntroLogged"),
        "/$PAGE_LOGGED_INTRO2": (context) => HtmlWebPage(param: "IntroLogged2"),
        "/$PAGE_LOGGED_INTRO3": (context) => HtmlWebPage(param: "IntroLogged3"),
        "/$PAGE_LOGIN": (context) => HtmlWebPage(param: "login"),
        "/$PAGE_SIGNUP": (context) => HtmlWebPage(param: "signUp"),
        "/$PAGE_FIND_IDPWD": (context) => HtmlWebPage(param: "findIdPwd"),

        "/$PAGE_NOTICE_PAGE": (context) => const Notice(),
        "/$PAGE_NOTICE_DETAIL_PAGE": (context) => const NoticeDetail(),
        "/$PAGE_FAQ_PAGE": (context) => const FAQ(),
        "/$PAGE_INTRO": (context) => HtmlWebPage(param: "Intro"),
        "/$PAGE_INTRO2": (context) => HtmlWebPage(param: "Intro2"),
        "/$PAGE_INTRO3": (context) => HtmlWebPage(param: "Intro3"),

        "/$PAGE_404_PAGE": (context) => const Error404(),
        "/$PAGE_500_PAGE": (context) => const Error500(),
        "/$PAGE_NULL_PAGE": (context) => const ErrorNull(),

        //  "/$PAGE_TEST_PAGE":
        //    (context) =>  const Test(),
      },
    );
  }
}

class _NoTransitionsBuilder extends PageTransitionsBuilder {
  const _NoTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T>? route,
    BuildContext? context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget? child,
  ) {
    return child!;
  }
}
