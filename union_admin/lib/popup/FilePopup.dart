import 'package:flutter/material.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/id_widget/IdColor.dart';
import 'package:union_admin/id_widget/IdImageBox1.dart';
import 'package:union_admin/id_widget/IdInputValidation.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';
import 'package:union_admin/id_widget/IdSpace.dart';

class FilePopup extends StatefulWidget {
  final Function() onlyCloseFunction;
  final Function() searchFunction;
  final Function() closeAndUpdateFunction;
  final TextEditingController memoController;
  final TextEditingController fileController;
  final double imgSize;
  const FilePopup(
      {super.key,
      required this.onlyCloseFunction,
      required this.searchFunction,
      required this.closeAndUpdateFunction,
      required this.memoController,
      required this.fileController,
      required this.imgSize});

  @override
  State<FilePopup> createState() => _FilePopupState();
}

class _FilePopupState extends State<FilePopup> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 420,
      height: 421,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: IdColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: IdColors.borderDefault,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: IdColors.black8Per,
            blurRadius: 16,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 29,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: uiCommon.styledText('파일 등록', 18, 0, 1.6, FontWeight.w700, IdColors.black, TextAlign.left),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IdNormalBtn(
                  onBtnPressed: widget.onlyCloseFunction,
                  childWidget: IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                ),
              )
            ],
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          uiCommon.styledText('파일', 14, 0, 1, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          const IdSpace(spaceWidth: 0, spaceHeight: 4),
          Row(
            children: [
              IdInputValidation(
                  width: 290,
                  height: 44,
                  inputColor: IdColors.backgroundDefault,
                  round: 8,
                  controller: widget.fileController,
                  textAlign: 'start',
                  hintText: widget.fileController.text,
                  hintTextFontSize: 16,
                  hintTextfontWeight: FontWeight.w500,
                  hintTextFontColor: IdColors.textDefault,
                  keyboardType: 'text',
                  validationText: '',
                  validationVisible: false,
                  vlaidationCheck: false,
                  enabledBool: false),
              const SizedBox(width: 8),
              IdNormalBtn(
                onBtnPressed: widget.searchFunction,
                childWidget: Container(
                  width: 74,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: IdColors.white,
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(width: 1, color: IdColors.textDefault),
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: Center(child: uiCommon.styledText('찾기', 15, 0, 1, FontWeight.w600, IdColors.textDefault, TextAlign.left)),
                ),
              ),
            ],
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          uiCommon.styledText('설명', 14, 0, 1, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          const IdSpace(spaceWidth: 0, spaceHeight: 4),
          Container(
            width: double.infinity,
            height: 132,
            decoration: BoxDecoration(
              color: IdColors.backgroundDefault,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: widget.memoController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          Row(
            children: [
              IdNormalBtn(
                onBtnPressed: widget.onlyCloseFunction,
                childWidget: Container(
                  width: 182,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: IdColors.borderDefault,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Center(
                    child: uiCommon.styledText('닫기', 15, 0, 1, FontWeight.w600, IdColors.textTertiary, TextAlign.left),
                  ),
                ),
              ),
              const IdSpace(spaceWidth: 8, spaceHeight: 0),
              IdNormalBtn(
                onBtnPressed: widget.closeAndUpdateFunction,
                childWidget: Container(
                  width: 182,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: IdColors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Center(
                    child: uiCommon.styledText('확인', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.left),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return wg1;
  }
}
