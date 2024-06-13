import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdPageTopSection extends StatefulWidget {
  final String menuName;
  final String pageDesc;
  final Widget? navigator;
  final Widget imgBoxWidget;
  const IdPageTopSection({super.key, required this.menuName, required this.pageDesc, this.navigator, required this.imgBoxWidget});

  @override
  State<IdPageTopSection> createState() => _IdPageTopSectionState();
}

class _IdPageTopSectionState extends State<IdPageTopSection> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Stack(
      children: [
        const SizedBox(
          width: 1224,
          height: 428,
        ),
        Positioned(
          top: 0,
          left: 0,
          child: SizedBox(
            height: 428,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                uiCommon.styledText(widget.menuName, 18, 0, 1.6, FontWeight.w700,
                    (widget.pageDesc == 'My Page') ? IdColors.white : IdColors.green2, TextAlign.left),
                const IdSpace(spaceWidth: 0, spaceHeight: 16),
                uiCommon.styledText(widget.pageDesc, 56, 0, 1.3, FontWeight.w700,
                    (widget.pageDesc == 'My Page') ? IdColors.white : IdColors.textDefault, TextAlign.left),
                const IdSpace(spaceWidth: 0, spaceHeight: 40),
                (widget.navigator != null) ? widget.navigator! : const SizedBox()
              ],
            ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: SizedBox(
            height: 428,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                widget.imgBoxWidget,
              ],
            ),
          ),
        ),
      ],
    );
    return wg1;
  }
}
