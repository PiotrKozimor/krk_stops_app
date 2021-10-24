import 'package:flutter/material.dart';

class CircleColor extends StatelessWidget {
  static const double _kColorElevation = 4.0;

  final Color color;
  final VoidCallback onColorChoose;
  final double circleSize;
  final double elevation;

  const CircleColor({
    Key? key,
    required this.color,
    required this.circleSize,
    required this.onColorChoose,
    this.elevation = _kColorElevation,
  })  : assert(circleSize >= 0, "You must provide a positive size"),
        super(key: key);

  @override
  Widget build(BuildContext _) {
    return GestureDetector(
      onTap: onColorChoose,
      child: Material(
        elevation: elevation,
        shape: const CircleBorder(),
        child: CircleAvatar(
          radius: circleSize / 2,
          backgroundColor: color,
        ),
      ),
    );
  }
}
