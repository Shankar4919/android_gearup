import 'package:flutter/material.dart';

class CircleGearUp extends StatelessWidget {
  final double radius;
  final Color color;
  final Widget child;

  CircleGearUp(
      {this.radius = 60.0,
      this.color = const Color(0xff16b13a),
      required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
        height: radius,
        width: radius,
        decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        child: child);
  }
}
