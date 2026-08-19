import 'package:flutter/material.dart';

class Sharedboutton extends StatelessWidget {
  const Sharedboutton({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.width,
    this.height,
    this.isLoading = false,
  });
  final String text;
  final double? width, height, borderRadius;
  final void Function()? onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isLoading ? null : onTap,
      child: Container(
        height: height ?? 50,
        width: width ?? 200,
        decoration: BoxDecoration(
          color: const Color(0xff9367FA),
          borderRadius: BorderRadius.circular(borderRadius ?? 30),
        ),
        child: Center(
          child: isLoading
              ? const SizedBox(
                  width: 22,
                  height: 22,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2.5,
                  ),
                )
              : Text(
                  text,
                  style: const TextStyle(
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
