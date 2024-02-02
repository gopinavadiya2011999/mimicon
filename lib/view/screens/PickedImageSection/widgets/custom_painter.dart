import 'dart:math';

import 'package:flutter/material.dart';

class EyePainter extends CustomPainter {
  final Point<int> point;
  final Color color;
  final double radius;


  EyePainter({required this.point, required this.color,required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawCircle(Offset(point.x.toDouble(), point.y.toDouble()), radius, paint);
  }

  @override
  bool shouldRepaint(EyePainter oldDelegate) =>
      oldDelegate.point != point || oldDelegate.color != color;
}

class MouthPainter extends CustomPainter {
  final Point<int> point;
  final Color color;
  final double radius;

  MouthPainter({required this.point, required this.color,required this.radius});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    canvas.drawOval(Rect.fromCenter(center: Offset(point.x.toDouble(), point.y.toDouble()), width: radius*4,height: 40), paint);
  }

  @override
  bool shouldRepaint(MouthPainter oldDelegate) =>
      oldDelegate.point != point || oldDelegate.color != color;
}


