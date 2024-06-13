import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:flutter/material.dart';

class Idpagination2 extends StatefulWidget {
  final int totalPageCnt;
  const Idpagination2({super.key, required this.totalPageCnt});

  @override
  State<Idpagination2> createState() => _Idpagination2State();
}

class _Idpagination2State extends State<Idpagination2> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      child: Row(
        children: [
          //맨앞으로 가는거
          //이전으로 가는거
          //숫자
          Row(
            children: List.generate(
                widget.totalPageCnt,
                (index) => IdNormalBtn(
                      childWidget: Container(
                        decoration: BoxDecoration(
                          color: IdColors.white,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: uiCommon.styledText(index.toString(), 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                      ),
                    )),
          )
          //다음으로 가는거
          //맨끝으로 가는거
        ],
      ),
    );
    return wg1;
  }
}
