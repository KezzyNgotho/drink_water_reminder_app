// TODO Implement this library.
// water_progress.dart

import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double percentage;
  final double target;

  WaterProgressPainter({required this.percentage, required this.target});

  @override
  void paint(Canvas canvas, Size size) {
    Paint bgPaint = Paint()
      ..color = Colors.grey.withOpacity(0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0;

    Paint progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 20.0;

    Rect rect = Rect.fromCircle(
      center: Offset(size.width / 2, size.height / 2),
      radius: size.width / 2 - 10,
    );

    canvas.drawCircle(rect.center, rect.width / 2, bgPaint);
    double sweepAngle = 360 * percentage;
    canvas.drawArc(rect, -90.0 * (3.1415926535 / 180), sweepAngle * (3.1415926535 / 180), false, progressPaint);

    TextPainter textPainter = TextPainter(
      text: TextSpan(
        text: '${(percentage * target).toInt()}ml / ${target.toInt()}ml',
        style: TextStyle(color: Colors.black, fontSize: 16.0),
      ),
      textDirection: TextDirection.ltr,
    );
    textPainter.layout(minWidth: 0, maxWidth: size.width);
    textPainter.paint(canvas, Offset(size.width / 2 - textPainter.width / 2, size.height / 2 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
