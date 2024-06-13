import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

class DropDown extends StatefulWidget {
  final double dropDownWidth;
  final double dropDownHeight;
  final List<DropdownMenuItem<dynamic>> items;
  final FocusNode focusDropDown;
  final bool changeDropdown;
  final String? hint;
  final Color? boxColor;
  final Function()? onChanged;
  const DropDown({
    super.key,
    required this.items,
    required this.focusDropDown,
    required this.changeDropdown,
    required this.dropDownWidth,
    required this.dropDownHeight,
    this.hint,
    this.boxColor,
    this.onChanged,
  });

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.dropDownWidth,
      height: widget.dropDownHeight,
      decoration: BoxDecoration(
        color: widget.boxColor ?? IdColors.green1,
        borderRadius: BorderRadius.circular(4),
      ),
      child: DropdownButtonFormField2(
        decoration: InputDecoration(
          // isDense: true,
          contentPadding: EdgeInsets.zero,
          border: OutlineInputBorder(
            gapPadding: 10,
            borderRadius: BorderRadius.circular(4),
            borderSide: BorderSide(color: widget.boxColor ?? IdColors.green1, width: 0.9),
          ),
        ),
        focusNode: widget.focusDropDown,
        enableFeedback: false,
        isExpanded: true,
        hint: uiCommon.styledText((widget.hint) ?? '선택하세요', 14, 0, 1.6, FontWeight.w400, IdColors.white, TextAlign.left),
        items: widget.items,
        onChanged: (value) {
          widget.focusDropDown.unfocus();
        },
        onSaved: (value) {},
        iconStyleData: IconStyleData(
            icon: Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Icon(widget.changeDropdown ? Icons.expand_less : Icons.expand_more, color: IdColors.white),
            ),
            iconSize: 20),
        dropdownStyleData: DropdownStyleData(
          offset: const Offset(0, -12),
          decoration: BoxDecoration(
            border: Border.all(color: IdColors.white, width: 0.9),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        selectedItemBuilder: (context) {
          return widget.items.map((item) {
            String t1 = (item.child as Text).data!;

            return Container(child: uiCommon.styledText(t1, 14, 0, 1.6, FontWeight.w400, IdColors.white, TextAlign.left));
          }).toList();
        },
      ),
    );
  }
}
