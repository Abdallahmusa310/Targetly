import 'package:flutter/material.dart';

class SharedTextFeild extends StatelessWidget {
  const SharedTextFeild({
    super.key,
    required this.hintText,
    required this.prefixIcon,
    required this.obscureText,
    this.hintStyle,
    this.suffixIcon,
    this.validator,
    this.controller,
  });

  final String hintText;
  final Widget? suffixIcon;
  final Widget prefixIcon;
  final TextStyle? hintStyle;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final bool obscureText;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: hintStyle,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,

        filled: true,
        fillColor: Color(0xffF3F3FC),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Color(0xffF3F3FC), width: 1),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Color(0xFF5B5F97), width: 2),
        ),
      ),
    );
  }
}
