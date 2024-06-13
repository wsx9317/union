import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:flutter/material.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:number_text_input_formatter/number_text_input_formatter.dart';

class IdInputValidation extends StatefulWidget {
  final String? lable;
  final double width;
  final double height;
  final Color inputColor;
  final Color? borderColor;
  final double round;
  final Function()? onTap;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final Function()? onEdit;
  final bool? nextFocus;
  final Function()? onChange;
  final String textAlign;
  final Color? enabledBorderColor;
  final String hintText;
  final double hintTextFontSize;
  final FontWeight hintTextfontWeight;
  final Color hintTextFontColor;
  final String keyboardType;
  final Widget? inputWithIcon;
  final String validationText;
  final bool validationVisible;
  final bool vlaidationCheck;
  final bool enabledBool;
  IdInputValidation({
    super.key,
    this.lable,
    required this.width,
    required this.height,
    required this.inputColor,
    this.borderColor,
    required this.round,
    this.onTap,
    this.controller,
    this.focusNode,
    this.onEdit,
    this.nextFocus,
    this.onChange,
    required this.textAlign,
    this.enabledBorderColor,
    required this.hintText,
    required this.hintTextFontSize,
    required this.hintTextfontWeight,
    required this.hintTextFontColor,
    required this.keyboardType,
    this.inputWithIcon,
    required this.validationText,
    required this.validationVisible,
    required this.vlaidationCheck,
    required this.enabledBool,
  });

  @override
  State<IdInputValidation> createState() => _IdInputValidationState();
}

class _IdInputValidationState extends State<IdInputValidation> {
  @override
  void initState() {
    super.initState();
    if (widget.keyboardType == 'number') {
      widget.controller!.addListener(_formatNumber);
    }
  }

  void _formatNumber() {
    if (widget.controller!.text.isNotEmpty) {
      String value = widget.controller!.text.replaceAll(',', '');
      value = value.replaceAll(' ', '');
      int number = 0;
      try {
        number = int.tryParse(value) ?? 0;
      } catch (e) {}
      String formattedValue = numberWithCommas(number);
      if (widget.controller!.text != formattedValue) {
        widget.controller!.value = widget.controller!.value.copyWith(
          text: formattedValue,
          selection: TextSelection.collapsed(offset: formattedValue.length),
        );
      }
    }
  }

  String numberWithCommas(int number) {
    return number.toString().replaceAllMapped(
          RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
        );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        (widget.lable != null)
            ? Column(
                children: [
                  SizedBox(
                    child: Padding(
                      padding: EdgeInsets.symmetric(vertical: 10.5),
                      child: uiCommon.styledText(
                          (widget.lable != null) ? widget.lable! : '', 18, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
                    ),
                  ),
                  IdSpace(spaceWidth: 0, spaceHeight: 8),
                ],
              )
            : SizedBox(),
        Stack(
          children: [
            Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                color: widget.inputColor,
                borderRadius: BorderRadius.circular(widget.round),
                // 여기가 보더색상
                border: Border.all(color: (widget.borderColor != null) ? widget.borderColor! : widget.inputColor, width: 1),
              ),
              child: TextFormField(
                inputFormatters: (widget.keyboardType == 'number2') ? [CustomIntFormatter()] : [],
                onTap: widget.onTap,
                focusNode: (widget.focusNode != null) ? widget.focusNode : null,
                controller: (widget.controller != null) ? widget.controller : null,
                onEditingComplete: widget.onEdit,
                onFieldSubmitted: (value) {
                  (widget.nextFocus == true) ? FocusScope.of(context).nextFocus() : null;
                },
                onChanged: (value) {
                  widget.onChange;
                },
                enabled: widget.enabledBool,
                obscureText: (widget.keyboardType == 'password') ? true : false,
                textAlign: (widget.textAlign == 'start')
                    ? TextAlign.start
                    : (widget.textAlign == 'end')
                        ? TextAlign.end
                        : TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(widget.round), borderSide: BorderSide.none),
                  //에러 날때
                  enabledBorder: (widget.enabledBorderColor != null)
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                              color: (widget.validationVisible) ? IdColors.systemError : const Color.fromRGBO(0, 0, 0, 0), width: 1.0),
                          borderRadius: BorderRadius.circular(widget.round),
                        )
                      : null,
                  //엑티브 됐을때
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: IdColors.textDefault, width: 1.0),
                    borderRadius: BorderRadius.circular(widget.round),
                  ),
                  hintText: widget.hintText,
                  hintStyle: TextStyle(
                    height: 1,
                    fontSize: widget.hintTextFontSize,
                    color: widget.hintTextFontColor,
                    fontWeight: widget.hintTextfontWeight,
                  ),
                  contentPadding: EdgeInsets.only(left: 14),
                ),
                keyboardType:
                    (widget.keyboardType == 'number' || widget.keyboardType == 'number2') ? TextInputType.number : TextInputType.text,
                style: const TextStyle(
                    color: IdColors.black, fontFamily: 'Pretendard', fontSize: 16, height: 1.6, fontWeight: FontWeight.w400),
              ),
            ),
            Visibility(
              visible: widget.vlaidationCheck,
              child: Positioned(
                top: 12,
                right: 12,
                bottom: 12,
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: Center(
                    child: widget.inputWithIcon,
                  ),
                ),
              ),
            )
          ],
        ),
        Visibility(
          visible: widget.validationVisible,
          child: Column(
            children: [
              const IdSpace(spaceWidth: 0, spaceHeight: 4),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: IdImageBox(imagePath: 'assets/img/icon_tool_04.png', imageWidth: 16, imageHeight: 16, imageFit: BoxFit.cover),
                  ),
                  const IdSpace(spaceWidth: 4, spaceHeight: 0),
                  uiCommon.styledText(widget.validationText, 14, 0, 1.6, FontWeight.w400, IdColors.systemError, TextAlign.left),
                ],
              ),
            ],
          ),
        ),
      ],
    );
    return wg1;
  }
}

class CustomIntFormatter extends TextInputFormatter {
  @override
  // 숫자와 "." 만 입력되게 제한
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String newText = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');
    int decimalIndex = newText.indexOf('.');

    // 소수점 아래 자리수 두 자리로 제한
    if (decimalIndex != -1 && decimalIndex + 1 < newText.length) {
      String decimalPart = newText.substring(decimalIndex + 2).replaceAll(RegExp(r'[.]'), '');
      if (decimalPart.length > 1) {
        decimalPart = decimalPart.substring(0, 2);
      }
      newText = newText.substring(0, decimalIndex + 1) + decimalPart;
    }

    // 숫자와 소수점을 분리
    List<String> numberParts = newText.split('.');

    numberParts[0] = NumberFormat('#,###').format(numberParts[0]);
    GV.d('numberParts[0]', numberParts[0]);

    newText = numberParts.join('.');

    final int newSelectionIndex = newText.length - (newValue.text.length - newValue.selection.end);

    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newSelectionIndex),
    );
  }
}
