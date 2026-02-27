import 'package:flutter/material.dart';

class SharedTextFeild extends StatelessWidget {
  const SharedTextFeild({
    super.key,
    required this.hintText,
    required this.prefixIcon,
  });
  final String hintText;
  final Widget prefixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        hintText: hintText,
        prefixIcon: prefixIcon,

        filled: true,
        fillColor: Colors.white,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300, width: 1),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF5B5F97), width: 1.5),
        ),
      ),
    );
  }
}
