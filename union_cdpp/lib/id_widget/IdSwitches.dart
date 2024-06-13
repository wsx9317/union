import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:flutter/material.dart';

class IdSwitches extends StatefulWidget {
  final Function()? onBtnPressed;
  final int switchesStatus;
  const IdSwitches({super.key, this.onBtnPressed, required this.switchesStatus});

  @override
  State<IdSwitches> createState() => _IdSwitchesState();
}

class _IdSwitchesState extends State<IdSwitches> {
  List status = ['defualt', 'active', 'activeDisable', 'defualtDisable'];
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Opacity(
      opacity: (status[widget.switchesStatus] == 'activeDisable') ? 0.3 : 1,
      child: IdNormalBtn(
        onBtnPressed: widget.onBtnPressed,
        childWidget: Container(
          width: 32,
          height: 20,
          decoration: BoxDecoration(
            color: (status[widget.switchesStatus] == 'active' || status[widget.switchesStatus] == 'activeDisable')
                ? IdColors.green2
                : IdColors.black20Per,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 3,
                bottom: 3,
                left: (status[widget.switchesStatus] == 'active' || status[widget.switchesStatus] == 'activeDisable') ? 15 : 3,
                right: (status[widget.switchesStatus] == 'active' || status[widget.switchesStatus] == 'activeDisable') ? 3 : 15),
            child: Container(
              width: 14,
              height: 14,
              decoration: BoxDecoration(
                color: (status[widget.switchesStatus] == 'defualtDisable') ? const Color.fromRGBO(0, 0, 0, 0.1) : Colors.white,
                borderRadius: BorderRadius.circular(50),
              ),
            ),
          ),
        ),
      ),
    );
    return wg1;
  }
}
