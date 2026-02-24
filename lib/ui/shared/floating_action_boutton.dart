import 'package:flutter/material.dart';

class SharedFloatingActionButton extends StatelessWidget {
  const SharedFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.lable,
    this.tooltip,
  });
  final VoidCallback onPressed;
  final Widget lable;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      tooltip: tooltip,
      onPressed: onPressed,
      label: lable,
    );
  }
}
