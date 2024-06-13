import 'package:unionCDPP/id_widget/IdColor.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:unionCDPP/id_widget/IdImageBox1.dart';
// import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

typedef IdPaginationItemBuilder = Widget Function(
    BuildContext context, int page, ButtonType type, bool existLess, bool existMore, VoidCallback onPressed);

class IdPaginationButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IdPaginationItemBuilder idPaginationItemBuilder;
  final int page;
  final bool existLess;
  final bool existMore;

  const IdPaginationButton(
      {Key? key,
      required this.onPressed,
      required this.idPaginationItemBuilder,
      required this.page,
      required this.existLess,
      required this.existMore})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return idPaginationItemBuilder(context, page, ButtonType.normal, existLess, existMore, onPressed);
  }
}

class PageToDrawData {
  final List<int>? list;
  final bool existLess;
  final bool existMore;

  PageToDrawData({this.list, required this.existLess, required this.existMore});
}

class ButtonTheme extends InheritedWidget {
  ButtonTheme({
    Key? key,
    required this.child,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonFontSize = 16,
    this.disableButton = false,
  }) : super(key: key, child: child);

  final Widget child;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final bool disableButton;
  final double? buttonFontSize;

  static ButtonTheme? of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<ButtonTheme>();
  }

  @override
  bool updateShouldNotify(ButtonTheme oldWidget) {
    return true;
  }
}

enum ButtonType { go_to_start, minus, plus, go_to_end, normal }

IdPaginationItemBuilder defaultPaginationButton = (context, page, type, existLess, existMore, onPressed) {
  final bTheme = ButtonTheme.of(context);
  final color = bTheme!.buttonColor ?? Theme.of(context).primaryColor;
  final textColor = bTheme.buttonTextColor ?? IdColors.white;
  final disabled = bTheme.disableButton;
  Widget childItem1 = AutoSizeText("$page",
      minFontSize: 8,
      maxLines: 1,
      style: TextStyle(
          fontWeight: disabled ? FontWeight.bold : FontWeight.normal,
          color: textColor,
          textBaseline: TextBaseline.ideographic,
          fontSize: 18),
      softWrap: true);

  // GV.d(page,childItem1);

  // Text("$page",
  //     style: TextStyle(
  //         fontSize: bTheme.buttonFontSize,
  //         fontWeight: disabled ? FontWeight.bold : FontWeight.normal,
  //         color: textColor,
  //         textBaseline: TextBaseline.ideographic),
  //     textAlign: TextAlign.start);

  if (type == ButtonType.go_to_start) {
    childItem1 = IdImageBox(imageWidth: 34, imageHeight: 34, imagePath: 'assets/img/icon_moveStart.png', imageFit: BoxFit.cover);
  } else if (type == ButtonType.go_to_end) {
    childItem1 = IdImageBox(imageWidth: 34, imageHeight: 34, imagePath: 'assets/img/icon_moveEnd.png', imageFit: BoxFit.cover);
  } else if (type == ButtonType.minus) {
    childItem1 = IdImageBox(imageWidth: 34, imageHeight: 34, imagePath: 'assets/img/icon_moveBefore.png', imageFit: BoxFit.cover);
  } else if (type == ButtonType.plus) {
    childItem1 = IdImageBox(imageWidth: 34, imageHeight: 34, imagePath: 'assets/img/icon_moveNext.png', imageFit: BoxFit.cover);
  }

  page = page < 0 ? 0 : page;
  bool isBtn = childItem1.runtimeType.toString() == 'ExtendedImage';
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 4),
    child: Container(
      width: 34,
      height: 34,
      margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
      decoration: isBtn ? BoxDecoration(color: color) : null,
      alignment: Alignment.topCenter,
      child: Ink(
        child: TextButton(
          onPressed: () {
            if (type == ButtonType.minus && !existLess) onPressed();
            if (type == ButtonType.plus && !existMore) onPressed();
            if (!disabled) onPressed();
          },
          child: childItem1,
        ),
      ),
    ),
  );
};

class IdPaginationWidget extends StatelessWidget {
  final int actualPage;
  final int totalPages;
  final int countToDisplay;
  final IdPaginationItemBuilder? idPaginationItemBuilder;
  final Color? buttonColor;
  final Color? buttonTextColor;
  final double? buttonFontSize;
  final ValueChanged onPageChange;
  //API가 없어서 임시로 안에서 돌아가게 만들기위해 넣어둔 변수
  final ValueChanged moveToBefore;
  final ValueChanged moveToNext;

  const IdPaginationWidget({
    Key? key,
    required this.actualPage,
    required this.totalPages,
    required this.countToDisplay,
    required this.onPageChange,
    this.buttonColor,
    this.buttonTextColor,
    this.buttonFontSize,
    this.idPaginationItemBuilder,
    //API가 없어서 임시로 안에서 돌아가게 만들기위해 넣어둔 변수
    required this.moveToBefore,
    required this.moveToNext,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        buttonTextColor: buttonTextColor,
        buttonFontSize: buttonFontSize,
        buttonColor: buttonColor,
        child: Builder(builder: (context) {
          final builder = idPaginationItemBuilder ?? defaultPaginationButton;
          final drawData = pagesToDraw(context, true);
          List<Widget> pageButtons = [];
          pageButtons.addAll(drawData.list!.map((e) {
            final item1 = Container(
              decoration: BoxDecoration(
                color: (e == actualPage) ? IdColors.black : Color.fromRGBO(0, 0, 0, 0),
                shape: BoxShape.circle,
              ),
              child: IdPaginationButton(
                  onPressed: () {
                    goToPage(context, e);
                  },
                  idPaginationItemBuilder: builder,
                  existLess: drawData.existLess,
                  existMore: drawData.existMore,
                  page: e),
            );

            if (e == actualPage) {
              return ButtonTheme(
                buttonColor: IdColors.black,
                buttonFontSize: buttonFontSize,
                buttonTextColor: IdColors.white,
                disableButton: true,
                child: item1,
              );
            }
            return item1;
          }).toList());
          return Row(mainAxisAlignment: MainAxisAlignment.start, crossAxisAlignment: CrossAxisAlignment.center, children: [
            if (totalPages >= 1)
              builder(context, -1, ButtonType.minus, drawData.existLess, drawData.existMore, () {
                goToMinus(context, drawData);
              }),
            for (var b in pageButtons) b,
            if (totalPages >= 1)
              builder(context, -1, ButtonType.plus, drawData.existLess, drawData.existMore, () {
                goToPlus(context, drawData);
              }),
          ]);
        }));
  }

  PageToDrawData pagesToDraw(BuildContext context, bool makeList) {
    int _firstPage = 1;

    _firstPage = (((actualPage - 1) ~/ countToDisplay) * countToDisplay).toInt() + 1;

    if (_firstPage > actualPage) {
      _firstPage = actualPage;
    }
    var remain1 = totalPages % countToDisplay;
    List<int> list = List.generate(
        _firstPage + countToDisplay < totalPages
            ? countToDisplay
            : remain1 == 0
                ? countToDisplay
                : remain1,
        (index) => index + _firstPage).toList();
    if (list.length > totalPages) {
      list = List.generate(totalPages, (index) => index + 1);
    }
    return PageToDrawData(list: list, existLess: _firstPage > 1, existMore: (_firstPage + countToDisplay) < totalPages);
  }

  void goToStart(BuildContext context) {
    goToPage(context, 1);
  }

  void goToMinus(BuildContext context, PageToDrawData drawData) {
    if (drawData.list![0] % countToDisplay == 1) {
      goToPage(context, drawData.list![0] - 1);
    }
    goToPage(context, drawData.list![0] - countToDisplay);
  }

  void goToPlus(BuildContext context, PageToDrawData drawData) {
    goToPage(context, drawData.list![0] + countToDisplay);
  }

  void goToEnd(BuildContext context) {
    goToPage(context, totalPages);
  }

  void goToPage(BuildContext context, int page) {
    if (page > totalPages) {
      page = totalPages;
    } else if (page < 1) {
      page = 1;
    }
    onPageChange(page);
  }
}
