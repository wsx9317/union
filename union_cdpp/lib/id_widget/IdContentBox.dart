import 'package:flutter/material.dart';

class IdContentBox extends StatefulWidget {
  final double? contentBoxWidth;
  final double? contentBoxHeigh;
  final Color contentBoxColor;
  final BorderRadiusGeometry borderRadius;
  final Color contentBoxBorderColor;
  final double contentBoxBorderWidth;
  final double shadowBlur;
  final double shadowX;
  final double shadowY;
  final Color shadowColor;
  final double spreadRadius;
  final Widget? childWidget;
  const IdContentBox({
    Key? key,
    this.contentBoxWidth,
    this.contentBoxHeigh,
    required this.contentBoxColor,
    required this.borderRadius,
    required this.contentBoxBorderColor,
    required this.contentBoxBorderWidth,
    required this.shadowBlur,
    required this.shadowX,
    required this.shadowY,
    required this.shadowColor,
    required this.spreadRadius,
    this.childWidget,
  });

  @override
  State<IdContentBox> createState() => _IdContentBoxState();
}

class _IdContentBoxState extends State<IdContentBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.contentBoxWidth,
      height: widget.contentBoxHeigh,
      decoration: BoxDecoration(
          color: widget.contentBoxColor,
          borderRadius: widget.borderRadius,
          border: Border.all(
            color: widget.contentBoxBorderColor,
            width: widget.contentBoxBorderWidth,
          ),
          boxShadow: [
            BoxShadow(
              blurRadius: widget.shadowBlur,
              offset: Offset(widget.shadowX, widget.shadowY),
              color: widget.shadowColor,
              spreadRadius: widget.spreadRadius,
            )
          ]),
      child: widget.childWidget,
    );
  }
}
