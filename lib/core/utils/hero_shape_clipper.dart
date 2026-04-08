import 'package:flutter/material.dart';

class HeroShapeClipper extends CustomClipper<Path> {
  final double progress; 

  HeroShapeClipper(this.progress);

  @override
  Path getClip(Size size) {
    final path = Path();
  
    double startRadius = 16.0;
    double endRadius = size.width / 2;
    double currentRadius = startRadius + (endRadius - startRadius) * progress;

    path.addRRect(RRect.fromRectAndRadius(
      Rect.fromLTWH(0, 0, size.width, size.height),
      Radius.circular(currentRadius),
    ));
    
    return path;
  }

  @override
  bool shouldReclip(HeroShapeClipper oldClipper) => oldClipper.progress != progress;
}