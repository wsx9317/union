import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdDivider.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:flutter/material.dart';

import '../common/globalvar.dart';
import '../constants/constants.dart';
import '../modelVO/myInfoItem.dart';

class IdCommonFooter extends StatefulWidget {
  const IdCommonFooter({super.key});

  @override
  State<IdCommonFooter> createState() => _IdCommonFooterState();
}

class _IdCommonFooterState extends State<IdCommonFooter> {
  MyInfoItem user1 = GV.myInfoItem;

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      height: 240,
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(
          top: BorderSide(width: 1, color: IdColors.borderDefault),
        ),
      ),
      child: Center(
        child: Stack(
          children: [
            Container(
              height: 240,
              constraints: const BoxConstraints(maxWidth: 1224),
            ),
            Positioned(
              left: 0,
              top: 60,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      uiCommon.styledText(
                          '사업자 번호 <fb1>사업자등록번호 670-86-00609)</fb1>', 14, 0, 1.6, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
                      const IdDivider(),
                      uiCommon.styledText('대표이사 <fb1>이장호</fb1>', 14, 0, 1.6, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
                      const IdDivider(),
                      uiCommon.styledText('브랜드 관리 책임자 <fb1>박지빈</fb1>', 14, 0, 1.6, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
                    ],
                  ),
                  const IdSpace(spaceWidth: 0, spaceHeight: 2),
                  Row(
                    children: [
                      uiCommon.styledText(
                          '전화번호 <fb1>02-2677-1214</fb1>', 14, 0, 1.6, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
                      const IdDivider(),
                      uiCommon.styledText(
                          '팩스 <fb1>02-02-2677-1215-1214</fb1>', 14, 0, 1.6, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
                      const IdDivider(),
                      uiCommon.styledText(
                          '영업문의 <fb2>unionplace@unionplace.kr</fb2>', 14, 0, 1.6, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
                    ],
                  ),
                  const IdSpace(spaceWidth: 0, spaceHeight: 2),
                  Row(
                    children: [
                      uiCommon.styledText('회사 <fb1>02-2677-1214</fb1>', 14, 0, 1.6, FontWeight.w400, IdColors.textSecondly, TextAlign.left),
                      const IdDivider(),
                      uiCommon.styledText('주소 <fb1>07222 서울시 영등포구 당산로 241, 유니언타운</fb1>', 14, 0, 1.6, FontWeight.w400, IdColors.textSecondly,
                          TextAlign.left),
                    ],
                  ),
                  const IdSpace(spaceWidth: 0, spaceHeight: 16),
                  //copyright
                  uiCommon.styledText('Copyright © 2017-2024 union company All Rights Reserved', 13, 0, 1.6, FontWeight.w700,
                      IdColors.textTertiary, TextAlign.left),
                ],
              ),
            ),
            Positioned(
              right: 0,
              top: 60,
              child: Row(
                children: [
                  IdNormalBtn(
                    onBtnPressed: () {
                      user1.isEmpty() ? uiCommon.IdMovePage(context, PAGE_SIGNUP) : 1 == 1;
                    },
                    childWidget: uiCommon.styledText('회원가입', 14, 0, 1.6, FontWeight.w700, IdColors.textSecondly, TextAlign.left),
                  ),
                  const IdDivider(),
                  IdNormalBtn(
                    onBtnPressed: () {
                      user1.isEmpty() ? uiCommon.IdMovePage(context, PAGE_FIND_IDPWD) : 1 == 1;
                    },
                    childWidget: uiCommon.styledText('아이디/비번찾기', 14, 0, 1.6, FontWeight.w700, IdColors.textSecondly, TextAlign.left),
                  ),
                  const IdDivider(),
                  IdNormalBtn(
                    onBtnPressed: () {},
                    childWidget: uiCommon.styledText('이용약관', 14, 0, 1.6, FontWeight.w700, IdColors.textSecondly, TextAlign.left),
                  ),
                  const IdDivider(),
                  IdNormalBtn(
                    onBtnPressed: () {},
                    childWidget: uiCommon.styledText('개인정보처리방침', 14, 0, 1.6, FontWeight.w700, IdColors.textSecondly, TextAlign.left),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
    return wg1;
  }
}
