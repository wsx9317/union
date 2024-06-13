import 'package:flutter/material.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';

class MyDealStatusPopup extends StatefulWidget {
  final Function() closedOnpressed;
  final String status;
  final String coment;
  const MyDealStatusPopup({super.key, required this.closedOnpressed, required this.status, required this.coment});

  @override
  State<MyDealStatusPopup> createState() => _MyDealStatusPopupState();
}

class _MyDealStatusPopupState extends State<MyDealStatusPopup> {
  String userName = GV.pStrg.getXXX(Param_commonUserName);
  String userId = GV.pStrg.getXXX(Param_commonUserId);
  String offic = GV.pStrg.getXXX(Param_commonUserOffice);
  List<String> statusList = [
    '열람',
    '검토중',
    '검토보류',
    '사업모델링',
    'IM제작',
    '운용사태핑',
    '운용사검토',
    '투자자태핑',
    '투자검토중',
    '투자자모집',
    'MOU',
    '투자심의',
    '계약준비',
    '계약체결',
    '인허가/심의',
    '잔금'
  ];

  String title(String status) {
    String result = '';
    if (status == statusList[0]) {
      result = '열람';
    } else if (status == statusList[1]) {
      result = '검토중';
    } else if (status == statusList[2]) {
      result = '검토보류';
    } else if (status == statusList[3]) {
      result = '사업모델링(수익성검토)';
    } else if (status == statusList[4]) {
      result = 'IM제작';
    } else if (status == statusList[5]) {
      result = '운용사태핑';
    } else if (status == statusList[6]) {
      result = '운용사검토';
    } else if (status == statusList[7]) {
      result = '투자자태핑';
    } else if (status == statusList[8]) {
      result = '투자검토중';
    } else if (status == statusList[9]) {
      result = '투자자모집';
    } else if (status == statusList[10]) {
      result = 'MOU';
    } else if (status == statusList[11]) {
      result = '투자심의';
    } else if (status == statusList[12]) {
      result = '계약준비';
    } else if (status == statusList[13]) {
      result = '계약체결';
    } else if (status == statusList[14]) {
      result = '인허가/심의';
    } else if (status == statusList[15]) {
      result = '잔금';
    } else {
      result = '';
    }
    return result;
  }

  String statusImg(String status) {
    String result = '';
    if (status == statusList[0]) {
      result = 'assets/img/img_myDealPopup_01.png';
    } else if (status == statusList[1]) {
      result = 'assets/img/img_myDealPopup_02.png';
    } else if (status == statusList[2]) {
      result = 'assets/img/img_myDealPopup_03.png';
    } else if (status == statusList[3]) {
      result = 'assets/img/img_myDealPopup_04.png';
    } else if (status == statusList[4]) {
      result = 'assets/img/img_myDealPopup_05.png';
    } else if (status == statusList[5]) {
      result = 'assets/img/img_myDealPopup_06.png';
    } else if (status == statusList[6]) {
      result = 'assets/img/img_myDealPopup_07.png';
    } else if (status == statusList[7]) {
      result = 'assets/img/img_myDealPopup_08.png';
    } else if (status == statusList[8]) {
      result = 'assets/img/img_myDealPopup_09.png';
    } else if (status == statusList[9]) {
      result = 'assets/img/img_myDealPopup_10.png';
    } else if (status == statusList[10]) {
      result = 'assets/img/img_myDealPopup_11.png';
    } else if (status == statusList[11]) {
      result = 'assets/img/img_myDealPopup_12.png';
    } else if (status == statusList[12]) {
      result = 'assets/img/img_myDealPopup_13.png';
    } else if (status == statusList[13]) {
      result = 'assets/img/img_myDealPopup_14.png';
    } else if (status == statusList[14]) {
      result = 'assets/img/img_myDealPopup_15.png';
    } else if (status == statusList[15]) {
      result = 'assets/img/img_myDealPopup_16.png';
    } else {
      result = '';
    }
    return result;
  }

  String statusIcon(String status) {
    String result = '';
    if (status == statusList[0]) {
      result = 'assets/img/icon_myDealPopup_01.png';
    } else if (status == statusList[1]) {
      result = 'assets/img/icon_myDealPopup_02.png';
    } else if (status == statusList[2]) {
      result = 'assets/img/icon_myDealPopup_03.png';
    } else if (status == statusList[3]) {
      result = 'assets/img/icon_myDealPopup_04.png';
    } else if (status == statusList[4]) {
      result = 'assets/img/icon_myDealPopup_05.png';
    } else if (status == statusList[5]) {
      result = 'assets/img/icon_myDealPopup_06.png';
    } else if (status == statusList[6]) {
      result = 'assets/img/icon_myDealPopup_07.png';
    } else if (status == statusList[7]) {
      result = 'assets/img/icon_myDealPopup_08.png';
    } else if (status == statusList[8]) {
      result = 'assets/img/icon_myDealPopup_09.png';
    } else if (status == statusList[9]) {
      result = 'assets/img/icon_myDealPopup_10.png';
    } else if (status == statusList[10]) {
      result = 'assets/img/icon_myDealPopup_11.png';
    } else if (status == statusList[11]) {
      result = 'assets/img/icon_myDealPopup_12.png';
    } else if (status == statusList[12]) {
      result = 'assets/img/icon_myDealPopup_13.png';
    } else if (status == statusList[13]) {
      result = 'assets/img/icon_myDealPopup_14.png';
    } else if (status == statusList[14]) {
      result = 'assets/img/icon_myDealPopup_15.png';
    } else if (status == statusList[15]) {
      result = 'assets/img/icon_myDealPopup_16.png';
    } else {
      result = '';
    }
    return result;
  }

  String statusDesc(String status) {
    String result = '';
    if (status == statusList[0]) {
      //열람
      result = "매물을 열람하는 상태입니다. 이 단계에서 열람 후 현재 진행중인 프로젝트에 적합한 자산인지 판단하며 현재 프로젝트에 적합한 자산이 아닌경우 ‘검토보류’, 검토가능한 자산의 경우 ‘검토중‘ 단계로 진행됩니다.";
    } else if (status == statusList[1]) {
      //검토중
      result =
          "현재 진행 가능한 프로젝트에 적합한지 검토하는 단계입니다. 위치, 하드웨어, 가격 등이 각 프로젝트 별 가이드라인에 부합한지 검토하며 적합한 경우 ‘사업모델링’ 단계로 진행됩니다. 검토가 어려워 보이는 경우 ‘검토보류’로 분류되나, 새로운 프로젝트가 진행되면 다시 검토를 진행합니다.";
    } else if (status == statusList[2]) {
      //검토보류
      result = "검토 결과 현재 매칭 가능한 프로젝트가 없습니다. 재검토 또는 새로운 개발 프로젝트 발생 시 검토가 다시 진행될 수 있습니다.";
    } else if (status == statusList[3]) {
      //사업모델링(수익성검토)
      result = "스태킹기획, 설계기획, 약식매출가정 : 사업모델을 기획하는 단계입니다. 입점업종 기획 및 약식매출을 산출하며, 적합한 경우 ‘IM제작’ 단계 또는 운용사태핑 단계로 진행됩니다";
    } else if (status == statusList[4]) {
      //IM제작
      result = "CF제작, 도면설계, mook-up, 입지분석 : 자산의 투자자를 모집하기 위한 IM을 제작합니다. 매출추정, 기획도면, 입지분석 등을 진행합니다. 제작된 IM은 운용사 또는 투자자에게 전달됩니다.";
    } else if (status == statusList[5]) {
      //운용사태핑
      result = "사업구조, 사업성검토, 공법리스크검토 등 : 파트너 자산운용사에 자산 매입 검토를 요청하는 중입니다. 매입에 적합하다고 판단되는 경우, ‘운용사검토’ 단계로 진행됩니다.";
    } else if (status == statusList[6]) {
      //운용사검토
      result = "사업구조, 사업성검토, 공법리스크검토 등 : 파트너 자산운용사에서 자산 매입을 검토 및 분석 중입니다. 매입에 적합하다고 판단되는 경우, ‘투자자태핑’ 단계로 진행됩니다.";
    } else if (status == statusList[7]) {
      //투자자태핑
      result = "자산운용사가 해당 딜을 개발할 수 있는 투자자에게 태핑중입니다. \n개발에 긍정적인 경우 ‘추가 투자자모집/투자심의’ 단계로 진행됩니다.";
    } else if (status == statusList[8]) {
      //투자검토중
      result = "투자자가 자산 매입에 대해 검토중입니다. 매입에 긍정적인 경우 ‘투자자모집' 또는 '투자심의’ 단계로 진행됩니다.";
    } else if (status == statusList[9]) {
      //투자자모집
      result = "추가 투자자를 모집 중 입니다. 개발에 필요한 자금모집이 완료되는 경우 투자심의 단계로 진행됩니다.";
    } else if (status == statusList[10]) {
      //MOU
      result = "MOU가 체결되었습니다.  MOU 기간 동안 자금조달에 대한 준비가 완료되는 경우 계약을 준비합니다. 세부적인 내용은 담당 직원을 통해 전달받을 수 있습니다.";
    } else if (status == statusList[11]) {
      //투자심의
      result = "투자심의 진행중입니다. 투자심의 통과 후 자금조달에 대한 결정이 최종 확정됩니다. 세부적인 내용은 담당 직원을 통해 전달받을 수 있습니다.";
    } else if (status == statusList[12]) {
      //계약준비
      result = "계약체결을 준비중입니다. 세부적인 내용은 담당 직원을 통해 전달받을 수 있습니다.";
    } else if (status == statusList[13]) {
      //계약체결
      result = "계약체결이 완료되었습니다. 자금조달 사업준비내용 등의 세부적인 내용은 담당 직원을 통해 전달받을 수 있습니다.";
    } else if (status == statusList[14]) {
      //인허가/심의
      result = "계약체결이 완료되었습니다. 자세한 진행과정은 담당 직원을 통해 전달 받을 수 있습니다.";
    } else if (status == statusList[15]) {
      //잔금
      result = "매입 완료되었습니다. 고생하셨습니다.";
    } else {
      result = '';
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 1062,
      padding: const EdgeInsets.all(40),
      decoration: ShapeDecoration(
        color: IdColors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        shadows: const [
          BoxShadow(
            color: IdColors.black8Per,
            blurRadius: 18,
            offset: Offset(0, 4),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: uiCommon.styledText(title(widget.status), 32, 0, 1.3, FontWeight.w700, IdColors.textDefault, TextAlign.left)),
              IdNormalBtn(
                  onBtnPressed: widget.closedOnpressed,
                  childWidget: IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 32, imageHeight: 32, imageFit: BoxFit.cover)),
            ],
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 16),
          uiCommon.styledText('$offic $userName($userId)님의 <인사동 빌라 리모델링>딜은 <fb2>${title(widget.status)}</fb2> 상태입니다.', 16, 0, 1.6,
              FontWeight.w400, IdColors.black, TextAlign.left),
          const IdSpace(spaceWidth: 0, spaceHeight: 40),
          IdImageBox(imagePath: statusImg(widget.status), imageWidth: 982, imageHeight: 230, imageFit: BoxFit.fitWidth),
          const IdSpace(spaceWidth: 0, spaceHeight: 40),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            decoration: ShapeDecoration(
              color: IdColors.green5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IdImageBox(imagePath: statusIcon(widget.status), imageWidth: 100, imageHeight: 100, imageFit: BoxFit.cover),
                const IdSpace(spaceWidth: 40, spaceHeight: 0),
                Expanded(
                  child: SizedBox(
                    child: uiCommon.styledText(statusDesc(widget.status), 16, 0, 1.6, FontWeight.w400, IdColors.black, TextAlign.left),
                  ),
                ),
              ],
            ),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 40),
          uiCommon.styledText('현황 코멘트', 18, 0, 1.6, FontWeight.w700, IdColors.black, TextAlign.left),
          const IdSpace(spaceWidth: 0, spaceHeight: 8),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: ShapeDecoration(
              color: IdColors.backgroundDefault,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            ),
            child: uiCommon.styledText(widget.coment, 16, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 40),
          SizedBox(
            width: double.infinity,
            height: 44,
            child: Center(
              child: IdNormalBtn(
                onBtnPressed: widget.closedOnpressed,
                childWidget: Container(
                  width: 100,
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  decoration: ShapeDecoration(
                    color: IdColors.green2,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Center(
                    child: uiCommon.styledText('확인', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.center),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return wg1;
  }
}
