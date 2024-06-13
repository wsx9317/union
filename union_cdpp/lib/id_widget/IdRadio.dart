import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:flutter/material.dart';

class IdRadio extends StatefulWidget {
  final Function()? onBtnPressed;
  final bool checkBool;
  final Color radioColor;
  final bool enabled;
  final String? radioSize; //라디오버튼 작을때만 적용
  const IdRadio({super.key, this.onBtnPressed, required this.checkBool, required this.radioColor, required this.enabled, this.radioSize});

  @override
  State<IdRadio> createState() => _IdRadioState();
}

class _IdRadioState extends State<IdRadio> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = IdNormalBtn(
      onBtnPressed: widget.onBtnPressed,
      childWidget: Opacity(
        opacity: widget.enabled ? 1 : 0.3,
        child: Container(
          width: (widget.radioSize != null) ? 16 : 24,
          height: (widget.radioSize != null) ? 16 : 24,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: (widget.checkBool) ? widget.radioColor : IdColors.black20Per,
            ),
            borderRadius: BorderRadius.circular(50),
          ),
          child: Visibility(
            visible: widget.checkBool,
            child: Center(
              child: Container(
                width: (widget.radioSize != null) ? 8 : 12,
                height: (widget.radioSize != null) ? 8 : 12,
                decoration: BoxDecoration(
                  color: widget.radioColor,
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
    return wg1;
  }
}
