import 'package:flutter/material.dart';
import 'dart:math' as math;

class CircularPainter extends CustomPainter {
  CircularPainter(
      {super.repaint,
      this.imagePaths,
      this.color = Colors.red,
      this.paintingStyle = PaintingStyle.stroke});

  final Color color;
  final PaintingStyle paintingStyle;
  final List<String>? imagePaths;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = paintingStyle;

    final circleCenter = Offset(size.width * 0.5, size.height * 0.5);
    final circleRadius = size.width * 0.5;
    canvas.drawCircle(circleCenter, circleRadius, paint);

    canvas.drawCircle(circleCenter, circleRadius, paint);

    // Calculate the positions for placing images around the circumference of the circle
    final numberOfImages = imagePaths!.length;
    final double angleStep = (2 * math.pi) / numberOfImages;

    for (int i = 0; i < numberOfImages; i++) {
      final angle = i * angleStep;

      // Calculate the position of the image on the circle
      final imageX = circleCenter.dx + circleRadius * math.cos(angle);
      final imageY = circleCenter.dy + circleRadius * math.sin(angle);

      final imageOffset = Offset(imageX, imageY);
      drawImage(canvas, imageOffset, imagePaths![i]);
    }
  }

  void drawImage(Canvas canvas, Offset imageOffset, String imagePath) async {}

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
