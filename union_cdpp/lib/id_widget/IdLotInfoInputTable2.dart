import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdInputValidation.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdRadio.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdLotInfoInpuTable2 extends StatefulWidget {
  final String tableNumber;
  final String lotArea;
  final String lotAreaPy;
  final String address;
  final String areaPurpose;
  final int officialPrice;
  final int totalPrice;
  late bool directInputBool;

  final TextEditingController _m2Controller = TextEditingController();
  final TextEditingController _pyController = TextEditingController();
  final TextEditingController _areaController = TextEditingController();
  final TextEditingController _sellPriceController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _constructController = TextEditingController();
  final TextEditingController _totalConstructController = TextEditingController();

  String lot1() {
    return _m2Controller.text;
  }

  String lot2() {
    return _pyController.text;
  }

  String lot3() {
    return _areaController.text;
  }

  String lot4() {
    return _sellPriceController.text;
  }

  String lot5() {
    return _addressController.text;
  }

  String lot6() {
    return _constructController.text;
  }

  String lot7() {
    return _totalConstructController.text;
  }

  IdLotInfoInpuTable2({
    super.key,
    required this.tableNumber,
    required this.lotArea,
    required this.lotAreaPy,
    required this.address,
    required this.areaPurpose,
    required this.officialPrice,
    required this.totalPrice,
    required this.directInputBool,
  });

  @override
  State<IdLotInfoInpuTable2> createState() => _IdLotInfoInpuTable2State();
}

class _IdLotInfoInpuTable2State extends State<IdLotInfoInpuTable2> {
  List tableBodyList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    widget._m2Controller.dispose();
    widget._pyController.dispose();
    widget._areaController.dispose();
    widget._addressController.dispose();
    widget._sellPriceController.dispose();
    widget._constructController.dispose();
    widget._totalConstructController.dispose();
  }

  Widget fieldDataBoardBody(double bodyWidth, double bodyHeight, double leftWidth, double rightWidth, Widget childWidget) {
    return Container(
      width: bodyWidth,
      height: bodyHeight,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border(
          left: BorderSide(width: leftWidth, color: IdColors.borderDefault),
          right: BorderSide(width: rightWidth, color: IdColors.borderDefault),
          bottom: const BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: childWidget,
    );
  }

//cell width 가 작은 1줄짜리 input
  Widget textInput1(
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Expanded(
        child: IdInputValidation(
            width: double.infinity,
            height: 44,
            inputColor: IdColors.backgroundDefault,
            round: 8,
            textAlign: 'start',
            controller: controller,
            hintText: '',
            hintTextFontSize: 16,
            hintTextfontWeight: FontWeight.w500,
            hintTextFontColor: IdColors.textDefault,
            keyboardType: 'text',
            validationText: '',
            validationVisible: false,
            vlaidationCheck: false,
            enabledBool: true),
      ),
    );
  }

//2줄 이상의 input
  Widget textInput2(
    TextEditingController controller,
  ) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        width: double.infinity,
        height: 90,
        decoration: BoxDecoration(
          color: IdColors.backgroundDefault,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: TextField(
            controller: controller,
            maxLines: null,
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(border: InputBorder.none),
          ),
        ),
      ),
    );
  }

//cell width 가 넓은 1줄짜리 input
  Widget textInput3(
    TextEditingController controller,
    Function() onChange,
    String keyboardType,
  ) {
    return Expanded(
      child: IdInputValidation(
          width: double.infinity,
          height: 44,
          inputColor: IdColors.backgroundDefault,
          round: 8,
          textAlign: 'start',
          controller: controller,
          hintText: '',
          hintTextFontSize: 16,
          hintTextfontWeight: FontWeight.w500,
          hintTextFontColor: IdColors.textDefault,
          onChange: onChange,
          keyboardType: keyboardType,
          validationText: '',
          validationVisible: false,
          vlaidationCheck: false,
          enabledBool: true),
    );
  }

//주소 input
  Widget textInput4(
    TextEditingController controller,
  ) {
    return Expanded(
      child: IdInputValidation(
          width: double.infinity,
          height: 44,
          inputColor: IdColors.backgroundDefault,
          round: 8,
          textAlign: 'start',
          controller: controller,
          hintText: '',
          hintTextFontSize: 16,
          hintTextfontWeight: FontWeight.w500,
          hintTextFontColor: IdColors.textDefault,
          keyboardType: 'text',
          validationText: '',
          validationVisible: false,
          vlaidationCheck: false,
          enabledBool: false),
    );
  }

  Widget radioWithLable(Function() onBtnPressed, bool radioBool, String label) {
    return Row(
      children: [
        IdRadio(onBtnPressed: onBtnPressed, checkBool: radioBool, radioColor: IdColors.green2, enabled: true),
        IdSpace(spaceWidth: 8, spaceHeight: 0),
        IdNormalBtn(
          onBtnPressed: onBtnPressed,
          childWidget: uiCommon.styledText(label, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = SizedBox(
      child: Row(
        children: [
          fieldDataBoardBody(
            57,
            190,
            1,
            0,
            Center(
              child: uiCommon.styledText(widget.tableNumber, 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
            ),
          ),
          SizedBox(
            width: 393,
            height: 190,
            child: Column(
              children: [
                Row(
                  children: [
                    fieldDataBoardBody(
                      66,
                      130,
                      1,
                      0,
                      Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            (widget.directInputBool)
                                ? textInput1(widget._m2Controller)
                                : uiCommon.styledText(widget.lotArea, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                            uiCommon.styledText('㎡', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: fieldDataBoardBody(
                        57,
                        130,
                        1,
                        0,
                        Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              (widget.directInputBool)
                                  ? textInput1(widget._pyController)
                                  : uiCommon.styledText(
                                      widget.lotAreaPy, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                              uiCommon.styledText('py', 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                            ],
                          ),
                        ),
                      ),
                    ),
                    fieldDataBoardBody(
                      79,
                      130,
                      1,
                      0,
                      Center(
                        child: (widget.directInputBool)
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  textInput2(widget._areaController),
                                ],
                              )
                            : Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                child: uiCommon.styledText(
                                    widget.areaPurpose, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                              ),
                      ),
                    ),
                    fieldDataBoardBody(
                      182,
                      130,
                      1,
                      0,
                      Container(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                radioWithLable((widget.tableNumber == '1') ? () => null : () => null,
                                    (widget.tableNumber == '1') ? false : false, '포함'),
                                const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                radioWithLable((widget.tableNumber == '1') ? () => null : () => null,
                                    (widget.tableNumber == '1') ? false : false, '별도'),
                              ],
                            ),
                            const IdSpace(spaceWidth: 0, spaceHeight: 20),
                            textInput3(widget._sellPriceController, () {}, 'number')
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    fieldDataBoardBody(
                        66,
                        60,
                        1,
                        0,
                        Center(
                          child: uiCommon.styledText('주소', 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.center),
                        )),
                    Expanded(
                      child: fieldDataBoardBody(
                        66,
                        60,
                        1,
                        0,
                        (widget.address == '')
                            ? Container(
                                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 7.5),
                                child: Row(
                                  children: [
                                    textInput4(widget._addressController),
                                  ],
                                ),
                              )
                            : Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: double.infinity,
                                    padding: EdgeInsets.symmetric(horizontal: 16),
                                    child: uiCommon.styledText(
                                        widget.address, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
          fieldDataBoardBody(
              105,
              190,
              1,
              0,
              Center(
                child: (widget.directInputBool)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textInput1(widget._constructController),
                        ],
                      )
                    : uiCommon.styledText(NumberFormat('#,###').format(widget.officialPrice), 16, 0, 1, FontWeight.w500,
                        IdColors.textDefault, TextAlign.left),
              )),
          fieldDataBoardBody(
              132,
              190,
              1,
              1,
              Center(
                child: (widget.directInputBool)
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          textInput1(widget._totalConstructController),
                        ],
                      )
                    : uiCommon.styledText(
                        NumberFormat('#,###').format(widget.totalPrice), 16, 0, 1, FontWeight.w500, IdColors.textDefault, TextAlign.left),
              )),
        ],
      ),
    );
    return wg1;
  }
}
