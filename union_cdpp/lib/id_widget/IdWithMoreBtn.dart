import 'package:flutter/material.dart';

import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class IdWithMoreBtn extends StatefulWidget {
  final String content;
  final double fontSize;
  final FontWeight fontWeight;
  final Color textColor;
  final int cell;
  const IdWithMoreBtn({
    super.key,
    required this.content,
    required this.fontSize,
    required this.fontWeight,
    required this.textColor,
    required this.cell,
  });

  @override
  State<IdWithMoreBtn> createState() => _IdWithMoreBtnState();
}

class _IdWithMoreBtnState extends State<IdWithMoreBtn> {
  bool moreBool = false;
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Row(
      children: [
        Expanded(
          child: Text((moreBool) ? widget.content : '${widget.content.toString().substring(0, 54)}...',
              textAlign: TextAlign.start,
              maxLines: 10,
              style: TextStyle(
                fontWeight: widget.fontWeight,
                fontFamily: 'Pretendard',
                height: 1,
                color: widget.textColor,
                fontSize: widget.fontSize,
              ),
              softWrap: true),
        ),
        IdNormalBtn(
          onBtnPressed: () {
            if (moreBool) {
              moreBool = false;
            } else {
              moreBool = true;
            }
            setState(() {});
          },
          childWidget: IdImageBox(
              imagePath: moreBool ? 'assets/img/icon_arcodion_close.png' : 'assets/img/icon_arcodion_open.png',
              imageWidth: 24,
              imageHeight: 24,
              imageFit: BoxFit.cover),
        )
      ],
    );
    return wg1;
  }
}
