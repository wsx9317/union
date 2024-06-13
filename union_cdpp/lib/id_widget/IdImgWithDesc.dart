import 'package:flutter/material.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDottedBorderContainer.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdImgWithDesc extends StatefulWidget {
  final Function() onBtnPressed1;
  final double imgHeight;
  final double roundRadius;
  final List<double> patten;
  final Color boxColor;
  final Color borderColor;
  final Widget childWidget;
  final double spaceHeight;
  final Function() onBtnPressed2;
  final double inputHeight;
  const IdImgWithDesc({
    super.key,
    required this.onBtnPressed1,
    required this.imgHeight,
    required this.roundRadius,
    required this.patten,
    required this.boxColor,
    required this.borderColor,
    required this.childWidget,
    required this.spaceHeight,
    required this.onBtnPressed2,
    required this.inputHeight,
  });

  @override
  State<IdImgWithDesc> createState() => _IdImgWithDescState();
}

class _IdImgWithDescState extends State<IdImgWithDesc> {
  TextEditingController _inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Expanded(
      child: Column(
        children: [
          IdNormalBtn(
            onBtnPressed: widget.onBtnPressed1,
            childWidget: IdDottedBorder(
                boxWidth: double.infinity,
                boxHeigh: widget.imgHeight,
                roundRadius: widget.roundRadius,
                pattern: widget.patten,
                boxColor: widget.boxColor,
                borderColor: widget.borderColor,
                childWidget: widget.childWidget),
          ),
          IdSpace(spaceWidth: 0, spaceHeight: widget.spaceHeight),
          IdInputValidation(
              width: double.infinity,
              height: widget.inputHeight,
              inputColor: IdColors.backgroundDefault,
              controller: _inputController,
              onChange: widget.onBtnPressed2,
              round: 8,
              textAlign: 'start',
              hintText: '사진설명을 입력할 수 있습니다.',
              hintTextFontSize: 16,
              hintTextfontWeight: FontWeight.w400,
              hintTextFontColor: IdColors.textTertiary,
              keyboardType: 'text',
              validationText: '',
              validationVisible: false,
              vlaidationCheck: false,
              enabledBool: true)
        ],
      ),
    );
    return wg1;
  }
}
