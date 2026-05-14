import 'package:flutter/material.dart';

class Staggeredwidget extends StatefulWidget {
  final Widget child;
  final int index;
  final bool animate;

  const Staggeredwidget({
    super.key,
    required this.child,
    required this.index,
    required this.animate,
  });

  @override
  State<Staggeredwidget> createState() => _StaggeredwidgetState();
}

class _StaggeredwidgetState extends State<Staggeredwidget>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> offset;

  bool _hasStarted = false;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
      value: 0.01,
    );

    opacity = Tween<double>(begin: 0, end: 1).animate(controller);

    offset = Tween<Offset>(
      begin: const Offset(0, 0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    if (widget.animate) {
      _hasStarted = true;
      Future.delayed(Duration(milliseconds: 100 * widget.index), () {
        if (mounted) controller.forward();
      });
    } else {
      controller.value = 1.0;
    }
  }

  @override
  void didUpdateWidget(covariant Staggeredwidget oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (widget.animate && !_hasStarted) {
      _hasStarted = true;
      Future.delayed(Duration(milliseconds: 100 * widget.index), () {
        if (mounted) controller.forward();
      });
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.animate && !_hasStarted) {
      return widget.child;
    }

    return FadeTransition(
      opacity: opacity,
      child: SlideTransition(position: offset, child: widget.child),
    );
  }
}
