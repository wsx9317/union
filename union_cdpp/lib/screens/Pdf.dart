import 'package:flutter/material.dart';
import 'package:gradient_progress_indicator/gradient_progress_indicator.dart';
import 'package:printing/printing.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import '../api/id_api.dart';
import '../id_widget/IdColor.dart';
import '../modelVO/ssoModel.dart';
import 'PDF/tmPdf.dart';
import 'PDF/certPdf.dart';

class Pdf extends StatefulWidget {
  final String? pdfFileName;

  const Pdf({super.key, this.pdfFileName});

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> with SingleTickerProviderStateMixin {
  String? userNo;
  ssoMember? ssoUser;

  @override
  void initState() {
    super.initState();
    userNo = GV.pStrg.getXXX(Param_commonUserNo);

    Future.delayed(Duration(milliseconds: 10), () async {
      final dynamic ret1 = await IdApi.getMember_SSO(ssoMember(uIdx: userNo));
      if (ret1 != null) ssoUser = ret1;
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    uiCommon.setScreen(context);
    if (ssoUser == null) {
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
                  build: (format) => (GV.pStrg.getXXX(Param_pdfStatus) == 'tm')
                      ? TmPdf.generateTM(format.landscape, ssoUser)
                      : CertPdf.generateCert(format.portrait, null),
                  // build: (format) => const IdPdfViewer(CertPdf.generateCert).builder(format.portrait),
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
                    uiCommon.IdMovePage(context, '{PREV}');
                    //uiCommon.IdMovePage(context, PAGE_MYDEAL_DETAIL_PAGE);
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
