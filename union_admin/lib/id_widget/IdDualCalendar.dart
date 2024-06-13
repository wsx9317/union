import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:union_admin/common/uiCommon.dart';
import 'package:union_admin/id_widget/CalendarDatePicker/calendar_date_picker2.dart';
import 'package:union_admin/id_widget/CalendarDatePicker/calendar_date_picker2_config.dart';
import 'package:union_admin/id_widget/IdColor.dart';
import 'package:union_admin/id_widget/IdNormalBtn.dart';

class IdDualCalendar extends StatefulWidget {
  IdDualCalendar(this.rangeDateValue, {super.key, required this.onClose, required this.onComplete});
  List<DateTime?>? rangeDateValue;
  final Function? onClose;
  final Function(DateTime, DateTime)? onComplete;

  @override
  _IdDualCalendarState createState() => _IdDualCalendarState();
}

class _IdDualCalendarState extends State<IdDualCalendar> {
  final config = CalendarDatePicker2Config(
    modePickerTextHandler: ({required monthDate}) {
      return DateFormat('yyyy년 MM월').format(monthDate);
    },
    currentDate: DateTime.now(),
    disableModePicker: true,
    dayBorderRadius: BorderRadius.all(Radius.circular(8)),
    weekdayLabels: ['일', '월', '화', '수', '목', '금', '토'],
    centerAlignModePicker: true,
    calendarView: CalendarDatePicker2View.first,
    calendarType: CalendarDatePicker2Type.range,
    selectedDayHighlightColor: IdColors.brightGreen,
    weekdayLabelTextStyle: const TextStyle(color: Color.fromRGBO(61, 72, 97, 1), fontWeight: FontWeight.normal),
    controlsTextStyle: const TextStyle(color: Colors.black, fontSize: 15, fontWeight: FontWeight.bold),
  );

  Widget _buildDefaultRangeDatePickerWithValue(bool firstDate) {
    var c1 = config.copyWith();
    c1.calendarView = firstDate ? CalendarDatePicker2View.first : CalendarDatePicker2View.last;
    return Container(
        width: 248,
        child: Column(mainAxisSize: MainAxisSize.min, children: [
          CalendarDatePicker2(
            config: c1,
            value: widget.rangeDateValue!,
            onValueChanged: (dates) => setState(() {
              widget.rangeDateValue = dates;
            }),
          )
        ]));
  }

  String _getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values = values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    var valueText = (values.isNotEmpty ? values[0] : null).toString().replaceAll('00:00:00.000', '');

    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText = values.isNotEmpty ? values.map((v) => v.toString().replaceAll('00:00:00.000', '')).join(', ') : '';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        final startDate = DateFormat('yyyy년 M월 d일').format(values[0]!);
        final endDate = values.length > 1 ? DateFormat('M월 d일').format(values[1]!) : '';
        valueText = '$startDate ~ $endDate';
      } else
        return '';
    }

    return valueText;
  }

  @override
  Widget build(BuildContext context) {
    uiCommon.setScreen(context);

    return Container(
        width: 536,
        decoration: BoxDecoration(
            border: Border.all(color: Color.fromRGBO(220, 223, 227, 1)),
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8))),
        child: Column(children: [
          Padding(
              padding: EdgeInsets.fromLTRB(20, 5, 10, 0),
              child: Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
                _buildDefaultRangeDatePickerWithValue(true),
                SizedBox(width: 10),
                _buildDefaultRangeDatePickerWithValue(false)
              ])),
          Divider(),
          Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 10, 18),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(_getValueText(config.calendarType, widget.rangeDateValue!),
                        style: TextStyle(fontSize: 16, color: IdColors.green, fontWeight: FontWeight.bold)),
                    widget.rangeDateValue!.length != 0
                        ? IdNormalBtn(
                            onBtnPressed: () {
                              widget.rangeDateValue!.clear();
                              setState(() {});
                            },
                            childWidget: Container(
                              width: 60,
                              height: 25,
                              decoration: BoxDecoration(
                                color: IdColors.brightGreen,
                                borderRadius: BorderRadiusDirectional.circular(4),
                              ),
                              child: Center(
                                child: Text(
                                  '선택해제',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          )
                        : SizedBox()
                  ],
                ),
                Row(children: [
                  IdNormalBtn(
                    onBtnPressed: () {
                      widget.onClose!();
                    },
                    childWidget: Container(
                      width: 70,
                      height: 36,
                      decoration: BoxDecoration(color: IdColors.brightGreen, borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          '닫기',
                          style: TextStyle(fontSize: 16, color: IdColors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                  IdNormalBtn(
                    onBtnPressed: () {
                      // if (widget.rangeDateValue!.length != 2) return;
                      if (widget.rangeDateValue!.length != 2) {
                        widget.onComplete!(DateTime.parse('2000-01-01 00:00:00.000'), DateTime.parse('2000-01-01 00:00:00.000'));
                        return;
                      }
                      widget.onComplete!(widget.rangeDateValue![0]!, widget.rangeDateValue![1]!);
                    },
                    childWidget: Container(
                      width: 70,
                      height: 36,
                      decoration: BoxDecoration(color: IdColors.brightGreen, borderRadius: BorderRadius.circular(4)),
                      child: Center(
                        child: Text(
                          '적용',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10)
                ])
              ]))
        ]));
  }
}
