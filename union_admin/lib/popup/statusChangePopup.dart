import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:union_admin/api/id_api.dart';
import 'package:union_admin/common/globalvar.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/constants/constants.dart';
import 'package:union_admin/id_widget/IdColor.dart';
import 'package:union_admin/id_widget/IdImageBox1.dart';
import 'package:union_admin/id_widget/IdInputValidation.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';
import 'package:union_admin/id_widget/IdSpace.dart';
import 'package:union_admin/modelVO/progressResponse.dart';

class StatusChangePopup extends StatefulWidget {
  final Function() onlyCloseFunction;
  final List cdList;
  final String progress;
  const StatusChangePopup({
    super.key,
    required this.onlyCloseFunction,
    required this.cdList,
    required this.progress,
  });

  @override
  State<StatusChangePopup> createState() => _StatusChangePopupState();
}

class _StatusChangePopupState extends State<StatusChangePopup> {
//TODO 유저넘버 임시
  String userNo = '1';
  String dealNo = GV.pStrg.getXXX(Param_dealNoString);
  String progressStr = '';
  List codeList = [];

  var _focusDropDown = FocusNode();
  bool changeDropdown = false;
  List<DropdownMenuItem> _items = [];

  String searchType = '';
  TextEditingController _commentController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    progressStr = widget.progress;
    itemList();

    for (var i = 0; i < widget.cdList.length; i++) {
      if (widget.cdList[i][1] == progressStr) {
        searchType = widget.cdList[i][0];
      }
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  Future<bool> setStatus() async {
    try {
      final result = await IdApi.setStatus(userNo, dealNo, searchType, _commentController.text);
      if (result == null) return false;
    } catch (e) {
      print(e);
    }
    return true;
  }

  void itemList() {
    for (var i = 0; i < widget.cdList.length; i++) {
      _items.add(DropdownMenuItem(
        value: widget.cdList[i][0],
        child: Text(widget.cdList[i][1], style: TextStyle(color: IdColors.textDefault, fontWeight: FontWeight.w400, fontSize: 14)),
      ));
    }
  }

  Widget dropdown(FocusNode focusDropDown, String hint, List<DropdownMenuItem<dynamic>> items, bool changeDropdown) {
    return Container(
      width: double.infinity,
      height: 40,
      padding: EdgeInsets.fromLTRB(0, 7, 0, 7),
      decoration: BoxDecoration(
        color: IdColors.white,
        border: Border.all(
          width: 1,
          color: IdColors.borderDefault,
        ),
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonFormField2(
        decoration: const InputDecoration(
          isCollapsed: true,
          contentPadding: EdgeInsets.zero,
          border: InputBorder.none,
        ),
        focusNode: focusDropDown,
        enableFeedback: false,
        isExpanded: true,
        hint: uiCommon.styledText(hint, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left),
        items: items,
        onChanged: (value) {
          searchType = value;
          setState(() {});
          focusDropDown.unfocus();
        },
        onSaved: (value) {},
        iconStyleData: IconStyleData(
          icon: Padding(
            padding: const EdgeInsets.only(top: 4, right: 11),
            child: Icon(
              changeDropdown ? Icons.expand_less : Icons.expand_more,
              color: IdColors.textDefault,
            ),
          ),
          iconSize: 20,
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 150,
          offset: const Offset(0, -12),
          decoration: BoxDecoration(
            border: Border.all(color: IdColors.white, width: 0.9),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        selectedItemBuilder: (context) {
          return items.map((item) {
            String t1 = (item.child as Text).data!;

            return Container(child: uiCommon.styledText(t1, 16, 0, 1.6, FontWeight.w500, IdColors.textDefault, TextAlign.left));
          }).toList();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget wg1 = Container(
      width: 420,
      height: 421,
      padding: const EdgeInsets.all(24),
      decoration: ShapeDecoration(
        color: IdColors.white,
        shape: RoundedRectangleBorder(
          side: const BorderSide(
            width: 1,
            strokeAlign: BorderSide.strokeAlignOutside,
            color: IdColors.borderDefault,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
        shadows: const [
          BoxShadow(
            color: IdColors.black8Per,
            blurRadius: 16,
            offset: Offset(0, 0),
            spreadRadius: 0,
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              const SizedBox(
                width: double.infinity,
                height: 29,
              ),
              Positioned(
                top: 0,
                left: 0,
                child: uiCommon.styledText('상태변경', 18, 0, 1.6, FontWeight.w700, IdColors.black, TextAlign.left),
              ),
              Positioned(
                top: 0,
                right: 0,
                child: IdNormalBtn(
                  onBtnPressed: widget.onlyCloseFunction,
                  childWidget: IdImageBox(imagePath: 'assets/img/icon_close.png', imageWidth: 24, imageHeight: 24, imageFit: BoxFit.cover),
                ),
              )
            ],
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          uiCommon.styledText('상태', 14, 0, 1, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          const IdSpace(spaceWidth: 0, spaceHeight: 4),
          dropdown(_focusDropDown, progressStr, _items, changeDropdown),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          uiCommon.styledText('코멘트', 14, 0, 1, FontWeight.w400, IdColors.textDefault, TextAlign.left),
          const IdSpace(spaceWidth: 0, spaceHeight: 4),
          Container(
            width: double.infinity,
            height: 132,
            decoration: BoxDecoration(
              color: IdColors.backgroundDefault,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TextField(
                controller: _commentController,
                maxLines: null,
                keyboardType: TextInputType.multiline,
                decoration: InputDecoration(border: InputBorder.none),
              ),
            ),
          ),
          const IdSpace(spaceWidth: 0, spaceHeight: 24),
          Row(
            children: [
              IdNormalBtn(
                onBtnPressed: widget.onlyCloseFunction,
                childWidget: Container(
                  width: 182,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: IdColors.borderDefault,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Center(
                    child: uiCommon.styledText('닫기', 15, 0, 1, FontWeight.w600, IdColors.textTertiary, TextAlign.left),
                  ),
                ),
              ),
              const IdSpace(spaceWidth: 8, spaceHeight: 0),
              IdNormalBtn(
                onBtnPressed: () async {
                  if (await setStatus()) {
                    uiCommon.IdMovePage(context, PAGE_DEAL_DETAIL_PAGE);
                  } else {
                    GV.d('실패');
                  }
                },
                childWidget: Container(
                  width: 182,
                  height: 44,
                  decoration: ShapeDecoration(
                    color: IdColors.green,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: Center(
                    child: uiCommon.styledText('확인', 15, 0, 1, FontWeight.w600, IdColors.white, TextAlign.left),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
    return wg1;
  }
}
