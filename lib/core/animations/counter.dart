import 'package:flutter/material.dart';

class AnimatedCounter extends StatelessWidget {
  final double value;
  final Duration duration;
  final TextStyle? style;

  const AnimatedCounter({
    super.key,
    required this.value,
    this.duration = const Duration(milliseconds: 800),
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: value),
      duration: duration,
      builder: (context, val, child) {
        return Text(val.toStringAsFixed(0), style: style);
      },
    );
  }
}
