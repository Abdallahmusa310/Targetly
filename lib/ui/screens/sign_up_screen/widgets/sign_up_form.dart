import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/text_field.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          SharedTextFeild(
            hintText: "Email",
            hintStyle: const TextStyle(color: Color(0xff8F92C2)),
            prefixIcon: const Icon(Icons.person, color: Color(0xff969ACA)),
          ),

          const SizedBox(height: 12),

          SharedTextFeild(
            hintText: "Password",
            hintStyle: const TextStyle(color: Color(0xff8F92C2)),
            prefixIcon: const Icon(Icons.lock, color: Color(0xff969ACA)),
          ),
          const SizedBox(height: 12),
          SharedTextFeild(
            hintText: "Confirm Password",
            hintStyle: const TextStyle(color: Color(0xff8F92C2)),
            prefixIcon: const Icon(Icons.lock, color: Color(0xff969ACA)),
          ),
        ],
      ),
    );
  }
}
