// ignore_for_file: public_member_api_docs, sort_constructors_first, prefer_interpolation_to_compose_strings
// ignore_for_file: prefer_const_constructors, camel_case_types

import 'dart:async';
import 'dart:typed_data';

import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/modelVO/certItme.dart';

import '../../modelVO/ssoModel.dart';

class CertPdf {
  static Future<Uint8List> generateCert(PdfPageFormat format, ssoMember? ssoUser1) async {
    final doc =
        pw.Document(title: 'Certification', subject: 'Certification', compress: false, author: 'DEALSTATION', pageMode: PdfPageMode.thumbs);

    List<pw.PageTheme> lists = [];
    final page1 = await _certPage1(format);
    lists.add(page1);

    for (var p1 in lists) {
      doc.addPage(pw.Page(pageTheme: p1, build: (context) => pw.SizedBox(width: double.infinity, height: 425)));
    }
    return doc.save();
  }

  static Future<pw.PageTheme> _certPage1(PdfPageFormat format) async {
    format = format.applyMargin(left: 0, top: 0, right: 0, bottom: 0);
    var font123b = await PdfGoogleFonts.nanumMyeongjoBold();
    var font123r = await PdfGoogleFonts.nanumMyeongjoRegular();
    var fontCert = await PdfGoogleFonts.msMadiRegular();
    String address = '';
    String type = '';
    String category = '';
    String userName = '';
    String office = '';
    String createDate = '';
    String startDate = '';
    String endDate = '';
    String today = DateFormat('yyyy.MM.dd').format(DateTime.now());
    final backImg = pw.MemoryImage((await rootBundle.load('assets/img/cert-back.png')).buffer.asUint8List());
    final dealImg = pw.MemoryImage((await rootBundle.load('assets/img/cert-icon-dealstation.png')).buffer.asUint8List());

    final CertItem? ret1 = await IdApi.getCert(GV.pStrg.getXXX(Param_myDealNo));
    if (ret1 != null) {
      address = ret1.address! + ' ' + ret1.addressDtl!;
      if (ret1.type == "B") {
        type = '건물';
      } else {
        type = '신축부지';
      }
      if (ret1.category == '1') {
        category = '매각';
      } else {
        category = '위탁운영';
      }
      if (ret1.createDate != null) {
        createDate = ret1.createDate!;
      } else {
        createDate = ret1.startDate!;
      }
      userName = ret1.userName!;
      if (ret1.office != null) {
        office = ret1.office!;
      } else {
        office = '-';
      }
      startDate = ret1.startDate!;
      endDate = ret1.endDate!;
    }

    return pw.PageTheme(
      pageFormat: format,
      theme: pw.ThemeData.withFont(base: font123r, bold: Font.ttf(await rootBundle.load('assets/fonts/Pretendard-Light.ttf'))),
      buildBackground: (pw.Context context) {
        return pw.FullPage(
            ignoreMargins: true,
            child: pw.Container(
              width: 1199 / 2,
              height: 1684 / 2,
              decoration: pw.BoxDecoration(color: PdfColor.fromInt(0xFF3E3A34)),
              child: pw.Stack(
                children: [
                  pw.Container(child: pw.Image(backImg, fit: pw.BoxFit.fill)),
                  pw.Positioned(
                      left: 85,
                      top: 217,
                      child: pw.Container(
                        width: 430,
                        height: 520,
                        child: pw.Stack(
                          children: [
                            pw.Positioned(
                                left: 107,
                                top: 0,
                                child: pw.Text('안심중개권',
                                    style: pw.TextStyle(color: PdfColor.fromInt(0xFF444444), fontSize: 36, font: font123b, height: 0.04))),
                            pw.Positioned(
                                left: 23,
                                top: 25,
                                child: pw.Text('Certification',
                                    style: pw.TextStyle(color: PdfColor.fromInt(0xFFF7F7F7), fontSize: 96, font: fontCert, height: 0.01))),
                            pw.Positioned(
                                left: 177,
                                top: 421,
                                child: pw.Text(today,
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(color: PdfColors.black, fontSize: 16, font: font123b, height: 0.10))),
                            pw.Positioned(
                                left: 0,
                                top: 271,
                                child: pw.Container(
                                    width: 430,
                                    height: 88,
                                    child: pw.Column(
                                        mainAxisSize: pw.MainAxisSize.min,
                                        mainAxisAlignment: pw.MainAxisAlignment.start,
                                        crossAxisAlignment: pw.CrossAxisAlignment.center,
                                        children: [
                                          pw.Text('본 등록매물은 \n딜스테이션의 안심중개권 매물로 승인되었음을 인증합니다.',
                                              textAlign: pw.TextAlign.center,
                                              style: pw.TextStyle(
                                                  color: PdfColors.black, fontSize: 18, font: font123b, height: 0.11, lineSpacing: 10)),
                                          pw.SizedBox(height: 12),
                                          pw.Text('안심중개권 보호기간 [$startDate ~ $endDate]',
                                              textAlign: pw.TextAlign.center,
                                              style: pw.TextStyle(
                                                  color: PdfColors.black, fontSize: 14, font: font123r, height: 0.11, lineSpacing: 10))
                                        ]))),
                            pw.Positioned(
                              left: 23,
                              top: 119,
                              child: pw.Container(
                                width: 377,
                                height: 120,
                                child: pw.Stack(
                                  children: [
                                    pw.Positioned(
                                        left: 18,
                                        top: 16,
                                        child: pw.SizedBox(
                                            width: 342,
                                            child: pw.Text(
                                                '· 소재지 : $address\n· 등록유형 : $type / $category\n· 등록일 : $createDate\n· 등록자 : $userName ($office)',
                                                style: pw.TextStyle(
                                                    color: PdfColors.black, fontSize: 14, font: font123r, height: 0.11, lineSpacing: 5)))),
                                    pw.Positioned(
                                        left: 0,
                                        top: 0,
                                        child: pw.Container(
                                            width: 377,
                                            height: 1,
                                            decoration:
                                                pw.BoxDecoration(color: PdfColor.fromInt(0xFFF4F4F4), shape: pw.BoxShape.rectangle))),
                                    pw.Positioned(
                                        left: 0,
                                        top: 110,
                                        // top: 120,
                                        child: pw.Container(
                                            width: 377,
                                            height: 1,
                                            decoration:
                                                pw.BoxDecoration(color: PdfColor.fromInt(0xFFF4F4F4), shape: pw.BoxShape.rectangle))),
                                  ],
                                ),
                              ),
                            ),
                            pw.Positioned(
                                left: 180,
                                bottom: 25,
                                child: pw.Text('딜스테이션',
                                    textAlign: pw.TextAlign.center,
                                    style: pw.TextStyle(
                                        color: PdfColors.black,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                        height: 0.13,
                                        letterSpacing: 4.80))),
                            pw.Positioned(left: 130, bottom: 0, child: pw.Image(dealImg)),
                          ],
                        ),
                      ))
                ],
              ),
            ));
      },
    );
  }
}
