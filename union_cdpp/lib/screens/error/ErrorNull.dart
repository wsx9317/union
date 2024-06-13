import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class ErrorNull extends StatefulWidget {
  const ErrorNull({super.key});

  @override
  State<ErrorNull> createState() => _ErrorNullState();
}

class _ErrorNullState extends State<ErrorNull> {
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
              const IdImageBox(imagePath: 'assets/img/img_error_null.png', imageWidth: 250, imageHeight: 250, imageFit: BoxFit.cover),
              const IdSpace(spaceWidth: 0, spaceHeight: 40),
              uiCommon.styledText('No post', 32, 0, 1.3, FontWeight.w700, IdColors.black, TextAlign.left),
              const IdSpace(spaceWidth: 0, spaceHeight: 8),
              uiCommon.styledText('게시물이 존재하지 않습니다.', 15, 0, 1.3, FontWeight.w400, IdColors.textTertiary, TextAlign.left),
              const IdSpace(spaceWidth: 0, spaceHeight: 40),
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
