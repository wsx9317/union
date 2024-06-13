import 'package:flutter/material.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';

class IdRentRollBoard extends StatefulWidget {
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

  IdRentRollBoard({
    Key? key,
    required this.text1,
    required this.text2,
    required this.text3,
    required this.text4,
    required this.text5,
    required this.text6,
  }) : super(key: key);

  @override
  State<IdRentRollBoard> createState() => _IdRentRollBoardState();
}

class _IdRentRollBoardState extends State<IdRentRollBoard> {
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

  Widget textInputWidget(
      double width, String hint, TextEditingController controller, bool enabledBool, String keyboarType, Function() onChange) {
    return IdInputValidation(
        width: width,
        height: 44,
        inputColor: IdColors.backgroundDefault,
        round: 8,
        textAlign: 'start',
        controller: controller,
        hintText: hint,
        onChange: onChange,
        hintTextFontSize: 16,
        hintTextfontWeight: FontWeight.w400,
        hintTextFontColor: IdColors.textTertiary,
        keyboardType: keyboarType,
        validationText: '',
        validationVisible: false,
        vlaidationCheck: false,
        enabledBool: enabledBool);
  }

  Widget boardTop1(
    String headerNumber,
    String title,
  ) {
    return Expanded(
      child: Container(
        child: Container(
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: IdColors.green5,
            border: (headerNumber == 'first')
                ? const Border(
                    left: BorderSide(width: 1, color: IdColors.borderDefault),
                    top: BorderSide(width: 1, color: IdColors.borderDefault),
                    right: BorderSide(width: 1, color: IdColors.borderDefault),
                  )
                : const Border(
                    top: BorderSide(width: 1, color: IdColors.borderDefault),
                    right: BorderSide(width: 1, color: IdColors.borderDefault),
                  ),
          ),
          child: Center(
            child: uiCommon.styledText(title, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
          ),
        ),
      ),
    );
  }

  Widget boardBody1(String bodyNumber, TextEditingController controller, String keyboardType, Function() onChange) {
    return Expanded(
      child: Container(
        height: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 7, horizontal: 5),
        decoration: BoxDecoration(
          color: IdColors.white,
          border: (bodyNumber == 'first')
              ? const Border(
                  top: BorderSide(color: IdColors.borderDefault),
                  left: BorderSide(width: 1, color: IdColors.borderDefault),
                  right: BorderSide(width: 1, color: IdColors.borderDefault),
                )
              : const Border(
                  top: BorderSide(color: IdColors.borderDefault),
                  right: BorderSide(width: 1, color: IdColors.borderDefault),
                ),
        ),
        child: textInputWidget(double.infinity, '', controller, true, keyboardType, onChange),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Column(
      children: [
        SizedBox(
          width: double.infinity,
          height: 48,
          child: Row(
            children: [
              boardTop1('first', '층'),
              boardTop1('second', '업종'),
              boardTop1('third', '면적<unit>(㎡)</unit>'),
              boardTop1('fourth', '보증금<unit>(만원)</unit>'),
              boardTop1('fifth', '임대료<unit>(만원)</unit>'),
            ],
          ),
        ),
        SizedBox(
          width: double.infinity,
          height: 60,
          child: Row(
            children: [
              boardBody1('first', widget._rentRoll1Controller, 'text', () {
                widget._rentRoll1Controller.text;
                setState(() {});
                initState();
              }),
              boardBody1('second', widget._rentRoll2Controller, 'text', () {
                widget._rentRoll2Controller.text;
                setState(() {});
                initState();
              }),
              boardBody1('third', widget._rentRoll3Controller, 'number', () {
                widget._rentRoll3Controller.text;
                setState(() {});
                initState();
              }),
              boardBody1('fourth', widget._rentRoll4Controller, 'number', () {
                widget._rentRoll4Controller.text;
                setState(() {});
                initState();
              }),
              boardBody1('fifth', widget._rentRoll5Controller, 'number', () {
                widget._rentRoll5Controller.text;
                setState(() {});
                initState();
              }),
            ],
          ),
        ),
        Container(
          width: double.infinity,
          height: 48,
          decoration: const BoxDecoration(
              color: IdColors.green5,
              border: Border(
                top: BorderSide(width: 1, color: IdColors.borderDefault),
                left: BorderSide(width: 1, color: IdColors.borderDefault),
                right: BorderSide(width: 1, color: IdColors.borderDefault),
              )),
          child: Center(
            child: uiCommon.styledText('비고', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
          ),
        ),
        Container(
          width: double.infinity,
          height: 60,
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 7),
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(
            color: IdColors.white,
            border: Border(
              left: BorderSide(width: 1, color: IdColors.borderDefault),
              right: BorderSide(width: 1, color: IdColors.borderDefault),
              bottom: BorderSide(width: 1, color: IdColors.borderDefault),
            ),
          ),
          child: textInputWidget(double.infinity, '', widget._rentRoll6Controller, true, 'text', () {
            widget._rentRoll6Controller.text;
            setState(() {});
            initState();
          }),
        ),
      ],
    );
    return wg1;
  }
}
