import 'package:flutter/material.dart';

class MagnifierPainter extends CustomPainter {
  const MagnifierPainter({
    this.strokeWidth = 5,
  });

  final double strokeWidth;

  @override
  void paint(Canvas canvas, Size size) {
    _drawCircle(canvas, size);
    _drawCrosshair(canvas, size);
  }

  void _drawCircle(Canvas canvas, Size size) {
    Paint paintObject = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..color = Colors.blue;

    canvas.drawCircle(
      size.center(const Offset(0, 0)),
      size.longestSide / 2,
      paintObject,
    );
  }

  void _drawCrosshair(Canvas canvas, Size size) {
    Paint plusPaint = Paint()
      ..strokeWidth = strokeWidth / 3
      ..color = Colors.black;

    Paint squarePaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth / 3
      ..color = Colors.red;

    canvas.drawRect(
      size.center(const Offset(-10, -10)) & const Size(20, 20),
      squarePaint,
    );

    double crossSize = size.longestSide * 0.03;
    canvas.drawLine(
      size.center(Offset(-crossSize, 0)),
      size.center(Offset(crossSize, 0)),
      plusPaint,
    );
    canvas.drawLine(
      size.center(Offset(0, -crossSize)),
      size.center(Offset(0, crossSize)),
      plusPaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
