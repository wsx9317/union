import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';

class IdInfoFormat extends StatefulWidget {
  final String formatTitle;
  final Widget formatContent;
  const IdInfoFormat({super.key, required this.formatTitle, required this.formatContent});

  @override
  State<IdInfoFormat> createState() => _IdInfoFormatState();
}

class _IdInfoFormatState extends State<IdInfoFormat> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = SizedBox(
      height: 44,
      child: Row(
        children: [
          SizedBox(
            width: 114,
            child: uiCommon.styledText(widget.formatTitle, 16, 0, 1.6, FontWeight.w600, IdColors.textDefault, TextAlign.left),
          ),
          widget.formatContent
        ],
      ),
    );
    return wg1;
  }
}
