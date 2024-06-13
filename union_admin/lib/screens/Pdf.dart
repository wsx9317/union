import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/constants/constants.dart';
import 'package:union_admin/id_widget/IdImageBox1.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';
import 'package:union_admin/screens/PDF/certPdf.dart';

class Pdf extends StatefulWidget {
  final String? pdfFileName;

  const Pdf({super.key, this.pdfFileName});

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          uiCommon.IdMovePage(context, '{PREV}');
          return false;
        },
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                width: double.infinity,
                color: Colors.white,
                child: PdfPreview(
                  pdfFileName: widget.pdfFileName ?? 'document1',
                  maxPageWidth: 700,
                  // build: (format) => const IdPdfViewer(TmPdf.generateTM).builder(format.landscape),
                  build: (format) => const IdPdfViewer(CertPdf.generateCert).builder(format.portrait),
                  allowSharing: true,
                  canChangeOrientation: false,
                  canChangePageFormat: false,
                  canDebug: false,
                ),
              ),
              Positioned(
                top: 20,
                right: 20,
                child: IdNormalBtn(
                  onBtnPressed: () {
                    // uiCommon.IdMovePage(context, '{PREV}');
                    uiCommon.IdMovePage(context, PAGE_DEAL_DETAIL_PAGE);
                  },
                  childWidget:
                      const IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                ),
              ),
            ],
          ),
        ));
  }
}

typedef LayoutCallbackWithData = Future<Uint8List> Function(PdfPageFormat pageFormat);

class IdPdfViewer {
  const IdPdfViewer(this.builder);

  final LayoutCallbackWithData builder;
}
