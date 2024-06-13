import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdRentRollEditBoard extends StatefulWidget {
  // final int boardCnt;
  final String text1;
  final String text2;
  final String text3;
  final String text4;
  final String text5;
  final String text6;
  //RentRoll board
  final TextEditingController _rentRoll1Controller = TextEditingController(); //Rent Roll 층
  final TextEditingController _rentRoll2Controller = TextEditingController(); //Rent Roll 업종
  final TextEditingController _rentRoll3Controller = TextEditingController(); //Rent Roll 면적
  final TextEditingController _rentRoll4Controller = TextEditingController(); //Rent Roll 보증금
  final TextEditingController _rentRoll5Controller = TextEditingController(); //Rent Roll 임대료
  final TextEditingController _rentRoll6Controller = TextEditingController(); //Rent Roll 비고
  String rent1() {
    return _rentRoll1Controller.text;
  }

  String rent2() {
    return _rentRoll2Controller.text;
  }

  String rent3() {
    return _rentRoll3Controller.text;
  }

  String rent4() {
    return _rentRoll4Controller.text;
  }

  String rent5() {
    return _rentRoll5Controller.text;
  }

  String rent6() {
    return _rentRoll6Controller.text;
  }

  IdRentRollEditBoard(
      {super.key,
      required this.text1,
      required this.text2,
      required this.text3,
      required this.text4,
      required this.text5,
      required this.text6});

  @override
  State<IdRentRollEditBoard> createState() => _IdRentRollEditBoardState();
}

class _IdRentRollEditBoardState extends State<IdRentRollEditBoard> {
  List rentRollList = [];

  @override
  void initState() {
    super.initState();
    widget._rentRoll1Controller.text = widget.text1;
    widget._rentRoll2Controller.text = widget.text2;
    widget._rentRoll3Controller.text = widget.text3;
    widget._rentRoll4Controller.text = widget.text4;
    widget._rentRoll5Controller.text = widget.text5;
    widget._rentRoll6Controller.text = widget.text6;
  }

  Widget textInput(String hint, TextEditingController controller, String keyboadType, double width, bool enabledBool) {
    return IdInputValidation(
        width: width,
        height: 44,
        inputColor: IdColors.backgroundDefault,
        round: 8,
        controller: controller,
        textAlign: 'start',
        hintText: hint,
        hintTextFontSize: 16,
        hintTextfontWeight: FontWeight.w500,
        hintTextFontColor: IdColors.textTertiary,
        keyboardType: keyboadType,
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: enabledBool);
  }

  Widget rentRollContent(String title, TextEditingController controller, String keyboardType, double width) {
    return Row(
      children: [
        uiCommon.styledText(title, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
        const IdSpace(spaceWidth: 16, spaceHeight: 0),
        textInput(controller.text, controller, keyboardType, width, true),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Row(
                children: [
                  rentRollContent('층', widget._rentRoll1Controller, 'text', 80),
                  uiCommon.styledText('층', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  rentRollContent('업종', widget._rentRoll2Controller, 'text', 80),
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  rentRollContent('면적(㎡)', widget._rentRoll3Controller, 'text', 80),
                  uiCommon.styledText('㎡', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  rentRollContent('보증금(만원)', widget._rentRoll4Controller, 'number2', 80),
                  uiCommon.styledText('만원', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                ],
              ),
              const Expanded(child: SizedBox()),
              Row(
                children: [
                  rentRollContent('임대료(만원)', widget._rentRoll5Controller, 'number2', 80),
                  uiCommon.styledText('만원', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                ],
              ),
              const Expanded(child: SizedBox()),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: rentRollContent('비고', widget._rentRoll6Controller, 'number', 300),
        ),
        Container(
          width: double.infinity,
          height: 1,
          color: IdColors.borderDefault,
        )
      ],
    );
    return wg1;
  }
}
