import 'package:flutter/material.dart';

class TriangleButton extends StatelessWidget {
  final VoidCallback onPressed;

  const TriangleButton({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: TriangleButtonPainter(),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
            onTap: onPressed,
            borderRadius: BorderRadius.zero // Ensure sharp corners
            ),
      ),
    );
  }
}

class TriangleButtonPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    // Draw the yellow triangle background
    final paint = Paint()
      ..color = Colors.yellow
      ..style = PaintingStyle.fill;
    canvas.drawPath(getTrianglePath(size), paint);

    // Draw the arrow
    final arrowPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;
    canvas.drawPath(getArrowPath(size), arrowPaint);
  }

  @override
  bool shouldRepaint(TriangleButtonPainter oldDelegate) => false;

  Path getTrianglePath(Size size) {
    return Path()
      ..moveTo(size.width / 2, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
  }

  Path getArrowPath(Size size) {
    const arrowWidth = 15.0;
    const arrowHeight = 10.0;
    const arrowOffset = 5.0;

    return Path()
      ..moveTo(
          size.width / 2 - arrowWidth / 2, size.height / 2 - arrowHeight / 2)
      ..lineTo(size.width / 2, size.height / 2 + arrowOffset)
      ..lineTo(
          size.width / 2 + arrowWidth / 2, size.height / 2 - arrowHeight / 2);
  }
}
