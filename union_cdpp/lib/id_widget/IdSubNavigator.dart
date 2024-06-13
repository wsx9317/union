import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdSubNavigator extends StatefulWidget {
  final String pageName;
  final List subMenu;
  final List subMenuLink;
  const IdSubNavigator({
    super.key,
    required this.pageName,
    required this.subMenu,
    required this.subMenuLink,
  });

  @override
  State<IdSubNavigator> createState() => _IdSubNavigatorState();
}

class _IdSubNavigatorState extends State<IdSubNavigator> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Row(
      children: List.generate(
          widget.subMenu.length,
          (index) => IdNormalBtn(
                onBtnPressed: widget.subMenuLink[index],
                childWidget: Row(
                  children: [
                    Container(
                      height: 42,
                      padding: const EdgeInsets.symmetric(horizontal: 24),
                      decoration: ShapeDecoration(
                        color: (widget.subMenu[index] == widget.pageName) ? IdColors.white : IdColors.white10per,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(40),
                        ),
                      ),
                      child: Center(
                        child: uiCommon.styledText(widget.subMenu[index], 17, 0.14, 1, FontWeight.w600,
                            (widget.subMenu[index] == widget.pageName) ? IdColors.green2 : IdColors.white, TextAlign.left),
                      ),
                    ),
                    IdSpace(spaceWidth: (index == widget.subMenu.length - 1) ? 0 : 10, spaceHeight: 0)
                  ],
                ),
              )),
    );
    return wg1;
  }
}
