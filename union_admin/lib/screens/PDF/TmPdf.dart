// // ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings
// // ignore_for_file: prefer_const_constructors, camel_case_types

// import 'dart:async';
// import 'dart:typed_data';

// import 'package:flutter/services.dart' show rootBundle;
// import 'package:intl/intl.dart';
// import 'package:pdf/pdf.dart';
// import 'package:pdf/widgets.dart' as pw;
// import 'package:printing/printing.dart';
// import 'package:http/http.dart' as http;
// // import 'package:unionCDPP/api/id_api.dart';
// // import 'package:unionCDPP/common/globalvar.dart';
// // import 'package:unionCDPP/constants/constants.dart';
// // import 'package:unionCDPP/modelVO/myDealDetailBuildingItem.dart';
// // import 'package:unionCDPP/modelVO/myDealDetailLandItem.dart';
// // import 'package:unionCDPP/modelVO/myInfoItem.dart';

// enum TmType { none, building, land }

// class TmPdf {
//   static String userNo = '';
//   static String dealNo = '';
//   static String pdfDealType = '';
//   static TmType tmType = TmType.building;
//   static baseOffice? officeInfo;
//   static PdfColor baseColor = PdfColor.fromInt(0xFFD3CCBF);
//   static PdfColor base1Color = PdfColor.fromInt(0xFFF0EBE2);
//   static PdfColor base2Color = PdfColor.fromInt(0xFFF9F7F1);

//   static String phone = '';
//   static String office = '';
//   static String officeAddress = '';
//   static String userName = '';
//   static String title = '';

//   static String rentDeposit = '';
//   static String rentRent = '';

//   static List<List<String>> imData123 = [];

//   static String lotArea = '';
//   static String totalArea = '';
//   static String totalFloorArea = '';
//   static String upperNum = '';
//   static String lowerNum = '';
//   static String elevator = '';
//   static String ccd = '';
//   static String bdCoverageRatio = '';
//   static String totalFloorRatio = '';
//   static String mainStruct = '';
//   static String areaPurpose = '';
//   static String parkingNum = '';
//   static String reModel = '';
//   static String asking = '';
//   static String deposit = '';
//   static String monthly = '';
//   static String evacuation = '';
//   static String address = '';
//   static String stationName = '';
//   static String stationDistance = '';
//   static String officialLandPrice = '';
//   static String totalLandPrice = '';
//   static String etc = '';
//   static String buildingArea = '';
//   static String latitude = '';
//   static String longitude = '';

//   static List<dynamic> imgList = [];
//   static List<dynamic> imgDocList = ['', '', '', '', '', '', '', '', '', '', '', '', ''];
//   static List<int> imgNumList = [];

//   static int bigImgInt = 0;
//   static int smalImgInt = 0;

//   static String nameCardUrl = '';

//   static Future<Uint8List> loadImageV1() async {
//     //TODO  CORS 이슈때문에 cors무시하는 proxy를 거쳐서 가져오도록 되어 있음. 나중에 proxy프로그램을 서버에 설치하거나  api서버에서 가져오는 api를 작성할 필요가 있음.
//     String mapUrl =
//         'http://flexwill.duckdns.org:7080/https://naveropenapi.apigw.ntruss.com/map-static/v2/raster?w=400&h=420&center=$longitude,$latitude&level=17&scale=2&scaleControl=true';
//     Map<String, String> mapHeader = const {
//       "Access-Control-Allow-Headers": "Access-Control-Allow-Origin, Accept",
//       "Access-Control-Allow-Origin": "*",
//       'Accept': '*/*',
//       'X-NCP-APIGW-API-KEY-ID': 'oblzrjl4h1',
//       'X-NCP-APIGW-API-KEY': 'HR33Y1j0olrYptMEZhNJhmGrAbLuBsecVgxRBLJj'
//       //TODO 유니언쪽 계정에 key 및 암호를 설정해야됨.  이래는 참조
//       //https://api.ncloud-docs.com/docs/ai-naver-mapsstaticmap-raster
//       //https://blog.naver.com/6sub/221893778682
//     };

//     try {
//       final res = await http.get(Uri.parse(mapUrl), headers: mapHeader);
//       return res.bodyBytes;
//     } catch (e) {
//       print(e);
//     }
//     return Uint8List(0);
//   }

//   static Future<Uint8List> generateTM(PdfPageFormat format, {TmType type = TmType.building}) async {
//     userNo = GV.pStrg.getXXX(commonUserNo);
//     dealNo = GV.pStrg.getXXX(myDealNo);
//     pdfDealType = GV.pStrg.getXXX(dealType);

//     final dynamic ret1 = await IdApi.getMember(MyInfoItem(userNo: userNo));
//     MyInfoItem data = ret1;

//     phone = data.userTel!.substring(0, 3) + '-' + data.userTel!.substring(3, 7) + '-' + data.userTel!.substring(7, 11);
//     office = data.office!;
//     officeAddress = data.officeAddr!;
//     userName = data.userName!;
//     nameCardUrl = "http://flexwill.duckdns.org:7080/" + data.ncardUrl!;
//     imgNumList = [];
//     imgList = [];
//     imgDocList = ['', '', '', '', '', '', '', '', '', '', '', '', ''];
//     if (pdfDealType == 'L') {
//       final MyDealDetailLandItem? ret2 = await IdApi.getMydaelDetail(userNo, dealNo, pdfDealType);
//       title = ret2!.dealMaster!.title!;
//       latitude = ret2.dealMaster!.latitude!;
//       longitude = ret2.dealMaster!.longitude!;

//       imgList = [
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//       ];
//       for (var i = 0; i < ret2.fileList!.length; i++) {
//         imgNumList.add(int.parse(ret2.fileList![i].fileOrder!));
//       }
//       for (var i = 0; i < imgNumList.length; i++) {
//         imgList[int.parse(ret2.fileList![i].fileOrder!) - 1] = ret2.fileList![i].s3FileUrl!;
//         imgDocList[int.parse(ret2.fileList![i].fileOrder!) - 1] = ret2.fileList![i].fileDoc!;
//       }
//     } else {
//       final MyDealDetailBuildingItem? ret2 = await IdApi.getMydaelDetail(userNo, dealNo, pdfDealType);

//       title = ret2!.dealMaster!.title!;
//       latitude = ret2.dealMaster!.latitude!;
//       longitude = ret2.dealMaster!.longitude!;
//       for (var i = 0; i < ret2.rentrollList!.length; i++) {
//         rentDeposit = NumberFormat('#,##0.00').format(double.parse(ret2.rentrollList![i].deposit!) / 10000);

//         if (ret2.rentrollList![i].rent!.length >= 4) {
//           rentRent = NumberFormat('#,##0.00').format(double.parse(ret2.rentrollList![i].rent!) / 10000);
//         } else {
//           rentRent = ret2.rentrollList![i].rent!;
//         }

//         imData123.add([
//           ret2.rentrollList![i].floor!,
//           ret2.rentrollList![i].sectors!,
//           ret2.rentrollList![i].area! + '㎡',
//           rentDeposit + ' 만원',
//           rentRent + ' 만원',
//           ret2.rentrollList![i].etc!,
//         ]);
//       }

//       imgList = [
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//         ret2.fileList![0].s3FileUrl!,
//       ];

//       for (var i = 0; i < ret2.fileList!.length; i++) {
//         imgNumList.add(int.parse(ret2.fileList![i].fileOrder!));
//       }

//       for (var i = 0; i < imgNumList.length; i++) {
//         imgList[int.parse(ret2.fileList![i].fileOrder!) - 1] = ret2.fileList![i].s3FileUrl!;
//         imgDocList[int.parse(ret2.fileList![i].fileOrder!) - 1] = ret2.fileList![i].fileDoc!;
//       }
//     }

//     if (pdfDealType == 'L') {
//       tmType = TmType.land;
//     } else {
//       tmType = TmType.building;
//     }

//     switch (tmType) {
//       case TmType.none:
//       case TmType.building:
//         baseColor = PdfColor.fromInt(0xFFD3CCBF);
//         base1Color = PdfColor.fromInt(0xFFF0EBE2);
//         base2Color = PdfColor.fromInt(0xFFF9F7F1);
//         break;
//       case TmType.land:
//         baseColor = PdfColor.fromInt(0xFFADBDB9);
//         base1Color = PdfColor.fromInt(0xFFDDE7E4);
//         base2Color = PdfColor.fromInt(0xFFF2F8F6);
//     }

//     officeInfo = baseOffice(title, '$office $userName', phone, officeAddress);

//     var font123b = await PdfGoogleFonts.nanumMyeongjoBold();
//     var font123r = await PdfGoogleFonts.nanumMyeongjoRegular();
//     // final img1st = pw.MemoryImage((await rootBundle.load('assets/img/tm-building-sample.png')).buffer.asUint8List());
// 

//     final img1st = pw.MemoryImage(await IdApi.loadImage(imgList[0]));
//     // //TODO 외부 1
//     final img2st = pw.MemoryImage(await IdApi.loadImage(imgList[1]));
//     // //TODO 외부 2
//     final img3st = pw.MemoryImage(await IdApi.loadImage(imgList[2]));
//     // //TODO 외부 3
//     final img4st = pw.MemoryImage(await IdApi.loadImage(imgList[3]));
//     // //TODO 내부 1
//     final img5st = pw.MemoryImage(await IdApi.loadImage(imgList[4]));
//     // //TODO 내부 2
//     final img6st = pw.MemoryImage(await IdApi.loadImage(imgList[5]));
//     // //TODO 내부 3
//     final img7st = pw.MemoryImage(await IdApi.loadImage(imgList[6]));
//     // //TODO 내부 4
//     final img8st = pw.MemoryImage(await IdApi.loadImage(imgList[7]));
//     // //TODO 내부 5
//     final img9st = pw.MemoryImage(await IdApi.loadImage(imgList[8]));
//     // //TODO 내부 6
//     final img10st = pw.MemoryImage(await IdApi.loadImage(imgList[9]));
//     // //TODO 평면도
//     final img11st = pw.MemoryImage(await IdApi.loadImage(imgList[11]));

//     var imgMap = pw.MemoryImage(await loadImageV1());

//     final doc = pw.Document(title: 'TM', subject: 'TM', compress: false, author: 'DEALSTATION', pageMode: PdfPageMode.thumbs);

//     List<List<String>> lvData123 = [
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '250 만원'],
//       // ['1층 101', '카페', '124.00', '30,000 만원', '251 만원'],
//     ];
//     List<pw.MemoryImage> pictures = [img1st, img2st, img3st, img4st, img5st, img6st, img7st, img8st, img9st, img10st];
//     List<pw.PageTheme> lists = [];
//     final page1 = await _tmBuildingPage1(format, font123b, font123r, img1st);
//     lists.add(page1);
//     final page2 = await _tmBuildingPage2(format, font123b, font123r);
//     lists.add(page2);
//     final page3 = await _tmBuildingPage3(format, font123b, font123r, img1st);
//     lists.add(page3);
//     final page4 = await _tmBuildingPage4(format, font123b, font123r, img1st);
//     lists.add(page4);

//     //연면적 합 구하기 위한 파라미터
//     double imData1 = 0;
//     //보증금 합 구하기 위한 파라미터
//     double imData2 = 0;
//     //월세 합 구하기 위한 파라미터
//     double imData3 = 0;

//     for (int i = 0; i < imData123.length; i += 11) {
//       var l1 = imData123.length - i;

//       imData1 += double.parse(imData123[i][2].split('㎡')[0]);

//       imData2 += (double.parse(imData123[i][3].split(' ')[0].replaceAll(',', '')) / 10000);
//       imData3 += double.parse(imData123[i][4].split(' ')[0].replaceAll(',', '')) / 10000;

//       final page5 = await _tmBuildingPage5(format, font123b, font123r, imData123.sublist(i, l1 >= 11 ? i + 11 : i + l1),
//           //TODO 합계
//           total: l1 - 11 > 0 ? null : [imData1.toString(), imData2.toString(), imData3.toString()]);
//       lists.add(page5);
//     }

//     if (tmType == TmType.building)
//       for (int i = 0; i < lvData123.length; i += 11) {
//         var l1 = lvData123.length - i;
//         final page6 = await _tmBuildingPage6(format, font123b, font123r, lvData123.sublist(i, l1 >= 11 ? i + 11 : i + l1));
//         lists.add(page6);
//       }

//     final page7 = await _tmBuildingPage7(format, font123b, font123r, pictures.sublist(0, pictures.length > 4 ? 4 : pictures.length),
//         imgs2: pictures.length > 4 ? pictures.sublist(4, pictures.length) : null);
//     lists.add(page7);

//     if (tmType == TmType.building) {
//       if (imgDocList[11] != '') {
//         final page8 = await _tmBuildingPage8(format, font123b, font123r, img11st, imgDocList[11].toString().split('.')[0]);
//         lists.add(page8);
//       }
//     }
//     final page9 = await _tmBuildingPage9(format, font123b, font123r, img1st, imgMap);
//     lists.add(page9);

//     final page99 = await _tmBuildingPage99(format, font123b, font123r, img1st);
//     lists.add(page99);

//     for (var p1 in lists) {
//       doc.addPage(pw.Page(pageTheme: p1, build: (context) => pw.SizedBox(width: double.infinity, height: 425)));
//     }
//     return doc.save();
//   }

//   ///마지막장
//   static Future<pw.PageTheme> _tmBuildingPage99(PdfPageFormat format, pw.Font font123b, pw.Font font123r, pw.MemoryImage img1) async {
//     format = format.applyMargin(left: 0, top: 0, right: 0, bottom: 0);
//     final backImg = pw.MemoryImage(
//         (await rootBundle.load(tmType == TmType.building ? 'assets/img/tm-building-end.png' : 'assets/img/tm-land-end.png'))
//             .buffer
//             .asUint8List());

//     final nameCard = pw.MemoryImage(await IdApi.loadImage(nameCardUrl));

//     return pw.PageTheme(
//       pageFormat: format,
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//               width: 1684 / 2,
//               height: 1199 / 2,
//               decoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFF3E3A34)),
//               child: pw.Stack(
//                 children: [
//                   pw.Container(child: pw.Image(backImg)),
//                   pw.Positioned(
//                       right: 60 / 2,
//                       bottom: 199 / 2,
//                       child: pw.Container(width: 600 / 2, height: 360 / 2, color: PdfColor.fromInt(0xD9D9D9))),
//                   pw.Positioned(
//                       right: 71 / 2,
//                       bottom: 210 / 2,
//                       child: pw.Container(
//                           width: 600 / 2,
//                           height: 360 / 2,
//                           color: PdfColor.fromInt(0xffffff),
//                           child: pw.Center(child: pw.Image(nameCard, fit: pw.BoxFit.fitHeight)))),
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   ///첫장
//   static Future<pw.PageTheme> _tmBuildingPage1(PdfPageFormat format, pw.Font font123b, pw.Font font123r, pw.MemoryImage img1) async {
//     format = format.applyMargin(left: 0, top: 0, right: 0, bottom: 0);
//     final backImg = pw.MemoryImage(
//         (await rootBundle.load(tmType == TmType.building ? 'assets/img/tm-building-head.png' : 'assets/img/tm-land-head.png'))
//             .buffer
//             .asUint8List());
//     var clippedImage = pw.ClipOval(child: pw.Image(width: 400, height: 400, fit: pw.BoxFit.fill, img1));

//     return pw.PageTheme(
//       pageFormat: format,
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//               width: 1684 / 2,
//               height: 1199 / 2,
//               // clipBehavior: Clip.antiAlias,
//               decoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFF3E3A34)),
//               child: pw.Stack(
//                 children: [
//                   pw.Container(child: pw.Image(backImg)),
//                   pw.Positioned(left: 838 / 2, top: 196 / 2, child: clippedImage),
//                   pw.Positioned(
//                     left: 113 / 2,
//                     top: 980 / 2,
//                     child:
//                         pw.Text(officeInfo!.office, style: pw.TextStyle(color: baseColor, fontSize: 32 / 2, font: font123b, height: 0.04)),
//                   ),
//                   pw.Positioned(
//                     left: 113 / 2,
//                     top: (980 + 70) / 2,
//                     child: pw.Text(officeInfo!.tel, style: pw.TextStyle(color: baseColor, fontSize: 32 / 2, font: font123b, height: 0.04)),
//                   ),
//                   pw.Positioned(
//                     left: 113 / 2,
//                     top: 532 / 2,
//                     child: pw.Container(
//                       width: 640 / 2,
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text(officeInfo!.title,
//                               style: pw.TextStyle(color: PdfColors.white, fontSize: 96 / 2, font: font123b, height: 0.02)),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   static Future<pw.PageTheme> _tmBuildingPage2(PdfPageFormat format, pw.Font font123b, pw.Font font123r) async {
//     final backImg = pw.MemoryImage(
//       (await rootBundle.load(tmType == TmType.building ? 'assets/img/tm-building-index.png' : 'assets/img/tm-land-index.png'))
//           .buffer
//           .asUint8List(),
//     );

//     format = format.applyMargin(
//         left: 2.0 * PdfPageFormat.cm, top: 4.0 * PdfPageFormat.cm, right: 2.0 * PdfPageFormat.cm, bottom: 2.0 * PdfPageFormat.cm);

//     return pw.PageTheme(
//       pageFormat: format,
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//               width: 1684 / 2,
//               height: 1199 / 2,
//               //clipBehavior: Clip.antiAlias,
//               decoration: pw.BoxDecoration(color: PdfColors.white),
//               child: pw.Stack(
//                 children: [
//                   pw.Container(child: pw.Image(backImg)),
//                   pw.Positioned(
//                     left: 0,
//                     top: 100 / 2,
//                     child: pw.Container(
//                         width: 1684 / 4,
//                         child: pw.Row(
//                             mainAxisSize: pw.MainAxisSize.min,
//                             mainAxisAlignment: pw.MainAxisAlignment.center,
//                             crossAxisAlignment: pw.CrossAxisAlignment.center,
//                             children: [
//                               pw.Container(
//                                 padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2),
//                                 decoration: pw.BoxDecoration(color: baseColor),
//                                 child: pw.Row(
//                                   mainAxisSize: pw.MainAxisSize.min,
//                                   mainAxisAlignment: pw.MainAxisAlignment.center,
//                                   crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                   children: [
//                                     pw.Text(officeInfo!.title,
//                                         style: pw.TextStyle(color: PdfColors.black, fontSize: 20 / 2, font: font123r, height: 0.08)),
//                                   ],
//                                 ),
//                               )
//                             ])),
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   static Future<pw.PageTheme> _tmBuildingPage3(PdfPageFormat format, pw.Font font123b, pw.Font font123r, pw.MemoryImage img1) async {
//     format = format.applyMargin(
//         left: 2.0 * PdfPageFormat.cm, top: 4.0 * PdfPageFormat.cm, right: 2.0 * PdfPageFormat.cm, bottom: 2.0 * PdfPageFormat.cm);
//     userNo = GV.pStrg.getXXX(commonUserNo);
//     dealNo = GV.pStrg.getXXX(myDealNo);
//     pdfDealType = GV.pStrg.getXXX(dealType);

//     if (pdfDealType == 'L') {
//       final MyDealDetailLandItem? ret2 = await IdApi.getMydaelDetail(userNo, dealNo, pdfDealType);
//       double k = 0;
//       double j = 0;
//       for (var i = 0; i < ret2!.lotList!.length; i++) {
//         k += double.parse(ret2.lotList![i].lotArea!);
//       }
//       lotArea = k.toString();
//       if (ret2.land!.totalFloorArea != null) {
//         totalArea = ret2.land!.totalFloorArea!;
//       } else {
//         totalArea = '-';
//       }
//       upperNum = ret2.land!.upperNum!;
//       lowerNum = ret2.land!.lowerNum!;
//       ccd = '-';
//       bdCoverageRatio = ret2.land!.buildingCoverage!;
//       totalFloorRatio = ret2.land!.totalFloorRatio!;
//       mainStruct = '-';
//       parkingNum = ret2.land!.parkingNum!;
//       reModel = '-';
//       for (var i = 0; i < ret2.lotList!.length; i++) {
//         j += double.parse(ret2.lotList![i].asking!);
//       }
//       asking = (j / 100000000).toString();
//       monthly = '-';
//       evacuation = '';
//     } else {
//       final MyDealDetailBuildingItem? ret2 = await IdApi.getMydaelDetail(userNo, dealNo, pdfDealType);
//       lotArea = ret2!.building!.lotArea!;
//       totalArea = ret2.building!.totalFloorArea!;
//       upperNum = ret2.building!.upperNum!;
//       lowerNum = ret2.building!.lowerNum!;
//       elevator = ret2.building!.elevator!;
//       ccd = ret2.building!.ccd!;
//       if (ret2.building!.bdCoverageRatio != null) {
//         bdCoverageRatio = ret2.building!.bdCoverageRatio!;
//       } else {
//         bdCoverageRatio = '0';
//       }
//       totalFloorRatio = ret2.building!.totalFloorRatio!;
//       mainStruct = ret2.building!.mainStruct!;
//       parkingNum = ret2.building!.parkingNum!;
//       if (ret2.building!.reModel == '-1') {
//         reModel = '확인중';
//       } else if (ret2.building!.reModel == '0') {
//         reModel = '없음';
//       } else {
//         reModel = ret2.building!.reModel!;
//       }
//       if (ret2.dealMaster!.asking != null) {
//         asking = (double.parse(ret2.dealMaster!.asking!) / 100000000).toString();
//       } else {
//         asking = '0';
//       }
//       deposit = (double.parse(ret2.building!.deposit!) / 10000).toString();
//       monthly = (double.parse(ret2.building!.monthly!) / 10000).toString();
//       if (ret2.dealMaster!.evacuationType == '0') {
//         evacuation = '-';
//       } else if (ret2.dealMaster!.evacuationType == '1') {
//         evacuation = '전층책임명도';
//       } else if (ret2.dealMaster!.evacuationType == '2') {
//         evacuation = '일부책임명도';
//       } else if (ret2.dealMaster!.evacuationType == '3') {
//         evacuation = '불가능';
//       } else if (ret2.dealMaster!.evacuationType == '4') {
//         evacuation = '협의';
//       } else {
//         evacuation = '-';
//       }
//     }

//     return pw.PageTheme(
//       pageFormat: format,
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//               width: 1684 / 2,
//               height: 1199 / 2,
//               decoration: pw.BoxDecoration(color: PdfColors.white),
//               child: pw.Stack(
//                 children: [
//                   pw.Positioned(
//                       left: 0,
//                       top: 0,
//                       child: _pageHead(
//                           font: font123b, title: '요약내용', address1: officeInfo!.address, address2: officeInfo!.title, headColor: baseColor)),
//                   pw.Positioned(
//                     left: 864 / 2,
//                     top: 130 / 2,
//                     child: pw.Container(
//                       width: 820 / 2,
//                       height: 1072 / 2,
//                       child: pw.Stack(
//                         children: [
//                           pw.Positioned(
//                             left: 0, //-429.07 / 2,
//                             top: 0,
//                             child: pw.Container(
//                                 width: 1633.33 / 2,
//                                 height: 1089.88 / 2,
//                                 decoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFFFFFF7C)),
//                                 child: pw.Image(img1)),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 690 / 2,
//                       child: pw.Container(
//                           width: 702 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 632 / 2,
//                       child: pw.Container(
//                           width: 702 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 922 / 2,
//                       child: pw.Container(
//                           width: 702 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 806 / 2,
//                       child: pw.Container(
//                           width: 702 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 748 / 2,
//                       child: pw.Container(
//                           width: 702 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   // pw.Positioned(
//                   //     left: 80 / 2,
//                   //     top: 980 / 2,
//                   //     child: pw.Container(
//                   //         width: 702 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   // pw.Positioned(
//                   //     left: 80 / 2,
//                   //     top: 1039 / 2,
//                   //     child: pw.Container(
//                   //         width: 702 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 864 / 2,
//                       child: pw.Container(
//                           width: 702 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   // pw.Positioned(
//                   //     left: 464 / 2,
//                   //     top: 1125 / 2,
//                   //     child: pw.Container(
//                   //         width: 734 / 2, height: 1, decoration: pw.BoxDecoration(color: baseColor, shape: pw.BoxShape.rectangle))),
//                   // pw.Positioned(
//                   //   left: 0,
//                   //   top: 0,
//                   //   child: pw.Container(
//                   //     width: 20 / 2,
//                   //     height: 190 / 2,
//                   //     decoration: pw.BoxDecoration(color: baseColor),
//                   //   ),
//                   // ),
//                   pw.Positioned(left: 60 / 2, top: 1110 / 2, child: _pageTail(tailMsg: officeInfo!.tailMsg(), font: font123r)),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 230 / 2,
//                       child: pw.Text('건축면적',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 230 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: '$lotArea㎡',
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 268 / 2,
//                       child: pw.Text('연면적',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 268 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: '$totalArea㎡',
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 306 / 2,
//                       child: pw.Text('층수',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 306 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: 'B$lowerNum/${upperNum}F',
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 344 / 2,
//                       child: pw.Text('승강기',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 344 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: '$elevator 대',
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 382 / 2,
//                       child: pw.Text('준공연도',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 382 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: ccd,
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 420 / 2,
//                       child: pw.Text('건폐율',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 420 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: '$bdCoverageRatio %',
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 458 / 2,
//                       child: pw.Text('용적률',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 458 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: '$totalFloorRatio %',
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 496 / 2,
//                       child: pw.Text('주구조',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 496 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: mainStruct,
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 534 / 2,
//                       child: pw.Text('주차',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 534 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: '$parkingNum 대',
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 572 / 2,
//                       child: pw.Text('리모델링',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 400 / 2,
//                       top: 572 / 2,
//                       child: pw.RichText(
//                           text: pw.TextSpan(children: [
//                         pw.TextSpan(
//                             text: reModel,
//                             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))
//                       ]))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 650 / 2,
//                       child: pw.Text('매도가',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 393 / 2,
//                       top: 650 / 2,
//                       child: pw.Text('$asking 억원',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFFFB6915), fontSize: 24 / 2, font: font123r, height: 0.10))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 710 / 2,
//                       child: pw.Text('보증금',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 393 / 2,
//                       top: 710 / 2,
//                       child: pw.Text('$deposit 만원',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFFFB6915), fontSize: 24 / 2, font: font123r, height: 0.10))),
// //                   pw.Positioned(
// //                       left: 80 / 2,
// //                       top: 770 / 2,
// //                       child: pw.Text('수익률',
// //                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// // ////TODO 수익률
// //                   pw.Positioned(
// //                       left: 393 / 2,
// //                       top: 770 / 2,
// //                       child: pw.Text('-',
// //                           style: pw.TextStyle(color: PdfColor.fromInt(0xFFFB6915), fontSize: 24 / 2, font: font123r, height: 0.10))),
// //                   pw.Positioned(
// //                       left: 80 / 2,
// //                       top: 825 / 2,
// //                       child: pw.Text('평단가 (대지평단가)',
// //                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// // ////TODO 평단가 (대지평단가)
// //                   pw.Positioned(
// //                       left: 393 / 2,
// //                       top: 825 / 2,
// //                       child: pw.Text('-',
// //                           style: pw.TextStyle(color: PdfColor.fromInt(0xFFFB6915), fontSize: 24 / 2, font: font123r, height: 0.10))),
// //                   pw.Positioned(
// //                       left: 80 / 2,
// //                       top: 885 / 2,
// //                       child: pw.Text('평단가 (연면적평단가)',
// //                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// // ////TODO 평단가 (연면적평단가)
// //                   pw.Positioned(
// //                       left: 393 / 2,
// //                       top: 885 / 2,
// //                       child: pw.Text('-',
// //                           style: pw.TextStyle(color: PdfColor.fromInt(0xFFFB6915), fontSize: 24 / 2, font: font123r, height: 0.10))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 770 / 2,
//                       child: pw.Text('월세',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 393 / 2,
//                       top: 770 / 2,
//                       child: pw.Text('$monthly 만원',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFFFB6915), fontSize: 24 / 2, font: font123r, height: 0.10))),
//                   pw.Positioned(
//                       left: 80 / 2,
//                       top: 825 / 2,
//                       child: pw.Text('명도',
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 20 / 2, font: font123r, height: 0.10))),
// ////
//                   pw.Positioned(
//                       left: 393 / 2,
//                       top: 825 / 2,
//                       child: pw.Text(evacuation,
//                           style: pw.TextStyle(color: PdfColor.fromInt(0xFFFB6915), fontSize: 24 / 2, font: font123r, height: 0.10))),
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   static Future<pw.PageTheme> _tmBuildingPage4(PdfPageFormat format, pw.Font font123b, pw.Font font123r, pw.MemoryImage img1) async {
//     final iconBuilding = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-Buildings.png')).buffer.asUint8List());
//     final iconMapPinLine = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-MapPinLine.png')).buffer.asUint8List());
//     final iconMapTrifold = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-MapTrifold.png')).buffer.asUint8List());
//     final iconNote = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-Note.png')).buffer.asUint8List());
//     final iconReceipt = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-Receipt.png')).buffer.asUint8List());

//     format = format.applyMargin(
//         left: 2.0 * PdfPageFormat.cm, top: 4.0 * PdfPageFormat.cm, right: 2.0 * PdfPageFormat.cm, bottom: 2.0 * PdfPageFormat.cm);
//     userNo = GV.pStrg.getXXX(commonUserNo);
//     dealNo = GV.pStrg.getXXX(myDealNo);
//     pdfDealType = GV.pStrg.getXXX(dealType);

//     if (pdfDealType == 'L') {
//       final MyDealDetailLandItem? ret2 = await IdApi.getMydaelDetail(userNo, dealNo, pdfDealType);
//       address = ret2!.dealMaster!.address!;
//       stationName = ret2.dealMaster!.stationName!;
//       buildingArea = ret2.land!.buildingArea!;
//       stationDistance = ret2.dealMaster!.stationDistance!;
//       bdCoverageRatio = ret2.land!.buildingCoverage!;
//       totalFloorArea = ret2.land!.totalFloorArea!;
//       totalFloorRatio = ret2.land!.totalFloorRatio!;
//       upperNum = ret2.land!.upperNum!;
//       lowerNum = ret2.land!.lowerNum!;
//       mainStruct = '-';
//       elevator = ret2.land!.elevator!;
//       parkingNum = ret2.land!.parkingNum!;

//       ccd = '';
//       reModel = '';
//       double j = 0;
//       double k = 0;
//       double l = 0;
//       double m = 0;
//       for (var i = 0; i < ret2.lotList!.length; i++) {
//         m += double.parse(ret2.lotList![i].lotArea!);
//       }
//       lotArea = m.toString();
//       areaPurpose = ret2.lotList![0].areaPurpose!;

//       for (var i = 0; i < ret2.lotList!.length; i++) {
//         j += double.parse(ret2.lotList![i].officialLandPrice!);
//       }
//       officialLandPrice = j.toString();

//       for (var i = 0; i < ret2.lotList!.length; i++) {
//         k += double.parse(ret2.lotList![i].totalLandPrice!);
//       }
//       totalLandPrice = k.toString();

//       for (var i = 0; i < ret2.lotList!.length; i++) {
//         l += double.parse(ret2.lotList![i].asking!);
//       }
//       asking = (l / 100000000).toString();

//       deposit = '-';
//       monthly = '-';
//       if (ret2.land!.etc != null) {
//         etc = ret2.land!.etc!;
//       } else {
//         etc = '';
//       }
//     } else {
//       final MyDealDetailBuildingItem? ret2 = await IdApi.getMydaelDetail(userNo, dealNo, pdfDealType);
//       address = ret2!.dealMaster!.address!;
//       stationName = ret2.dealMaster!.stationName!;
//       stationDistance = ret2.dealMaster!.stationDistance!;
//       if (ret2.building!.bdCoverageRatio != null) {
//         bdCoverageRatio = ret2.building!.bdCoverageRatio!;
//       } else {
//         bdCoverageRatio = '';
//       }
//       totalFloorArea = ret2.building!.totalFloorArea!;
//       totalFloorRatio = ret2.building!.totalFloorRatio!;
//       upperNum = ret2.building!.upperNum!;
//       lowerNum = ret2.building!.lowerNum!;
//       mainStruct = ret2.building!.mainStruct!;
//       elevator = ret2.building!.elevator!;
//       parkingNum = ret2.building!.parkingNum!;
//       ccd = ret2.building!.ccd!;
//       if (ret2.building!.reModel == '-1') {
//         reModel = '확인중';
//       } else if (ret2.building!.reModel == '0') {
//         reModel = '없음';
//       } else {
//         reModel = ret2.building!.reModel!;
//       }
//       lotArea = ret2.building!.lotArea!;
//       areaPurpose = ret2.building!.areaPurpose!;
//       officialLandPrice = ret2.building!.officialLandPrice!;
//       totalLandPrice = ret2.building!.totalLandPrice!;
//       if (ret2.dealMaster!.asking != null) {
//         asking = (double.parse(ret2.dealMaster!.asking!) / 100000000).toString();
//       } else {
//         asking = '';
//       }
//       deposit = (double.parse(ret2.building!.deposit!) / 10000).toString();
//       monthly = (double.parse(ret2.building!.monthly!) / 10000).toString();
//       if (ret2.building!.etc != null) {
//         etc = ret2.building!.etc!;
//       } else {
//         etc = '-';
//       }
//     }

//     return pw.PageTheme(
//       pageFormat: format,
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//               width: 1684 / 2,
//               height: 1199 / 2,
//               decoration: pw.BoxDecoration(color: PdfColors.white),
//               child: pw.Stack(
//                 children: [
//                   pw.Positioned(
//                       left: 0,
//                       top: 0,
//                       child: _pageHead(
//                           font: font123b,
//                           title: '건물/토지 기본정보',
//                           address1: officeInfo!.address,
//                           address2: officeInfo!.title,
//                           headColor: baseColor)),
//                   pw.Positioned(left: 60 / 2, top: 1110 / 2, child: _pageTail(tailMsg: officeInfo!.tailMsg(), font: font123r)),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 305 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE))),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('주변역',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 586 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('건폐율',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 748 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('층수',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 359 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('거리',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 640 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('연면적',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 802 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('주구조',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 856 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('승강기',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 910 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('주차',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 964 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('준공연도',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 1018 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('리모델링',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 1144 / 2,
//                     top: 558 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('보증금',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 1144 / 2,
//                     top: 612 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('월세',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // pw.Positioned(
//                   //   left: 620 / 2,
//                   //   top: 666 / 2,
//                   //   child: pw.Container(
//                   //     width: 200 / 2,
//                   //     height: 54 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       color: PdfColor.fromInt(0xFFF7F7F7),
//                   //       border: pw.Border(
//                   //         top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                   //         bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                   //       ),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         pw.Text('명도',
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('소재지',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 532 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('건축면적',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 694 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('용적률',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 558 / 2,
//                     child: pw.Container(
//                       width: 200 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('희망매도가격',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       width: 200 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('대지면적',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 305 / 2,
//                     child: pw.Container(
//                       width: 200 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('용도지역',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 359 / 2,
//                     child: pw.Container(
//                       width: 200 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: base1Color,
//                         border: pw.Border(top: pw.BorderSide(width: 1, color: baseColor)),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('공시지가',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 1144 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       width: 140 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222))),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('용도지구',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // pw.Positioned(
//                   //   left: 1144 / 2,
//                   //   top: 305 / 2,
//                   //   child: pw.Container(
//                   //     width: 140 / 2,
//                   //     height: 54 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       color: PdfColor.fromInt(0xFFF7F7F7),
//                   //       border: pw.Border(
//                   //         top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                   //       ),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         pw.Text('용도지구',
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 413 / 2,
//                     child: pw.Container(
//                       width: 200 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: base1Color,
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: baseColor),
//                           bottom: pw.BorderSide(width: 1, color: baseColor),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('공시지가 합계',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 820 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       width: 324 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //대지 면적
//                           pw.Text('$lotArea㎡',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           // 건물/토지 주소
//                           pw.Text(address,
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 532 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //TODO 건축면적
//                           pw.Text('㎡',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 797 / 2,
//                     child: pw.Container(
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Column(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Container(
//                             width: 1004 / 2,
//                             height: 137 / 2,
//                             padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                             decoration: pw.BoxDecoration(
//                               border: pw.Border(
//                                 top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                               ),
//                             ),
//                             child: pw.Row(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.start,
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Text(etc,
//                                     style:
//                                         pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 694 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //용적률
//                           pw.Text('$totalFloorRatio%',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 820 / 2,
//                     top: 558 / 2,
//                     child: pw.Container(
//                       width: 324 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //asking
//                           pw.Text('$asking 억원',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 1284 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //TODO 용도지구
//                           pw.Text('4-',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 820 / 2,
//                     top: 305 / 2,
//                     child: pw.Container(
//                       width: 804 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //용도지역
//                           pw.Text(areaPurpose,
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 305 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //역이름
//                           pw.Text(stationName,
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 586 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //건폐율
//                           pw.Text('$bdCoverageRatio%',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 748 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //층수
//                           pw.Text('B$lowerNum/${upperNum}F ',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   // pw.Positioned(
//                   //   left: 700 / 2,
//                   //   top: 720 / 2,
//                   //   child: pw.Container(
//                   //     width: 120 / 2,
//                   //     height: 54 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       color: base1Color,
//                   //       border: pw.Border(
//                   //         top: pw.BorderSide(width: 1, color: baseColor),
//                   //       ),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         pw.Text('대지평단가',
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   // pw.Positioned(
//                   //   left: 620 / 2,
//                   //   top: 720 / 2,
//                   //   child: pw.Container(
//                   //     width: 80 / 2,
//                   //     height: 107 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       color: base1Color,
//                   //       border: pw.Border(
//                   //         top: pw.BorderSide(width: 1, color: baseColor),
//                   //         right: pw.BorderSide(width: 1, color: baseColor),
//                   //         bottom: pw.BorderSide(width: 1, color: baseColor),
//                   //       ),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         pw.Text('평단가',
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09))
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   // pw.Positioned(
//                   //   left: 700 / 2,
//                   //   top: 773 / 2,
//                   //   child: pw.Container(
//                   //     width: 120 / 2,
//                   //     height: 54 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       color: base1Color,
//                   //       border: pw.Border(
//                   //         left: pw.BorderSide(width: 1, color: baseColor),
//                   //         top: pw.BorderSide(width: 1, color: baseColor),
//                   //         bottom: pw.BorderSide(width: 1, color: baseColor),
//                   //       ),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         pw.Text('연면적평단가',
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09))
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   // pw.Positioned(
//                   //   left: 820 / 2,
//                   //   top: 720 / 2,
//                   //   child: pw.Container(
//                   //     width: 804 / 2,
//                   //     height: 54 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       color: base2Color,
//                   //       border: pw.Border(
//                   //         top: pw.BorderSide(width: 1, color: baseColor),
//                   //       ),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         //TODO 대지 평단가
//                   //         pw.Text('6-',
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   // pw.Positioned(
//                   //   left: 820 / 2,
//                   //   top: 773 / 2,
//                   //   child: pw.Container(
//                   //     width: 804 / 2,
//                   //     height: 54 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       color: base2Color,
//                   //       border: pw.Border(
//                   //         top: pw.BorderSide(width: 0.3, color: baseColor),
//                   //         bottom: pw.BorderSide(width: 1, color: baseColor),
//                   //       ),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         //TODO 연면적평단가
//                   //         pw.Text('7-',
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   // pw.Positioned(
//                   //   left: 1284 / 2,
//                   //   top: 305 / 2,
//                   //   child: pw.Container(
//                   //     width: 340 / 2,
//                   //     height: 54 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       border: pw.Border(
//                   //         top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                   //         bottom: pw.BorderSide(color: PdfColor.fromInt(0xFFEEEEEE)),
//                   //       ),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         //TODO 용도지구
//                   //         pw.Text('8-',
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   pw.Positioned(
//                     left: 820 / 2,
//                     top: 413 / 2,
//                     child: pw.Container(
//                       width: 803 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: base2Color,
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: baseColor),
//                           bottom: pw.BorderSide(width: 1, color: baseColor),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //공시지가 합계
//                           pw.Text(NumberFormat('#,##0.00').format(double.parse(totalLandPrice) / 10000),
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 820 / 2,
//                     top: 359 / 2,
//                     child: pw.Container(
//                       width: 803 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: base2Color,
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: baseColor),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //공시지가
//                           pw.Text(NumberFormat('#,###').format(double.parse(officialLandPrice)),
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 359 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: pw.EdgeInsets.all(10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //역과의 거리
//                           pw.Text(stationDistance,
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 640 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //연면적
//                           pw.Text('$totalFloorArea ㎡',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 802 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //주구조
//                           pw.Text(mainStruct,
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 856 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //승강기
//                           pw.Text('$elevator 대',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 910 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //주차
//                           pw.Text('$parkingNum 대',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 964 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //준공연도
//                           pw.Text(ccd,
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 200 / 2,
//                     top: 1018 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 10 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //리모델링
//                           pw.Text(reModel,
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 1284 / 2,
//                     top: 558 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 2, color: PdfColor.fromInt(0xFF222222)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //보증금
//                           pw.Text('$deposit 만원',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 1284 / 2,
//                     top: 612 / 2,
//                     child: pw.Container(
//                       width: 340 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //월세
//                           pw.Text('$monthly 만원',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   // pw.Positioned(
//                   //   left: 820 / 2,
//                   //   top: 666 / 2,
//                   //   child: pw.Container(
//                   //     width: 804 / 2,
//                   //     height: 54 / 2,
//                   //     padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 12 / 2),
//                   //     decoration: pw.BoxDecoration(
//                   //       border: pw.Border(top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE))),
//                   //     ),
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //       children: [
//                   //         //명도
//                   //         pw.Text(evacuation,
//                   //             style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 612 / 2,
//                     child: pw.Container(
//                       width: 200 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 10 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         color: PdfColor.fromInt(0xFFF7F7F7),
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Text('명도',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 820 / 2,
//                     top: 612 / 2,
//                     child: pw.Container(
//                       width: 324 / 2,
//                       height: 54 / 2,
//                       padding: const pw.EdgeInsets.symmetric(horizontal: 16 / 2, vertical: 12 / 2),
//                       decoration: pw.BoxDecoration(
//                         border: pw.Border(
//                           top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                           bottom: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFFEEEEEE)),
//                         ),
//                       ),
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           //명도
//                           pw.Text(evacuation,
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09))
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 200 / 2,
//                     child: pw.Container(
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconMapPinLine)),
//                           pw.SizedBox(width: 8 / 2),
//                           pw.Text(
//                             '지역정보',
//                             style: pw.TextStyle(
//                               color: PdfColor.fromInt(0xFF222222),
//                               fontSize: 22 / 2,
//                               font: font123b,
//                               height: 0.07,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 481 / 2,
//                     child: pw.Container(
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconBuilding)),
//                           pw.SizedBox(width: 8 / 2),
//                           pw.Text(
//                             '건물정보',
//                             style: pw.TextStyle(
//                               color: PdfColor.fromInt(0xFF222222),
//                               fontSize: 22 / 2,
//                               font: font123b,
//                               height: 0.07,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 507 / 2,
//                     child: pw.Container(
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconReceipt)),
//                           pw.SizedBox(width: 8 / 2),
//                           pw.Text(
//                             '조건',
//                             style: pw.TextStyle(
//                               color: PdfColor.fromInt(0xFF222222),
//                               fontSize: 22 / 2,
//                               font: font123b,
//                               height: 0.07,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 200 / 2,
//                     child: pw.Container(
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconMapTrifold)),
//                           pw.SizedBox(width: 8 / 2),
//                           pw.Text(
//                             '토지정보',
//                             style: pw.TextStyle(
//                               color: PdfColor.fromInt(0xFF222222),
//                               fontSize: 22 / 2,
//                               font: font123b,
//                               height: 0.07,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 620 / 2,
//                     top: 746 / 2,
//                     child: pw.Container(
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconNote)),
//                           pw.SizedBox(width: 8 / 2),
//                           pw.Text(
//                             '기타 특이사항',
//                             style: pw.TextStyle(
//                               color: PdfColor.fromInt(0xFF222222),
//                               fontSize: 22 / 2,
//                               font: font123b,
//                               height: 0.07,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   ///임대정보, 11줄이 max
//   static Future<pw.PageTheme> _tmBuildingPage5(PdfPageFormat format, pw.Font font123b, pw.Font font123r, List<List<String>> data123,
//       {List<String>? total}) async {
//     format = format.applyMargin(left: 0, top: 0, right: 0, bottom: 0);
//     final iconBuilding = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-Buildings.png')).buffer.asUint8List());

//     final tableHeaders = [
//       _centerText(
//           width: 140 / 2,
//           msg: '층',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 300 / 2,
//           msg: '업종',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 200 / 2,
//           msg: '면적',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 200 / 2,
//           msg: '보증금(만원)',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 200 / 2,
//           msg: '임대로(만원)',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 434 / 2,
//           msg: '비고',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF))
//     ];

//     return pw.PageTheme(
//       pageFormat: format,
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//               width: 1684 / 2,
//               height: 1199 / 2,
//               decoration: pw.BoxDecoration(color: PdfColors.white),
//               child: pw.Stack(
//                 children: [
//                   pw.Positioned(
//                       left: 0,
//                       top: 0,
//                       child: _pageHead(
//                           font: font123b, title: '임대정보', address1: officeInfo!.address, address2: officeInfo!.title, headColor: baseColor)),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 200 / 2,
//                     child: pw.Container(
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconBuilding)),
//                           pw.SizedBox(width: 8 / 2),
//                           pw.Text(
//                             '임대정보',
//                             style: pw.TextStyle(
//                               color: PdfColor.fromInt(0xFF222222),
//                               fontSize: 22 / 2,
//                               font: font123b,
//                               height: 0.07,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       width: 1564 / 2,
//                       child: pw.Column(children: [
//                         pw.TableHelper.fromTextArray(
//                           border: pw.TableBorder(top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFF222222))),
//                           cellAlignment: pw.Alignment.centerLeft,
//                           headerDecoration: pw.BoxDecoration(
//                             borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
//                             color: PdfColor.fromInt(0xFFF7F7F7),
//                           ),
//                           headerHeight: 54 / 2,
//                           cellHeight: 64 / 2,
//                           cellAlignments: {
//                             0: pw.Alignment.center,
//                             1: pw.Alignment.center,
//                             2: pw.Alignment.center,
//                             3: pw.Alignment.center,
//                             4: pw.Alignment.center,
//                             5: pw.Alignment.center
//                           },
//                           headerStyle: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b),
//                           cellStyle: pw.TextStyle(
//                             color: PdfColor.fromInt(0xFF222222),
//                             fontSize: 18 / 2,
//                             font: font123r,
//                           ),
//                           rowDecoration: pw.BoxDecoration(
//                             border: pw.Border(
//                               bottom: pw.BorderSide(
//                                 color: PdfColor.fromInt(0xFFEEEEEE),
//                                 width: 1,
//                               ),
//                             ),
//                           ),
//                           headers: List<dynamic>.generate(
//                             tableHeaders.length,
//                             (col) => tableHeaders[col],
//                           ),
//                           data: List<List<dynamic>>.generate(
//                             data123.length,
//                             (row) => List<dynamic>.generate(tableHeaders.length, (col) => data123[row][col]),
//                           ),
//                         ),
//                         ////TOTAL
//                         total != null
//                             ? pw.Container(
//                                 height: 64 / 2,
//                                 width: 1564 / 2,
//                                 child: pw.Row(
//                                   mainAxisSize: pw.MainAxisSize.min,
//                                   mainAxisAlignment: pw.MainAxisAlignment.start,
//                                   crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                   children: [
//                                     pw.Container(
//                                       width: 450 / 2,
//                                       height: double.infinity,
//                                       padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2, vertical: 12 / 2),
//                                       decoration: pw.BoxDecoration(
//                                         color: base1Color,
//                                         border: pw.Border(
//                                           top: pw.BorderSide(width: 1, color: baseColor),
//                                           bottom: pw.BorderSide(width: 1, color: baseColor),
//                                         ),
//                                       ),
//                                       child: pw.Row(
//                                         mainAxisSize: pw.MainAxisSize.min,
//                                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                         children: [
//                                           pw.SizedBox(
//                                               width: 140 / 2,
//                                               child: pw.Text('TOTAL',
//                                                   textAlign: pw.TextAlign.center,
//                                                   style: pw.TextStyle(
//                                                       color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)))
//                                         ],
//                                       ),
//                                     ),
//                                     pw.Container(
//                                       width: 1113 / 2,
//                                       height: double.infinity,
//                                       padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2, vertical: 12 / 2),
//                                       decoration: pw.BoxDecoration(
//                                         color: base2Color,
//                                         border: pw.Border(
//                                           top: pw.BorderSide(width: 1, color: baseColor),
//                                           bottom: pw.BorderSide(width: 1, color: baseColor),
//                                         ),
//                                       ),
//                                       child: pw.Row(
//                                         mainAxisSize: pw.MainAxisSize.min,
//                                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                         children: [
//                                           pw.SizedBox(
//                                             width: 200 / 2,
//                                             child: pw.Text(total[0] + ' ㎡',
//                                                 textAlign: pw.TextAlign.center,
//                                                 style: pw.TextStyle(
//                                                     color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                                           ),
//                                           pw.SizedBox(width: 16 / 2),
//                                           pw.SizedBox(
//                                             width: 200 / 2,
//                                             child: pw.Text(total[1] + ' 만원',
//                                                 textAlign: pw.TextAlign.center,
//                                                 style: pw.TextStyle(
//                                                     color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                                           ),
//                                           pw.SizedBox(width: 16 / 2),
//                                           pw.SizedBox(
//                                             width: 200 / 2,
//                                             child: pw.Text(total[2] + ' 만원',
//                                                 textAlign: pw.TextAlign.center,
//                                                 style: pw.TextStyle(
//                                                     color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ],
//                                 ),
//                               )
//                             : pw.SizedBox()
//                       ]),
//                     ),
//                   ),
//                   pw.Positioned(left: 60 / 2, top: 1110 / 2, child: _pageTail(tailMsg: officeInfo!.tailMsg(), font: font123r))
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   ///층별정보, 11줄이 max
//   static Future<pw.PageTheme> _tmBuildingPage6(PdfPageFormat format, pw.Font font123b, pw.Font font123r, List<List<String>> data123) async {
//     format = format.applyMargin(left: 0, top: 0, right: 0, bottom: 0);
//     final iconBuilding = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-stack.png')).buffer.asUint8List());

//     final tableHeaders = [
//       _centerText(
//           width: 292 / 2,
//           msg: '구분',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 292 / 2,
//           msg: '층',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 292 / 2,
//           msg: '구조',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 292 / 2,
//           msg: '용도',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//       _centerText(
//           width: 292 / 2,
//           msg: '면적(㎡)',
//           font: font123r,
//           symPadSize: 2,
//           fontColor: PdfColor.fromInt(0xFF222222),
//           backColor: PdfColor.fromInt(0xFFFFFFFF)),
//     ];

//     return pw.PageTheme(
//       pageFormat: format,
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//               width: 1684 / 2,
//               height: 1199 / 2,
//               decoration: pw.BoxDecoration(color: PdfColors.white),
//               child: pw.Stack(
//                 children: [
//                   pw.Positioned(
//                       left: 0,
//                       top: 0,
//                       child: _pageHead(
//                           font: font123b, title: '충별정보', address1: officeInfo!.address, address2: officeInfo!.title, headColor: baseColor)),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 200 / 2,
//                     child: pw.Container(
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconBuilding)),
//                           pw.SizedBox(width: 8 / 2),
//                           pw.Text(
//                             '층별정보',
//                             style: pw.TextStyle(
//                               color: PdfColor.fromInt(0xFF222222),
//                               fontSize: 22 / 2,
//                               font: font123b,
//                               height: 0.07,
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       width: 1564 / 2,
//                       child: pw.Column(children: [
//                         pw.TableHelper.fromTextArray(
//                           border: pw.TableBorder(top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFF222222))),
//                           cellAlignment: pw.Alignment.centerLeft,
//                           headerDecoration: pw.BoxDecoration(
//                             borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
//                             color: PdfColor.fromInt(0xFFF7F7F7),
//                           ),
//                           headerHeight: 54 / 2,
//                           cellHeight: 64 / 2,
//                           cellAlignments: {
//                             0: pw.Alignment.center,
//                             1: pw.Alignment.center,
//                             2: pw.Alignment.center,
//                             3: pw.Alignment.center,
//                             4: pw.Alignment.center,
//                             5: pw.Alignment.center
//                           },
//                           headerStyle: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b),
//                           cellStyle: pw.TextStyle(
//                             color: PdfColor.fromInt(0xFF222222),
//                             fontSize: 18 / 2,
//                             font: font123r,
//                           ),
//                           rowDecoration: pw.BoxDecoration(
//                             border: pw.Border(
//                               bottom: pw.BorderSide(
//                                 color: PdfColor.fromInt(0xFFEEEEEE),
//                                 width: 1,
//                               ),
//                             ),
//                           ),
//                           headers: List<dynamic>.generate(
//                             tableHeaders.length,
//                             (col) => tableHeaders[col],
//                           ),
//                           data: List<List<dynamic>>.generate(
//                             data123.length,
//                             (row) => List<dynamic>.generate(tableHeaders.length, (col) => data123[row][col]),
//                           ),
//                         ),
//                       ]),
//                     ),
//                   ),
//                   pw.Positioned(left: 60 / 2, top: 1110 / 2, child: _pageTail(tailMsg: officeInfo!.tailMsg(), font: font123r))
//                 ],
//               ),
//             ));
//       },
//     );
//   }

//   ///사진
//   static Future<pw.PageTheme> _tmBuildingPage7(PdfPageFormat format, pw.Font font123b, pw.Font font123r, List<pw.MemoryImage> imgs1,
//       {List<pw.MemoryImage>? imgs2}) async {
//     final iconImage = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-Image.png')).buffer.asUint8List());

//     return pw.PageTheme(
//       pageFormat: format.applyMargin(left: 0, top: 0, right: 0, bottom: 0),
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//                 width: 1684 / 2,
//                 height: 1199 / 2,
//                 decoration: pw.BoxDecoration(color: PdfColors.white),
//                 child: pw.Stack(children: [
//                   pw.Positioned(
//                       left: 0,
//                       top: 0,
//                       child: _pageHead(
//                           font: font123b, title: '사진', address1: officeInfo!.address, address2: officeInfo!.title, headColor: baseColor)),
//                   pw.Positioned(left: 60 / 2, top: 1110 / 2, child: _pageTail(tailMsg: officeInfo!.tailMsg(), font: font123r)),
//                   pw.Positioned(
//                       left: 60 / 2,
//                       top: 200 / 2,
//                       child: pw.Container(
//                         child: pw.Row(
//                           mainAxisSize: pw.MainAxisSize.min,
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           crossAxisAlignment: pw.CrossAxisAlignment.center,
//                           children: [
//                             pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconImage)),
//                             pw.SizedBox(width: 8 / 2),
//                             pw.Text('사진보기',
//                                 style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 22 / 2, font: font123b, height: 0.07)),
//                           ],
//                         ),
//                       )),
//                   pw.Positioned(
//                       left: 63 / 2,
//                       top: 251 / 2,
//                       child: pw.Container(
//                         width: 1564 / 2,
//                         height: (376 + 16 + 29) / 2,
//                         decoration: pw.BoxDecoration(color: PdfColors.white),
//                         child: pw.GridView(
//                             crossAxisCount: 4,
//                             children: List.generate(
//                                 imgs1.length,
//                                 (index) => (imgDocList[index] != '')
//                                     ? pw.Column(
//                                         mainAxisSize: pw.MainAxisSize.min,
//                                         mainAxisAlignment: pw.MainAxisAlignment.center,
//                                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                         children: [
//                                             pw.Container(width: 376 / 2, height: 376 / 2, child: pw.Image(imgs1[index])),
//                                             pw.SizedBox(height: 16 / 2),
//                                             pw.Text(imgDocList[index],
//                                                 style: pw.TextStyle(
//                                                     color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.07)),
//                                           ])
//                                     : pw.SizedBox())),
//                       )),
//                   pw.Positioned(
//                       left: 63 / 2,
//                       top: 712 / 2,
//                       child: imgs2 != null
//                           ? pw.Container(
//                               width: 1564 / 2,
//                               height: (246 + 16 + 29) / 2,
//                               decoration: pw.BoxDecoration(color: PdfColors.white),
//                               child: pw.GridView(
//                                   crossAxisCount: 6,
//                                   children: List.generate(
//                                       imgs2.length,
//                                       (index) => (imgDocList[index + 4] != '')
//                                           ? pw.Column(
//                                               mainAxisSize: pw.MainAxisSize.min,
//                                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                                               children: [
//                                                   pw.Container(width: 246 / 2, height: 246 / 2, child: pw.Image(imgs2[index])),
//                                                   pw.SizedBox(height: 16 / 2),
//                                                   pw.Text(imgDocList[index + 4],
//                                                       style: pw.TextStyle(
//                                                           color: PdfColor.fromInt(0xFF222222),
//                                                           fontSize: 18 / 2,
//                                                           font: font123r,
//                                                           height: 0.07)),
//                                                 ])
//                                           : pw.SizedBox())),
//                             )
//                           : pw.SizedBox())
//                 ])));
//       },
//     );
//   }

//   /// Appendix 평면도
//   static Future<pw.PageTheme> _tmBuildingPage8(
//       PdfPageFormat format, pw.Font font123b, pw.Font font123r, pw.MemoryImage img1, String subTitle) async {
//     final iconImage = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-appendix.png')).buffer.asUint8List());
//     return pw.PageTheme(
//       pageFormat: format.applyMargin(left: 0, top: 0, right: 0, bottom: 0),
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//                 width: 1684 / 2,
//                 height: 1199 / 2,
//                 decoration: pw.BoxDecoration(color: PdfColors.white),
//                 child: pw.Stack(children: [
//                   pw.Positioned(
//                       left: 0,
//                       top: 0,
//                       child: _pageHead(
//                           font: font123b,
//                           title: 'Appendix',
//                           address1: officeInfo!.address,
//                           address2: officeInfo!.title,
//                           headColor: baseColor)),
//                   pw.Positioned(left: 60 / 2, top: 1110 / 2, child: _pageTail(tailMsg: officeInfo!.tailMsg(), font: font123r)),
//                   pw.Positioned(
//                       left: 60 / 2,
//                       top: 200 / 2,
//                       child: pw.Container(
//                         child: pw.Row(
//                           mainAxisSize: pw.MainAxisSize.min,
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           crossAxisAlignment: pw.CrossAxisAlignment.center,
//                           children: [
//                             pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconImage)),
//                             pw.SizedBox(width: 8 / 2),
//                             pw.Text(subTitle,
//                                 style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 22 / 2, font: font123b, height: 0.07)),
//                           ],
//                         ),
//                       )),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                         padding: pw.EdgeInsets.all(23 / 2),
//                         width: 1564 / 2,
//                         height: 832 / 2,
//                         decoration: pw.BoxDecoration(
//                           border: pw.Border(
//                               top: pw.BorderSide(color: PdfColor.fromInt(0xFF222222), width: 0.3),
//                               bottom: pw.BorderSide(color: PdfColor.fromInt(0xFF222222), width: 0.3),
//                               left: pw.BorderSide(color: PdfColor.fromInt(0xFF222222), width: 0.3),
//                               right: pw.BorderSide(color: PdfColor.fromInt(0xFF222222), width: 0.3)),
//                         ),
//                         child: pw.Center(child: pw.Image(img1))),
//                   ),
//                 ])));
//       },
//     );
//   }

//   /// 토지이용계획
//   static Future<pw.PageTheme> _tmBuildingPage9(
//       PdfPageFormat format, pw.Font font123b, pw.Font font123r, pw.MemoryImage img1, pw.MemoryImage imgMap) async {
//     final iconNote = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-Note.png')).buffer.asUint8List());
//     final iconMap = pw.MemoryImage((await rootBundle.load('assets/img/tm-icon-MapPinLine.png')).buffer.asUint8List());
//     userNo = GV.pStrg.getXXX(commonUserNo);
//     dealNo = GV.pStrg.getXXX(myDealNo);
//     pdfDealType = GV.pStrg.getXXX(dealType);

//     if (pdfDealType == 'L') {
//       final MyDealDetailLandItem? ret2 = await IdApi.getMydaelDetail(userNo, dealNo, pdfDealType);
//     } else {
//       final MyDealDetailBuildingItem? ret2 = await IdApi.getMydaelDetail(userNo, dealNo, pdfDealType);
//     }

//     return pw.PageTheme(
//       pageFormat: format.applyMargin(left: 0, top: 0, right: 0, bottom: 0),
//       theme: pw.ThemeData.withFont(base: font123r),
//       buildBackground: (pw.Context context) {
//         return pw.FullPage(
//             ignoreMargins: true,
//             child: pw.Container(
//               width: 1684 / 2,
//               height: 1199 / 2,
//               decoration: pw.BoxDecoration(color: PdfColors.white),
//               child: pw.Stack(
//                 children: [
//                   pw.Positioned(
//                       left: 0,
//                       top: 0,
//                       child: _pageHead(
//                           font: font123b,
//                           title: '토지이용계획',
//                           address1: officeInfo!.address,
//                           address2: officeInfo!.title,
//                           headColor: baseColor)),
//                   pw.Positioned(left: 60 / 2, top: 1110 / 2, child: _pageTail(tailMsg: officeInfo!.tailMsg(), font: font123r)),
//                   pw.Positioned(
//                       left: 60 / 2,
//                       top: 200 / 2,
//                       child: pw.Container(
//                         child: pw.Row(
//                           mainAxisSize: pw.MainAxisSize.min,
//                           mainAxisAlignment: pw.MainAxisAlignment.start,
//                           crossAxisAlignment: pw.CrossAxisAlignment.center,
//                           children: [
//                             pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconNote)),
//                             pw.SizedBox(width: 8 / 2),
//                             pw.Text('토지이용계획',
//                                 style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 22 / 2, font: font123b, height: 0.07))
//                           ],
//                         ),
//                       )),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 251 / 2,
//                     child: pw.Container(
//                       height: 54 / 2,
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Container(
//                             width: 300 / 2,
//                             height: double.infinity,
//                             padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2),
//                             decoration: pw.BoxDecoration(
//                               color: PdfColor.fromInt(0xFFF7F7F7),
//                               border: pw.Border(top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFF222222))),
//                             ),
//                             child: pw.Row(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Text('소재지',
//                                     textAlign: pw.TextAlign.center,
//                                     style:
//                                         pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09))
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 472 / 2,
//                             height: double.infinity,
//                             padding: pw.EdgeInsets.symmetric(horizontal: 16 / 2),
//                             decoration: pw.BoxDecoration(
//                               border: pw.Border(
//                                 top: pw.BorderSide(width: 1, color: PdfColor.fromInt(0xFF222222)),
//                               ),
//                             ),
//                             child: pw.Row(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.SizedBox(
//                                   width: 140 / 2,
//                                   child: pw.Text(address,
//                                       textAlign: pw.TextAlign.center,
//                                       style: pw.TextStyle(
//                                           color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // pw.Positioned(
//                   //   left: 60 / 2,
//                   //   top: 305 / 2,
//                   //   child: pw.Container(
//                   //     height: 54 / 2,
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.start,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   //       children: [
//                   //         pw.Container(
//                   //           width: 300 / 2,
//                   //           height: double.infinity,
//                   //           padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2),
//                   //           decoration: pw.BoxDecoration(
//                   //             color: PdfColor.fromInt(0xFFF7F7F7),
//                   //             border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE))),
//                   //           ),
//                   //           child: pw.Row(
//                   //             mainAxisSize: pw.MainAxisSize.min,
//                   //             mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //             crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //             children: [
//                   //               pw.Text('지목',
//                   //                   textAlign: pw.TextAlign.center,
//                   //                   style:
//                   //                       pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //         pw.Container(
//                   //           width: 472 / 2,
//                   //           height: double.infinity,
//                   //           padding: pw.EdgeInsets.symmetric(horizontal: 16 / 2),
//                   //           decoration:
//                   //               pw.BoxDecoration(border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE)))),
//                   //           child: pw.Row(
//                   //             mainAxisSize: pw.MainAxisSize.min,
//                   //             mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //             crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //             children: [
//                   //               pw.SizedBox(
//                   //                 width: 140 / 2,
//                   //                 child: pw.Text('12-',
//                   //                     textAlign: pw.TextAlign.center,
//                   //                     style: pw.TextStyle(
//                   //                         color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09)),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 305 / 2,
//                     // top: 359 / 2,
//                     child: pw.Container(
//                       height: 54 / 2,
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Container(
//                             width: 300 / 2,
//                             height: double.infinity,
//                             padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2),
//                             decoration: pw.BoxDecoration(
//                               color: PdfColor.fromInt(0xFFF7F7F7),
//                               border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE))),
//                             ),
//                             child: pw.Row(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Text('면적',
//                                     textAlign: pw.TextAlign.center,
//                                     style:
//                                         pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 472 / 2,
//                             height: double.infinity,
//                             padding: pw.EdgeInsets.symmetric(horizontal: 16 / 2),
//                             decoration: pw.BoxDecoration(
//                               border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE))),
//                             ),
//                             child: pw.Row(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.SizedBox(
//                                   width: 140 / 2,
//                                   child: pw.Text('$lotArea ㎡',
//                                       textAlign: pw.TextAlign.center,
//                                       style: pw.TextStyle(
//                                           color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 60 / 2,
//                     top: 359 / 2,
//                     // top: 413 / 2,
//                     child: pw.Container(
//                       height: 54 / 2,
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Container(
//                             width: 300 / 2,
//                             height: double.infinity,
//                             padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2),
//                             decoration: pw.BoxDecoration(
//                                 color: PdfColor.fromInt(0xFFF7F7F7),
//                                 border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE)))),
//                             child: pw.Row(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Text('개별공시지가(㎡당)',
//                                     textAlign: pw.TextAlign.center,
//                                     style:
//                                         pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             width: 472 / 2,
//                             height: double.infinity,
//                             padding: pw.EdgeInsets.symmetric(horizontal: 16 / 2),
//                             decoration: pw.BoxDecoration(
//                               border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE))),
//                             ),
//                             child: pw.Row(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.SizedBox(
//                                   width: 140 / 2,
//                                   child: pw.Text('${double.parse(officialLandPrice) / 10000} 만원',
//                                       textAlign: pw.TextAlign.center,
//                                       style: pw.TextStyle(
//                                           color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09)),
//                                 ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // pw.Positioned(
//                   //   left: 60 / 2,
//                   //   top: 666 / 2,
//                   //   // top: 720 / 2,
//                   //   child: pw.Container(
//                   //     height: 349 / 2,
//                   //     child: pw.Row(
//                   //       mainAxisSize: pw.MainAxisSize.min,
//                   //       mainAxisAlignment: pw.MainAxisAlignment.start,
//                   //       crossAxisAlignment: pw.CrossAxisAlignment.start,
//                   //       children: [
//                   //         pw.Container(
//                   //           width: 300 / 2,
//                   //           height: double.infinity,
//                   //           padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2),
//                   //           decoration: pw.BoxDecoration(
//                   //             color: PdfColor.fromInt(0xFFF7F7F7),
//                   //             border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE))),
//                   //           ),
//                   //           child: pw.Row(
//                   //             mainAxisSize: pw.MainAxisSize.min,
//                   //             mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //             crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //             children: [
//                   //               pw.Text('토지이용규제 기본법\n시행령 제 9조 제4항 각호에\n해당되는 사항',
//                   //                   textAlign: pw.TextAlign.center,
//                   //                   style:
//                   //                       pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //         pw.Container(
//                   //           width: 472 / 2,
//                   //           height: double.infinity,
//                   //           padding: pw.EdgeInsets.symmetric(horizontal: 16 / 2),
//                   //           decoration: pw.BoxDecoration(
//                   //             border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE))),
//                   //           ),
//                   //           child: pw.Row(
//                   //             mainAxisSize: pw.MainAxisSize.min,
//                   //             mainAxisAlignment: pw.MainAxisAlignment.center,
//                   //             crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   //             children: [
//                   //               pw.SizedBox(
//                   //                 width: 140 / 2,
//                   //                 child: pw.Text('15-',
//                   //                     textAlign: pw.TextAlign.center,
//                   //                     style: pw.TextStyle(
//                   //                         color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123r, height: 0.09)),
//                   //               ),
//                   //             ],
//                   //           ),
//                   //         ),
//                   //       ],
//                   //     ),
//                   //   ),
//                   // ),
//                   pw.Positioned(
//                     left: 59 / 2,
//                     top: 413 / 2,
//                     // top: 467 / 2,
//                     child: pw.Container(
//                       // height: 253
//                       height: 176 / 2,
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.start,
//                         children: [
//                           pw.Container(
//                             width: 300 / 2,
//                             height: double.infinity,
//                             padding: pw.EdgeInsets.symmetric(horizontal: 20 / 2),
//                             decoration: pw.BoxDecoration(
//                                 color: PdfColor.fromInt(0xFFF7F7F7),
//                                 border: pw.Border(
//                                   top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE)),
//                                 )),
//                             child: pw.Row(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.center,
//                               crossAxisAlignment: pw.CrossAxisAlignment.center,
//                               children: [
//                                 pw.Text('지역지구',
//                                     textAlign: pw.TextAlign.center,
//                                     style:
//                                         pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                               ],
//                             ),
//                           ),
//                           pw.Container(
//                             height: double.infinity,
//                             child: pw.Column(
//                               mainAxisSize: pw.MainAxisSize.min,
//                               mainAxisAlignment: pw.MainAxisAlignment.start,
//                               crossAxisAlignment: pw.CrossAxisAlignment.start,
//                               children: [
//                                 pw.Expanded(
//                                   child: pw.Container(
//                                     width: 472 / 2,
//                                     padding: pw.EdgeInsets.all(16 / 2),
//                                     decoration: pw.BoxDecoration(
//                                       border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE))),
//                                     ),
//                                     child: pw.Row(
//                                       mainAxisSize: pw.MainAxisSize.min,
//                                       mainAxisAlignment: pw.MainAxisAlignment.center,
//                                       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                       children: [
//                                         pw.Text('',
//                                             // '국토의계획 및 이용에관한법률에 따른 지역 지구 등\n-',
//                                             textAlign: pw.TextAlign.center,
//                                             style: pw.TextStyle(
//                                                 color: PdfColor.fromInt(0xFFFB6915), fontSize: 18 / 2, font: font123r, height: 0.09)),
//                                       ],
//                                     ),
//                                   ),
//                                 ),
//                                 // pw.Expanded(
//                                 //   child: pw.Container(
//                                 //     width: 472 / 2,
//                                 //     padding: pw.EdgeInsets.all(16 / 2),
//                                 //     decoration: pw.BoxDecoration(
//                                 //       border: pw.Border(top: pw.BorderSide(width: 0.5, color: PdfColor.fromInt(0xFFEEEEEE))),
//                                 //     ),
//                                 //     child: pw.Row(
//                                 //       mainAxisSize: pw.MainAxisSize.min,
//                                 //       mainAxisAlignment: pw.MainAxisAlignment.center,
//                                 //       crossAxisAlignment: pw.CrossAxisAlignment.center,
//                                 //       children: [
//                                 //         pw.Text('',
//                                 //             // '다른 법령 등에 따른 지역 지구등\n-',
//                                 //             textAlign: pw.TextAlign.center,
//                                 //             style: pw.TextStyle(
//                                 //                 color: PdfColor.fromInt(0xFFFB6915), fontSize: 18 / 2, font: font123b, height: 0.09)),
//                                 //       ],
//                                 //     ),
//                                 //   ),
//                                 // ),
//                               ],
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 864 / 2,
//                     top: 200 / 2,
//                     child: pw.Container(
//                       child: pw.Row(
//                         mainAxisSize: pw.MainAxisSize.min,
//                         mainAxisAlignment: pw.MainAxisAlignment.start,
//                         crossAxisAlignment: pw.CrossAxisAlignment.center,
//                         children: [
//                           pw.Container(width: 28 / 2, height: 28 / 2, child: pw.Image(iconMap)),
//                           pw.SizedBox(width: 8 / 2),
//                           pw.Text('위치정보',
//                               style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 22 / 2, font: font123b, height: 0.07)),
//                         ],
//                       ),
//                     ),
//                   ),
//                   pw.Positioned(
//                     left: 864 / 2,
//                     top: 240 / 2,
//                     child: pw.Container(
//                       width: 760 / 2,
//                       height: 844 / 2,
//                       padding: pw.EdgeInsets.fromLTRB(0, 10, 0, 10),
//                       child: pw.Center(child: pw.Image(imgMap)),
//                     ),
//                   ),
//                 ],
//               ),
//             ));
//       },
//     );
//   }
// }

// class _pageTail extends pw.StatelessWidget {
//   final String tailMsg;
//   final pw.Font font;
//   _pageTail({
//     required this.tailMsg,
//     required this.font,
//   });

//   @override
//   pw.Widget build(pw.Context context) {
//     return pw.Container(
//       width: 1564 / 2,
//       height: 29 / 2,
//       child: pw.Stack(
//         children: [
//           pw.Positioned(
//               right: 0,
//               top: 0,
//               child:
//                   pw.Text(tailMsg, style: pw.TextStyle(color: PdfColor.fromInt(0xFF999999), fontSize: 18 / 2, font: font, height: 0.09))),
//           pw.Positioned(
//             left: 0,
//             top: 4 / 2,
//             child: pw.SizedBox(
//               width: 483 / 2,
//               child: pw.Text('Property Analysis',
//                   style: pw.TextStyle(
//                       color: PdfColor.fromInt(0xFF999999), fontSize: 14 / 2, font: font, height: 0.11, letterSpacing: 17.08 / 2)),
//             ),
//           ),
//           pw.Positioned(
//               left: 404 / 2,
//               top: 15 / 2,
//               child: pw.Container(
//                   width: 734 / 2, height: 0.3, decoration: pw.BoxDecoration(color: TmPdf.baseColor, shape: pw.BoxShape.rectangle))),
//         ],
//       ),
//     );
//   }
// }

// class _pageHead extends pw.StatelessWidget {
//   final String title;
//   final String address1;
//   final String address2;
//   final PdfColor headColor;
//   final pw.Font font;
//   _pageHead({
//     required this.title,
//     required this.address1,
//     required this.address2,
//     required this.headColor,
//     required this.font,
//   });

//   @override
//   pw.Widget build(pw.Context context) {
//     return pw.Container(
//         width: 1684 / 2,
//         height: 300 / 2,
//         child: pw.Stack(
//           children: [
//             pw.Positioned(
//                 left: 0, top: 0, child: pw.Container(width: 20 / 2, height: 190 / 2, decoration: pw.BoxDecoration(color: headColor))),
//             pw.Positioned(
//                 left: 60 / 2,
//                 top: 60 / 2,
//                 child:
//                     pw.Text(title, style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 48 / 2, font: font, height: 0.03))),
//             pw.Positioned(
//                 right: 57 / 2,
//                 top: 81 / 2,
//                 child: pw.Row(
//                   mainAxisSize: pw.MainAxisSize.min,
//                   mainAxisAlignment: pw.MainAxisAlignment.start,
//                   crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   children: [
//                     pw.Text(address1,
//                         style: pw.TextStyle(
//                             color: PdfColor.fromInt(0xFF222222), fontWeight: pw.FontWeight.normal, fontSize: 20 / 2, height: 0.08)),
//                     pw.SizedBox(width: 16 / 2),
//                     pw.Text(address2, style: pw.TextStyle(color: PdfColor.fromInt(0xFF222222), fontSize: 22 / 2, font: font, height: 0.07)),
//                   ],
//                 ))
//           ],
//         ));
//   }
// }

// class _centerText extends pw.StatelessWidget {
//   final double width;
//   final String msg;
//   final pw.Font font;
//   final double symPadSize;
//   final PdfColor fontColor;
//   final PdfColor backColor;
//   _centerText({
//     required this.width,
//     required this.msg,
//     required this.font,
//     required this.symPadSize,
//     required this.fontColor,
//     required this.backColor,
//   });

//   @override
//   pw.Widget build(pw.Context context) {
//     return pw.Container(
//         width: width,
//         child: pw.Row(
//             mainAxisSize: pw.MainAxisSize.min,
//             mainAxisAlignment: pw.MainAxisAlignment.center,
//             crossAxisAlignment: pw.CrossAxisAlignment.center,
//             children: [
//               pw.Container(
//                 padding: pw.EdgeInsets.symmetric(horizontal: symPadSize),
//                 decoration: pw.BoxDecoration(color: backColor),
//                 child: pw.Row(
//                   mainAxisSize: pw.MainAxisSize.min,
//                   mainAxisAlignment: pw.MainAxisAlignment.center,
//                   crossAxisAlignment: pw.CrossAxisAlignment.center,
//                   children: [
//                     pw.Text(msg, style: pw.TextStyle(color: fontColor, fontSize: 20 / 2, font: font, height: 0.08)),
//                   ],
//                 ),
//               )
//             ]));
//   }
// }

// class baseOffice {
//   String title;
//   String office;
//   String tel;
//   String address;
//   baseOffice(
//     this.title,
//     this.office,
//     this.tel,
//     this.address,
//   );
//   String tailMsg() {
//     return office + ' ' + tel;
//   }
// }
