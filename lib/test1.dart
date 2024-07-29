import 'dart:math' as math;
import 'package:flutter/material.dart';

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        body: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Container(
              width: 100.0,
              height: 100.0,
              color: Colors.blue,
            ),
          ),
        ),
      ),
    ),
  );
}

class PolygonPainter extends CustomPainter {
  final int sides;

  PolygonPainter(this.sides);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.blue
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    final path = Path();
    final angle = (math.pi * 2) / sides;

    Offset center = Offset(size.width / 2, size.height / 2);
    Offset startPoint = Offset(size.width / 2, 0);

    path.moveTo(startPoint.dx, startPoint.dy);

    for (int i = 1; i <= sides; i++) {
      final double x = center.dx + size.width / 2 * math.cos(angle * i);
      final double y = center.dy + size.height / 2 * math.sin(angle * i);
      path.lineTo(x, y);
    }
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
