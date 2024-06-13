import 'package:flutter/material.dart';
import 'package:unionCDPP/api/id_api.dart';
import 'package:unionCDPP/common/globalvar.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/constants/constants.dart';
import 'package:unionCDPP/id_widget/Basic/IdState.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
import 'package:unionCDPP/id_widget/IdNormalBtn.dart';
import 'package:unionCDPP/id_widget/IdPageTopSection.dart';
import 'package:unionCDPP/id_widget/IdSpace.dart';
import 'package:unionCDPP/id_widget/IdTopNavigator.dart';
import 'package:unionCDPP/modelVO/noticeItem.dart';
import 'dart:html';

class _NoticeList {
  NoticeItem? data;
}

class NoticeDetail extends StatefulWidget {
  const NoticeDetail({super.key});

  @override
  IdState<NoticeDetail> createState() => _NoticeDetailState();
}

class _NoticeDetailState extends IdState<NoticeDetail> {
  List<_NoticeList> _noticeDetailDs = [];
  List menuNavigator = [];
  List menuNavigatorLink = [];

  int acturalPage = int.tryParse(GV.pStrg.getXXX(Param_nowPage)) ?? 1;

  NoticeItem? noticeList = NoticeItem();
  String seqStr = GV.pStrg.getXXX(Param_noticeNo);
  int seq = 0;

  String noticeTitle = '';
  String datetime = '';
  String noticeContent = '';
  String noticeUrl = '';
  String noticeFileName = '';
  String noticeFilePath = '';
  String s3FileUrl = '';
  String imgPath = '';

  List tempFileList = [];

  int containHTTP = 0;

  int fileCnt = 0;
  double fileDataSize = 0;

  @override
  void initState() {
    super.initState();
    seq = int.tryParse(seqStr) ?? 1;
    // seq = 1;
    _noticeDetailDs.add(_NoticeList());
    menuNavigator = ['home', '공지사항'];
    menuNavigatorLink = [
      () {
        uiCommon.IdMovePage(context, PAGE_NOTICE_PAGE);
      }
    ];

    fetchData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> fetchData() async {
    final NoticeItem? ret1 = await IdApi.getNoticeDetail(seqStr);

    if (ret1 != null) {
      noticeTitle = ret1.title!;
      noticeContent = ret1.content!;
      if (ret1.s3FileUrl != null) {
        imgPath = ret1.s3FileUrl!;
      } else {
        imgPath = '';
      }
      datetime = ret1.createDate!;

      if (ret1.fileList != null) {
        for (var i = 0; i < ret1.fileList!.length; i++) {
          tempFileList.add([ret1.fileList![i].fileName, ret1.fileList![i].s3Url]);
        }
      }
    }

    setState(() {});
  }

  Future<bool> getS3File(int index, String s3url) async {
    try {
      final result = await IdApi.getS3FileContent(s3url);

      if (result == null) return false;
      final blob = Blob([result], 'application/octet-stream');
      final url = Url.createObjectUrlFromBlob(blob);

      final anchor = AnchorElement()
        ..href = url
        ..download = tempFileList[index][0];
      anchor.click();
      Url.revokeObjectUrl(url);
    } catch (e) {
      print(e);
    }
    return true;
  }

  @override
  Widget idBuild(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          uiCommon.IdMovePage(context, '{PREV}');
          return false;
        },
        child: Scaffold(
          body: SizedBox(
            width: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const IdSpace(spaceWidth: 0, spaceHeight: 74),
                      Container(
                        width: double.infinity,
                        height: 500,
                        color: IdColors.pageTopBackground,
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(
                              maxWidth: 1224,
                            ),
                            child: Column(
                              children: [
                                IdTopNavigator(navigatorMenu: menuNavigator, navigatorLink: menuNavigatorLink),
                                const IdPageTopSection(
                                  menuName: 'NOTICE',
                                  pageDesc: '유용한 정보와 소식이\n알차게 준비되어 있습니다.',
                                  imgBoxWidget: IdImageBox(
                                      imagePath: 'assets/img/img_notice.png',
                                      imageWidth: 180.96,
                                      imageHeight: 253.41,
                                      imageFit: BoxFit.cover),
                                  navigator: SizedBox(),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      //섹션
                      Container(
                        width: double.infinity,
                        color: IdColors.white,
                        child: Center(
                          child: Container(
                            constraints: const BoxConstraints(maxWidth: 1224),
                            child: Column(
                              children: [
                                const IdSpace(spaceWidth: 0, spaceHeight: 100),
                                //내용
                                Column(
                                  children: [
                                    Container(
                                      width: double.infinity,
                                      height: 102,
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 2, color: IdColors.textDefault),
                                        ),
                                      ),
                                      child: Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          uiCommon.styledText((seq == 0) ? '' : noticeTitle, 24, 0, 1, FontWeight.w700,
                                              IdColors.textDefault, TextAlign.left),
                                        ],
                                      ),
                                    ),
                                    Container(
                                      width: double.infinity,
                                      padding: const EdgeInsets.symmetric(vertical: 40),
                                      decoration: const BoxDecoration(
                                        border: Border(
                                          top: BorderSide(width: 1, color: IdColors.borderDefault),
                                          bottom: BorderSide(width: 1, color: IdColors.borderDefault),
                                        ),
                                      ),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              uiCommon.styledText(
                                                  'Date', 16, 0, 1.6, FontWeight.w500, IdColors.textTertiary, TextAlign.left),
                                              const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                              uiCommon.styledText((seq == 0) ? '' : datetime, 16, 0, 1.6, FontWeight.w500,
                                                  IdColors.textTertiary, TextAlign.left),
                                            ],
                                          ),
                                          const IdSpace(spaceWidth: 0, spaceHeight: 47),
                                          (imgPath != '')
                                              ?
                                              // IdImageBox2(
                                              //     imagePath: imgPath, imageHeight: 500, imageWidth: 500, imageFit: BoxFit.fitHeight)
                                              Container(
                                                  width: 500,
                                                  height: 500,
                                                  child: Image.network(imgPath, fit: BoxFit.fitHeight),
                                                )
                                              : SizedBox(),
                                          uiCommon.styledText(
                                              noticeContent, 18, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                          uiCommon.styledText('', 18, 0, 1.6, FontWeight.w400, IdColors.textDefault, TextAlign.left),
                                          Visibility(
                                            visible: (noticeUrl.isNotEmpty) ? true : false,
                                            child: IdNormalBtn(
                                              onBtnPressed: () {},
                                              childWidget: SizedBox(
                                                child: uiCommon.styledText((seq == 0) ? '' : '<u>$noticeUrl<u>', 18, 0, 1.6,
                                                    FontWeight.w400, IdColors.blue, TextAlign.left),
                                              ),
                                            ),
                                          ),
                                          const IdSpace(spaceWidth: 0, spaceHeight: 47),
                                          Visibility(
                                            visible: (tempFileList.isNotEmpty) ? true : false,
                                            child: Column(
                                              children: List.generate(
                                                tempFileList.length,
                                                (index) => Column(
                                                  children: [
                                                    IdNormalBtn(
                                                        onBtnPressed: () async {
                                                          if (await getS3File(index, tempFileList[index][1])) {
                                                            GV.d('성공');
                                                          } else {
                                                            GV.d('실패');
                                                          }
                                                        },
                                                        childWidget: Row(
                                                          children: [
                                                            const IdImageBox(
                                                                imagePath: 'assets/img/icon_file.png',
                                                                imageWidth: 20,
                                                                imageHeight: 20,
                                                                imageFit: BoxFit.cover),
                                                            const IdSpace(spaceWidth: 8, spaceHeight: 0),
                                                            uiCommon.styledText(tempFileList[index][0], 16, 0, 1, FontWeight.w400,
                                                                IdColors.textTertiary, TextAlign.left)
                                                          ],
                                                        )),
                                                    (index + 1 == tempFileList.length) ? SizedBox() : IdSpace(spaceWidth: 0, spaceHeight: 8)
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    const IdSpace(spaceWidth: 0, spaceHeight: 32),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: SizedBox(
                                            width: double.infinity,
                                          ),
                                        ),
                                        IdNormalBtn(
                                          onBtnPressed: () {
                                            uiCommon.IdMovePage(context, PAGE_NOTICE_PAGE);
                                          },
                                          childWidget: Container(
                                            width: 73,
                                            height: 38,
                                            decoration: BoxDecoration(
                                              color: IdColors.textDefault,
                                              borderRadius: BorderRadius.circular(8),
                                            ),
                                            child: Center(
                                              child: uiCommon.styledText('목록', 14, 0, 1, FontWeight.w600, IdColors.white, TextAlign.left),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                    const IdSpace(spaceWidth: 0, spaceHeight: 54),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //푸터
                      idCommonFooter(),
                    ],
                  ),
                ),
                //헤더
                idCommonHeader(),
              ],
            ),
          ),
        ));
  }
}
