import 'dart:math';
import 'package:flutter/material.dart';

class WaterProgressPainter extends CustomPainter {
  final double percentage;
  final double target;

  WaterProgressPainter({required this.percentage, required this.target});

  @override
  void paint(Canvas canvas, Size size) {
    Paint backgroundPaint = Paint()
      ..color = Colors.grey[300]!
      ..style = PaintingStyle.fill;

    Paint progressPaint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.fill;

    double radius = size.width / 2;
    double centerX = size.width / 2;
    double centerY = size.height / 2;

    // Draw background circle
    canvas.drawCircle(Offset(centerX, centerY), radius, backgroundPaint);

    // Draw progress arc
    double startAngle = -pi / 2;
    double sweepAngle = 2 * pi * percentage;

    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      sweepAngle,
      true,
      progressPaint,
    );

    // Draw target line
    Paint targetLinePaint = Paint()
      ..color = Colors.red
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    double targetAngle = 2 * pi * target;
    canvas.drawArc(
      Rect.fromCircle(center: Offset(centerX, centerY), radius: radius),
      startAngle,
      targetAngle,
      false,
      targetLinePaint,
    );
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
