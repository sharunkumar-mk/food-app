import 'package:flutter/material.dart';

class TriangularClipContainer extends StatelessWidget {
  const TriangularClipContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
        clipper: TriangularClipper(),
        child: Container(
          width: 100.0,
          height: 100.0,
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius:
                BorderRadius.circular(10.0), // Adjust the radius as needed
          ),
          child: const Center(
            child: Text(
              'Your Content',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}

class TriangularClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.moveTo(size.width / 2, 0.0); // Top point
    path.lineTo(size.width, size.height); // Bottom right point
    path.lineTo(0.0, size.height); // Bottom left point
    path.close(); // Close the path to create a triangle
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
