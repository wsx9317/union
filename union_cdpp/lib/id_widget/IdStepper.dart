import 'package:flutter/material.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';

//플러스 되는 상황에서는 listCnt을 필수적으로 넣어줘야함

class IdStepper extends StatefulWidget {
  final Function()? onBtnPressed;
  final int buttonNumber;
  final int ableCnt;
  final int? listCnt;
  const IdStepper({super.key, required this.onBtnPressed, required this.buttonNumber, required this.ableCnt, this.listCnt});

  @override
  State<IdStepper> createState() => _IdStepperState();
}

class _IdStepperState extends State<IdStepper> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = IdNormalBtn(
        onBtnPressed: widget.onBtnPressed,
        childWidget: IdImageBox(
            imagePath: (widget.buttonNumber == 0)
                ? (widget.ableCnt == 0)
                    ? 'assets/img/icon_minus_stepper_disable.png'
                    : 'assets/img/icon_minus_stepper_able.png'
                : (widget.ableCnt == widget.listCnt! - 1)
                    ? 'assets/img/icon_plus_stepper_disable.png'
                    : 'assets/img/icon_plus_stepper_able.png',
            imageWidth: 20,
            imageHeight: 20,
            imageFit: BoxFit.cover));
    return wg1;
  }
}
