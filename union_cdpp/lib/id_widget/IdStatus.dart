import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdStatus extends StatefulWidget {
  final String status;
  const IdStatus({
    super.key,
    required this.status,
  });

  @override
  State<IdStatus> createState() => _IdStatusState();
}

class _IdStatusState extends State<IdStatus> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      height: 37,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: ShapeDecoration(
        color: (widget.status == '거래중' || widget.status == '보류' || widget.status == '거래완료') ? IdColors.white : IdColors.green2,
        shape: RoundedRectangleBorder(
          side: BorderSide(
              width: 1,
              color:
                  (widget.status == '거래중' || widget.status == '보류' || widget.status == '거래완료') ? IdColors.borderDefault : IdColors.green2),
          borderRadius: BorderRadius.circular(40),
        ),
      ),
      child: Center(
        child: Row(
          children: [
            // (widget.status == '거래중' || widget.status == '보류' || widget.status == '거래완료')
            //     ? Row(
            //         children: [
            //           IdImageBox(
            //               imagePath: (widget.status == '거래중')
            //                   ? 'assets/img/icon_deal.png'
            //                   : (widget.status == '보류')
            //                       ? 'assets/img/icon_negative.png'
            //                       : 'assets/img/icon_ok.png',
            //               imageWidth: 20,
            //               imageHeight: 20,
            //               imageFit: BoxFit.cover),
            //           IdSpace(spaceWidth: 6, spaceHeight: 0),
            //         ],
            //       )
            //     : const SizedBox(),
            uiCommon.styledText(
                widget.status,
                18,
                0,
                1,
                FontWeight.w500,
                (widget.status == '거래중')
                    ? IdColors.green2
                    : (widget.status == '보류')
                        ? IdColors.textDisabled
                        : (widget.status == '거래완료')
                            ? IdColors.textSecondly
                            : IdColors.white,
                TextAlign.left),
          ],
        ),
      ),
    );
    return wg1;
  }
}
