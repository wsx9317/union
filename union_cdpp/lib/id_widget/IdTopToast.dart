import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';

class IdTopToast extends StatefulWidget {
  final String toastMessage;
  const IdTopToast({super.key, required this.toastMessage});

  @override
  State<IdTopToast> createState() => _IdTopToastState();
}

class _IdTopToastState extends State<IdTopToast> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: double.infinity,
      height: 61,
      color: IdColors.blue,
      child: Center(
        child: uiCommon.styledText(widget.toastMessage, 18, 0, 1, FontWeight.w400, IdColors.white, TextAlign.center),
      ),
    );
    return wg1;
  }
}
