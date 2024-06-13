import 'dart:io';

import 'package:flutter/material.dart';
import 'package:one_context/one_context.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:union_admin/screens/Pdf.dart';
import 'package:union_admin/screens/deal.dart';
import 'package:union_admin/screens/dealDomi.dart';
import 'package:union_admin/screens/dealDetail.dart';
import 'package:union_admin/screens/home.dart';

import 'common/globalvar.dart';
import 'constants/constants.dart';
import 'dart:html' as html;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  var runLevel = dotenv.env['RUNLEVEL'];
  var tdiff1 = int.tryParse(dotenv.env['TIMEDIFF']!) ?? 0;
  var mainpage = dotenv.env['MAIN'];
  var logLevel = dotenv.env['LOGLEVEL'];
  var mainpageOpt = '';

  ID_BASE_URI = dotenv.env['BASE_URI_$runLevel'] ?? 'http://localhost:8080';
  ID_SSO_URI = dotenv.env['SSO_URI_$runLevel'] ?? 'http://localhost:8081';

  await GV.init(logLevel as String);

  // GV.d(mainpage, runLevel, logLevel, 'base:' + ID_BASE_URI, 'sso:' + ID_SSO_URI, 'websocket:' + ID_WEB_URI);
  GV.pStrg.putTimediff(tdiff1);
  GV.pStrg.clearPage1();

  String menuMain = GV.pStrg.getXXX("menu123");
  //if (menuMain.isEmpty) menuMain = "진행관리/140058255287";
  if (menuMain.isEmpty) menuMain = "독점보호관리";
  if (menuMain.startsWith("독점보호관리")) {
    mainpage = PAGE_DEAL_DOMI_PAGE;
  } else if (menuMain.startsWith("진행관리")) {
    var strAry = menuMain.split('/');
    mainpage = PAGE_DEAL_PAGE;
    if (strAry.length > 1) {
      mainpage = PAGE_DEAL_DETAIL_PAGE;
      GV.pStrg.putXXX(Param_dealNoString, strAry[1]);
      GV.pStrg.putXXX(Param_beforePage, 'deal');
    }
    GV.d(strAry);
  }

  GV.d(menuMain, mainpage);
  final windowWidth = html.window.innerWidth!.toDouble();
  GV.pStrg.putXXX(key_page_with, windowWidth.toString());

  runApp(MyApp(mainPage: mainpage));
}

class MyApp extends StatelessWidget {
  final String? mainPage;
  const MyApp({super.key, required this.mainPage});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DealStation Admin',
      initialRoute: "/${mainPage!}",
      debugShowCheckedModeBanner: false,
      routes: {
        "/$PAGE_HOME_PAGE": (context) => const Home(),
        "/$PAGE_DEAL_DOMI_PAGE": (context) => const DealDomi(),
        "/$PAGE_DEAL_PAGE": (context) => const Deal(),
        "/$PAGE_DEAL_DETAIL_PAGE": (context) => const DealDetail(),
        "/$PAGE_CERT_PDF_PAGE": (context) => const Pdf(),
      },
    );
  }
}
