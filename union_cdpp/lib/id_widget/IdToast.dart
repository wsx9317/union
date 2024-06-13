import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';

class IdToast extends StatefulWidget {
  final String message;
  const IdToast({super.key, required this.message});

  @override
  State<IdToast> createState() => _IdToastState();
}

class _IdToastState extends State<IdToast> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 317,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 12),
      decoration: ShapeDecoration(
        color: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32),
        ),
      ),
      child: uiCommon.styledText(widget.message, 15, -0.30, 1.6, FontWeight.w500, IdColors.white, TextAlign.left),
    );
    return wg1;
  }
}
