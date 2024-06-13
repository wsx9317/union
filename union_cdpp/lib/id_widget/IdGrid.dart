import 'package:flutter/material.dart';
import 'package:hovering/hovering.dart';
import '../common/uiCommon.dart';
import '../id_widget/IdColor.dart';

///The main class. Use it like
class IdGrid extends StatefulWidget {
  ///A key for the Widget
  final Key? key;

  ///The whole width of the PlGrid widget
  final double width;

  ///The whole height of the PlGrid widget
  final double? height;
  final double headerHeight;
  final List<dynamic>? headerColumns;
  final List<List<dynamic>> data;

  ///The grid now gives you the possibility to pass a asynchronous function to fetch
  ///the data instead of passing it directly. Use it if your data will be fetched from
  ///an api or if it's going to take some time to load. Use it like so:
  ///```dart
  ///PlGrid(
  ///   dataAsync: ()async{
  ///       var response = await callApiForData();
  ///       List<List> convertedApiData = convertDataFromApi(response.data);
  ///       return convertedApiData;
  ///   }
  ///)
  ///```
  final Future<List<List<dynamic>>> Function()? dataAsync;

  ///The percentage of the whole width that the column has to take. If null,
  ///will distribute all columns equally
  final List<double> columnWidthsPercentages;

  ///A function that takes in the index of the a header cell and returns a color for it's background
  ///```dart
  ///PlGrid(headerCellsColor: (i)=> i % 2 == 0 ? Colors.white : Colors.grey)
  ///```
  final Color Function(int)? headerCellColor;

  ///Sets the height of each row manually
  ///```dart
  /// PlGrid(
  ///   heightByRow: (row){
  ///  //null would size automatically as if you
  ///  //haven't passed the height to the container
  ///  return row == 2 ? 40 : null;
  ///  }
  /// )
  ///```
  final double Function(int)? heightByRow;

  final double? rowCnt;

  ///Sets the row cells alignment in a row manually
  ///```dart
  /// PlGrid(
  ///   alignmentByRow: (row,cell){
  ///  return row == 2 && cell == 2 ? Alignment.topRight : null;
  ///  }
  /// )
  ///```
  final Alignment Function(int, int)? alignmentByRow;

  ///Sets the header cells alignment manually
  ///```dart
  /// PlGrid(
  ///   alignmentByRow: (cell){
  ///  return cell == 2 ? Alignment.topRight : null;
  ///  }
  /// )
  ///```
  final Alignment Function(int)? headerAlignmentByCells;

  ///Custom style to apply to the rows
  final TextStyle rowsStyle;

  ///Custom style to apply to the header cells
  final TextStyle headerStyle;

  ///Marks if the PlGrid should show or not inner grid lines
  final bool internalGrid;

  ///Padding to be applied on every and each header cell
  final EdgeInsets headerCellsPadding;

  ///Padding to be applied on every and each row cell
  final EdgeInsets rowCellsPadding;

  ///Widget to display when theres no registers to display
  final Widget? noContentWidget;

  ///A function that receives the index of the cell, the content and
  ///returns a widget to render the content of that cell
  final Widget Function(int row, int cell, dynamic)? rowsCellRenderer;

  ///A function that receives the index of the header cell, the content and
  ///returns a widget to render the content of that cell
  final Widget Function(int, dynamic)? headerCellRenderer;

  /// header위에 표시되는 영역
  final Widget Function()? preHeaderRenderer;

  final Color borderColor;

  final Color headerBorderColor;
  final bool headerInternalGrid;
  final Color? headerTopColor;
  final Color rowColor;
  final Color? hoverColor;

  final String? hoverStatus;

  /// headerDecoration이 null이면 header가 표시되지 않는다.
  final Decoration? headerDecoration;
  final double? headerBodyInterval;
  final double rowInterval;
  final Decoration? rowDecoration;
  final Function(int)? onRowClick;

  static const baseHeaderCellsPadding = EdgeInsets.only(left: 10);
  static const baseRowCellsPadding = EdgeInsets.only(left: 10, top: 5, bottom: 5);
  static const baseHeaderStyle = const TextStyle(fontSize: 14, fontWeight: FontWeight.bold);
  static const baseRowStyle = TextStyle(fontSize: 14, fontWeight: FontWeight.normal);

  IdGrid(
      {this.key,
      this.preHeaderRenderer,
      required this.columnWidthsPercentages,
      required this.headerColumns,
      required this.headerAlignmentByCells,
      this.headerCellRenderer,
      this.headerCellColor,
      this.width = 320,
      this.height,
      this.headerHeight = 30,
      this.headerCellsPadding = baseHeaderCellsPadding,
      this.rowCellsPadding = baseRowCellsPadding,
      this.internalGrid = false,
      this.headerStyle = baseHeaderStyle,
      this.headerBorderColor = Colors.black38,
      this.headerInternalGrid = false,
      this.headerTopColor = Colors.white54,
      // this.headerTopColor = const Color.fromRGBO(255, 255, 255, 0),
      this.headerBodyInterval = 0,
      this.headerDecoration,
      this.rowDecoration = const BoxDecoration(
        color: Colors.teal,
        boxShadow: [BoxShadow(color: Colors.red, spreadRadius: 3, blurRadius: 4, offset: Offset(3, 3))],
        // boxShadow: [BoxShadow(color: Colors.red, spreadRadius: 3, blurRadius: 4, offset: Offset(3, 3))],
      ),
      this.rowInterval = 0,
      this.rowsStyle = baseRowStyle,
      this.alignmentByRow,
      required this.data,
      this.dataAsync,
      required this.heightByRow,
      this.rowCnt,
      this.noContentWidget,
      required this.rowsCellRenderer,
      this.borderColor = Colors.black38,
      this.rowColor = IdColors.white,
      this.hoverColor,
      this.hoverStatus,
      this.onRowClick}) {
    if (headerColumns == null) throw Exception(_logError('Headers can\'t be null'));
    if (columnWidthsPercentages.length > headerColumns!.length)
      throw Exception(_logError('columnWidthsPercentages length can\'t be greater than headerColumns length'));
    if (columnWidthsPercentages.reduce((value, element) => value + element) > 100)
      throw Exception(_logError('columnWidth\'s sum is greather than 100'));
  }

  String _logError(String error) {
    return '[PlGrid] $error';
  }

  @override
  _IdGridState createState() => _IdGridState();
}

class _IdGridState extends State<IdGrid> {
  String lastSearch = '';
  late int lastMilliseconds;
  late List<List> _data;

  @override
  void initState() {
    _data = widget.data;
    if (widget.dataAsync != null) {
      WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
        widget.dataAsync!().then((dataReturned) {
          setState(() {
            _data = dataReturned;
          });
        });
      });
    }
    lastMilliseconds = DateTime.now().millisecondsSinceEpoch;
    super.initState();
  }

  @override
  void dispose() {
    widget.data.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _data = widget.data;
    return Container(
        key: widget.key,
        width: widget.width,
        height: widget.height,
        child: Column(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.start, children: [
          widget.preHeaderRenderer != null ? widget.preHeaderRenderer!() : SizedBox(),
          widget.headerTopColor != null ? Container(height: 1, color: widget.headerTopColor) : SizedBox(),
          widget.headerDecoration != null && widget.headerHeight != 0
              ? Container(decoration: widget.headerDecoration, child: _tableHeader())
              : SizedBox(),
          SizedBox(height: widget.headerBodyInterval ?? 0),
          _data.length > 0
              ? Container(
                  constraints: BoxConstraints(
                    minHeight: (widget.rowCnt != null)
                        ? (widget.heightByRow!(0) + widget.rowInterval) * widget.rowCnt!
                        : (widget.heightByRow!(0) + widget.rowInterval) * 10,
                    maxHeight: double.infinity,
                    minWidth: 0,
                    maxWidth: double.infinity,
                  ),
                  child: _tableRows())
              : widget.noContentWidget ?? SizedBox()
        ]));
  }

  ///Builds the table header
  Widget _tableHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: List.generate(widget.headerColumns!.length, (i) {
        bool left = i != 0, right = i != widget.headerColumns!.length - 1;
        Widget? cellWidget = widget.headerCellRenderer != null ? widget.headerCellRenderer!(i, widget.headerColumns![i]) : null;
        return Container(
          width: _getColumnWidth(i),
          height: widget.headerHeight,
          alignment: widget.headerAlignmentByCells != null ? widget.headerAlignmentByCells!(i) : Alignment.centerLeft,
          decoration: widget.headerDecoration == null
              ? BoxDecoration(
                  color: widget.headerCellColor != null ? widget.headerCellColor!(i) : Colors.transparent,
                  border: _makeBorder(
                    top: true,
                    left: widget.headerInternalGrid ? left : false,
                    bottom: true,
                    right: widget.headerInternalGrid ? right : false,
                    borderColor: widget.headerBorderColor,
                  ),
                )
              : widget.headerDecoration,
          child: Padding(
            padding: widget.headerCellsPadding,
            child: cellWidget != null
                ? cellWidget
                : widget.headerColumns![i] is Widget
                    ? widget.headerColumns![i]
                    : uiCommon.styledText(
                        widget.headerColumns![i].toString(), 16, 0, 1.6, FontWeight.w400, IdColors.lightGray2, TextAlign.left),
          ),
        );
      }),
    );
  }

  ///Builds a table row
  Widget _makeRow(List cells, {bool top = true, bool bottom = true, required int rowNumber, TextStyle? style}) {
    List<Widget> cellWidgets = List.generate(
      cells.length,
      (i) {
        bool right = (i != cells.length - 1);
        var _style = style;
        Widget? cellWidget = widget.rowsCellRenderer != null ? widget.rowsCellRenderer!(rowNumber, i, cells[i]) : null;
        if (cellWidget == null) {
          cellWidget = cells[i] is Widget ? cells[i] : Text(cells[i].toString(), style: _style);
        }
        return HoverContainer(
          cursor: (widget.hoverStatus != null) ? SystemMouseCursors.basic : SystemMouseCursors.click,
          height: widget.heightByRow != null ? widget.heightByRow!(rowNumber) : null,
          width: _getColumnWidth(i),
          alignment: widget.alignmentByRow != null ? widget.alignmentByRow!(rowNumber, i) : Alignment.centerLeft,
          decoration: widget.rowDecoration == null
              ? BoxDecoration(
                  color: widget.rowColor,
                  boxShadow: [BoxShadow(color: IdColors.gray)],
                  border: _makeBorder(
                    top: false,
                    left: false,
                    bottom: widget.internalGrid ? bottom : false,
                    right: widget.internalGrid ? right : false,
                    borderColor: widget.borderColor,
                  ))
              : null,
          child: Padding(padding: widget.rowCellsPadding, child: cellWidget),
        );
      },
    );
    return HoverContainer(
        cursor: (widget.hoverStatus != null) ? SystemMouseCursors.basic : SystemMouseCursors.click,
        height: widget.heightByRow != null ? widget.heightByRow!(rowNumber) - 1 : null,
        decoration: widget.rowDecoration,
        hoverDecoration: (widget.hoverColor != null)
            ? BoxDecoration(
                color: widget.hoverColor,
                boxShadow: [BoxShadow(color: IdColors.gray)],
                border: Border(
                  bottom: BorderSide(width: 1, color: IdColors.borderDefault),
                ),
              )
            : null,
        child: Row(
          //mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: cellWidgets,
        ));
  }

  ///Creates the border of the container for each cell
  Border _makeBorder({
    bool top = true,
    bool left = true,
    bool right = true,
    bool bottom = true,
    Color borderColor = Colors.black38,
    double width = 0.5,
  }) =>
      Border(
        left: left ? _border(borderColor, width) : BorderSide.none,
        top: top ? _border(borderColor, width) : BorderSide.none,
        right: right ? _border(borderColor, width) : BorderSide.none,
        bottom: bottom ? _border(borderColor, width) : BorderSide.none,
      );

  BorderSide _border([Color? color, double? width]) => BorderSide(color: color!, width: width!);

  ///Builds all the rows
  Widget _tableRows() {
    return ListView.separated(
      primary: false,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemCount: _data.length,
      separatorBuilder: (BuildContext context, int index) => Container(
        height: widget.rowInterval,
        color: widget.internalGrid ? widget.borderColor : Colors.transparent,
      ),
      itemBuilder: (ctx, index) => GestureDetector(
        onTap: () {
          widget.onRowClick != null ? widget.onRowClick!(index) : print(index);
        },
        child: _makeRow(
          _data[index],
          top: false,
          rowNumber: index,
        ),
      ),
    );
  }

  ///returns the width of each column by it's index
  double _getColumnWidth(int index) {
    return widget.columnWidthsPercentages.length >= widget.headerColumns!.length
        ? widget.columnWidthsPercentages[index] / 100 * widget.width
        : widget.width / widget.headerColumns!.length;
  }
}
