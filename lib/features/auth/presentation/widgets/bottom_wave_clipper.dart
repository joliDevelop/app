import 'package:flutter/material.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final p = Path();
    p.lineTo(0, 50);

    p.cubicTo(
      size.width * 0.22,
      10,
      size.width * 0.55,
      10,
      size.width * 0.78,
      40,
    );

    p.quadraticBezierTo(size.width * 0.90, 55, size.width, 58);

    p.lineTo(size.width, size.height);
    p.lineTo(0, size.height);
    p.close();

    return p;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}