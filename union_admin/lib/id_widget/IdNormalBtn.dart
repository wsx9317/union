import 'package:defer_pointer/defer_pointer.dart';
import 'package:flutter/material.dart';

class IdNormalBtn extends StatefulWidget {
  final Function()? onBtnPressed;
  final Widget childWidget;
  const IdNormalBtn({super.key, this.onBtnPressed, required this.childWidget});

  @override
  State<IdNormalBtn> createState() => _IdNormalBtnState();
}

class _IdNormalBtnState extends State<IdNormalBtn> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = DeferredPointerHandler(
        child: DeferPointer(
            child: TextButton(
      onPressed: widget.onBtnPressed,
      style: TextButton.styleFrom(
        minimumSize: Size.zero,
        padding: EdgeInsets.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: widget.childWidget,
    )));
    return wg1;
  }
}
