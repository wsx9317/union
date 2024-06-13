import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class Error404 extends StatefulWidget {
  const Error404({super.key});

  @override
  State<Error404> createState() => _Error404State();
}

class _Error404State extends State<Error404> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const IdImageBox(imagePath: 'assets/img/img_error_404.png', imageWidth: 250, imageHeight: 250, imageFit: BoxFit.cover),
              const IdSpace(spaceWidth: 0, spaceHeight: 30),
              uiCommon.styledText('404 Error', 32, 0, 1.3, FontWeight.w700, IdColors.black, TextAlign.left),
              const IdSpace(spaceWidth: 0, spaceHeight: 8),
              Column(
                children: [
                  uiCommon.styledText('죄송합니다.', 15, 0, 1.3, FontWeight.w500, IdColors.black, TextAlign.left),
                  uiCommon.styledText('페이지를 찾을 수 없습니다.', 15, 0, 1.3, FontWeight.w500, IdColors.black, TextAlign.left),
                ],
              ),
              const IdSpace(spaceWidth: 0, spaceHeight: 8),
              Column(
                children: [
                  uiCommon.styledText('원하시는 페이지를 찾을 수 없습니다.', 15, 0, 1.3, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                  uiCommon.styledText('올바른 URL을 입력하였는지 확인하세요.', 15, 0, 1.3, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
                ],
              ),
              const IdSpace(spaceWidth: 0, spaceHeight: 30),
              IdNormalBtn(
                onBtnPressed: () {},
                childWidget: Container(
                  padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                  decoration: BoxDecoration(
                    color: IdColors.textDefault,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: uiCommon.styledText('Go Back', 14, 0, 1.6, FontWeight.w600, IdColors.white, TextAlign.left),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
