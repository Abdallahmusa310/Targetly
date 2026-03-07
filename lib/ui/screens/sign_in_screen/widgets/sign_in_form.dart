import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/text_field.dart';

class SignInForm extends StatefulWidget {
  const SignInForm({super.key, required this.formKey});
  final Key formKey;

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SharedTextFeild(
            validator: (email) {
              if (email == null || email.isEmpty) {
                return "Enter your email";
              }
              return null;
            },
            obscureText: false,
            hintText: "Email",
            hintStyle: const TextStyle(color: Color(0xff8F92C2)),
            prefixIcon: const Icon(Icons.person, color: Color(0xff969ACA)),
          ),

          const SizedBox(height: 12),

          SharedTextFeild(
            validator: (password) {
              if (password == null || password.isEmpty) {
                return "Enter password";
              }
              return null;
            },
            suffixIcon: IconButton(
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Color(0xff969ACA),
              ),
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
            ),
            obscureText: true,
            hintText: "Password",
            hintStyle: const TextStyle(color: Color(0xff8F92C2)),
            prefixIcon: const Icon(Icons.lock, color: Color(0xff969ACA)),
          ),
        ],
      ),
    );
  }
}
