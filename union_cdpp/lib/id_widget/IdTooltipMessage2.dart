import 'package:flutter/material.dart';
import 'package:unionCDPP/common/uiCommon.dart';
import 'package:unionCDPP/id_widget/IdColor.dart';

class IdTooltipMessage2 extends StatefulWidget {
  final Color background;
  final String tooltipMessage;
  const IdTooltipMessage2({super.key, required this.background, required this.tooltipMessage});

  @override
  State<IdTooltipMessage2> createState() => _IdTooltipMessage2State();
}

class _IdTooltipMessage2State extends State<IdTooltipMessage2> {
  @override
  Widget build(BuildContext context) {
    Widget wg1 = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 184,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(color: widget.background, borderRadius: BorderRadius.circular(8)),
          child: uiCommon.styledText(widget.tooltipMessage, 14, -0.28, 1, FontWeight.w400, IdColors.white, TextAlign.left),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 32.93),
          child: Container(
            width: 14,
            height: 7,
            child: CustomPaint(
              painter: (widget.background == IdColors.green2) ? TrianglePainter1() : TrianglePainter2(),
            ),
          ),
        )
      ],
    );
    return wg1;
  }
}

class TrianglePainter1 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = IdColors.green2
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0); // 삼각형의 왼쪽 아래 모서리
    path.lineTo(size.width / 2, size.height); // 삼각형의 꼭대기
    path.lineTo(size.width, 0); // 삼각형의 오른쪽 아래 모서리
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

class TrianglePainter2 extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = IdColors.black80Per
      ..style = PaintingStyle.fill;

    final path = Path();
    path.moveTo(0, 0); // 삼각형의 왼쪽 아래 모서리
    path.lineTo(size.width / 2, size.height); // 삼각형의 꼭대기
    path.lineTo(size.width, 0); // 삼각형의 오른쪽 아래 모서리
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
