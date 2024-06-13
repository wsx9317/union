import 'package:flutter/material.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class AddressPopup extends StatefulWidget {
  final Function() closeFuntion;
  final Widget addressWidget;
  const AddressPopup({super.key, required this.closeFuntion, required this.addressWidget});

  @override
  State<AddressPopup> createState() => _AddressPopupState();
}

class _AddressPopupState extends State<AddressPopup> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 600,
      height: 450,
      padding: const EdgeInsets.all(40),
      decoration: BoxDecoration(
        color: IdColors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: const [
          BoxShadow(
            color: IdColors.black8Per,
            blurRadius: 16,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: uiCommon.styledText('주소검색', 32, 0, 1, FontWeight.w700, IdColors.textDefault, TextAlign.left),
              ),
              IdNormalBtn(
                onBtnPressed: widget.closeFuntion,
                childWidget:
                    const IdImageBox(imagePath: 'assets/img/icon_close_big.png', imageWidth: 32, imageHeight: 32, imageFit: BoxFit.cover),
              ),
            ],
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 16),
          Expanded(
            child: widget.addressWidget,
          ),
        ],
      ),
    );
    return wg1;
  }
}
