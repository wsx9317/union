import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';

class IdTopNavigator extends StatefulWidget {
  final List navigatorMenu;
  final List? navigatorLink;
  const IdTopNavigator({super.key, required this.navigatorMenu, this.navigatorLink});

  @override
  State<IdTopNavigator> createState() => _IdTopNavigatorState();
}

class _IdTopNavigatorState extends State<IdTopNavigator> {
  Widget navigatorDivider() {
    return const Row(
      children: [
        SizedBox(width: 8),
        IdImageBox(imagePath: 'assets/img/icon_navigator_next.png', imageWidth: 16, imageHeight: 16, imageFit: BoxFit.cover),
        SizedBox(width: 8),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Stack(
      children: [
        Container(
          height: 72,
          constraints: BoxConstraints(maxWidth: 1224),
        ),
        Positioned(
            top: 24,
            right: 0,
            child: Row(
              children: [
                IdNormalBtn(
                  onBtnPressed: () {},
                  childWidget: IdImageBox(
                      imagePath: (widget.navigatorMenu[1] == 'My Page') ? 'assets/img/icon_home_white.png' : 'assets/img/icon_home.png',
                      imageWidth: 18,
                      imageHeight: 18,
                      imageFit: BoxFit.cover),
                ),
                navigatorDivider(),
                Row(
                  children: List.generate(
                    widget.navigatorMenu.length - 1,
                    (index) => IdNormalBtn(
                        childWidget: Row(
                      children: [
                        IdNormalBtn(
                          onBtnPressed: widget.navigatorLink![index],
                          childWidget: uiCommon.styledText(
                              widget.navigatorMenu[index + 1],
                              15,
                              0,
                              1,
                              FontWeight.w600,
                              (widget.navigatorMenu[1] == 'My Page')
                                  ? IdColors.white
                                  : (index == widget.navigatorMenu.length - 2)
                                      ? IdColors.green2
                                      : IdColors.textTertiary,
                              TextAlign.left),
                        ),
                        (index == widget.navigatorMenu.length - 2) ? const SizedBox() : navigatorDivider(),
                      ],
                    )),
                  ),
                ),
              ],
            ))
      ],
    );
    return wg1;
  }
}
