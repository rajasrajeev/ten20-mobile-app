import 'package:flutter/material.dart';

class HeartPainter extends CustomPainter {
  final Color color;

  HeartPainter(this.color);
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color // Light purple color
      ..style = PaintingStyle.fill;

    Path path = Path();

    double width = size.width;
    double height = size.height;

    // Start at the bottom center
    path.moveTo(width / 2, height * 0.75);

    // Left bulkier and wider curve
    path.cubicTo(
      width * -0.1,
      height * 0.4, // Bulkier control point moved more left and up
      width * 0.3,
      height * -0.05, // Wider curve to the top left
      width / 2,
      height * 0.25, // End point of the left curve
    );

    // Right bulkier and wider curve
    path.cubicTo(
      width * 0.7,
      height * -0.05, // Wider curve to the top right
      width * 1.1,
      height * 0.4, // Bulkier control point moved more right and up
      width / 2,
      height * 0.75, // End point of the right curve (meeting at the bottom)
    );

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
