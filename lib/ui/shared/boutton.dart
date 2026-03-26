import 'package:flutter/material.dart';

class Sharedboutton extends StatelessWidget {
  const Sharedboutton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.width,
    this.height,
  });
  final String text;
  final double? width, height, borderRadius;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? 200,
        decoration: BoxDecoration(
          color: Color(0xff9367FA),
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
