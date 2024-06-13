import 'package:flutter/material.dart';
import 'package:dotted_border/dotted_border.dart';

class IdDottedBorder extends StatefulWidget {
  final double boxWidth;
  final double boxHeigh;
  final double roundRadius;
  final List<double> pattern;
  final Color boxColor;
  final Color borderColor;
  final Widget childWidget;
  const IdDottedBorder({
    super.key,
    required this.boxWidth,
    required this.boxHeigh,
    required this.roundRadius,
    required this.pattern,
    required this.boxColor,
    required this.borderColor,
    required this.childWidget,
  });

  @override
  State<IdDottedBorder> createState() => _IdDottedBorderState();
}

class _IdDottedBorderState extends State<IdDottedBorder> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Wrap(
      children: [
        DottedBorder(
          borderType: BorderType.RRect,
          radius: Radius.circular(widget.roundRadius),
          dashPattern: widget.pattern,
          color: widget.borderColor,
          child: ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(widget.roundRadius)),
            child: Container(
              width: widget.boxWidth,
              height: widget.boxHeigh,
              color: widget.boxColor,
              child: widget.childWidget,
            ),
          ),
        ),
      ],
    );
    return wg1;
  }
}
