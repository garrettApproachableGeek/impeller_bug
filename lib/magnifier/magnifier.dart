import 'dart:ui';

import 'package:flutter/material.dart';

import 'magnifier_painter.dart';

// Based from: https://www.flutterclutter.dev/flutter/tutorials/widget-magnifier/2020/1638/
class CustomMagnifier extends StatefulWidget {
  const CustomMagnifier({
    required this.size,
    required this.child,
    super.key,
  });

  final Size size;
  final Widget child;

  @override
  CustomMagnifierState createState() => CustomMagnifierState();
}

class CustomMagnifierState extends State<CustomMagnifier> {
  double scale = 3.0; // Magnification Scale
  double topPadding = 10;
  Offset fingerPosition = Offset.zero;
  Size magnifierCircleSize = const Size(160, 160);
  bool showMagnifier = false;
  late double rightPadding;
  late Matrix4 matrix;

  @override
  void initState() {
    super.initState();
    rightPadding = (widget.size.width / 2);
    calculateMatrix();
  }

  @override
  Widget build(BuildContext context) {
    // Track finger position for Magnifier Tool
    return GestureDetector(
      onLongPressStart: (details) {
        setState(() {
          fingerPosition =
              Offset(details.globalPosition.dx, details.globalPosition.dy);
          showMagnifier = true;
        });
        calculateMatrix();
      },
      onLongPressMoveUpdate: (details) {
        setState(() {
          fingerPosition =
              Offset(details.globalPosition.dx, details.globalPosition.dy);
        });
        calculateMatrix();
      },
      child: Stack(
        children: [
          widget.child,
          if (showMagnifier) getMagnifier(context),
        ],
      ),
    );
  }

  void calculateMatrix() {
    double scaledX =
        fingerPosition.dx - ((widget.size.width + rightPadding) / 2 / scale);
    double scaledY =
        fingerPosition.dy - (magnifierCircleSize.height / 2 / scale);
    setState(() {
      matrix = Matrix4.identity()
        ..scale(scale, scale)
        ..translate(-scaledX, -scaledY);
    });
  }

  // BackdropFilter combined with ImageFilter is what causes the magnification to happen.
  Widget getMagnifier(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(rightPadding, topPadding, 0, 0),
      child: Align(
        alignment: Alignment.topCenter,
        child: ClipOval(
          child: BackdropFilter(
            filter: ImageFilter.matrix(matrix.storage),
            child: CustomPaint(
              painter: const MagnifierPainter(),
              size: magnifierCircleSize,
            ),
          ),
        ),
      ),
    );
  }
}
