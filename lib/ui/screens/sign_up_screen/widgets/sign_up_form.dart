import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.emailcontroller,
    required this.passwordcontroller,
  });
  final Key formKey;
  final TextEditingController? emailcontroller;
  final TextEditingController? passwordcontroller;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          /// Full Name
          SharedTextFeild(
            obscureText: false,
            hintText: "Full Name",
            prefixIcon: const Icon(Icons.person, color: Color(0xff969ACA)),
            validator: (fullname) {
              if (fullname == null || fullname.isEmpty) {
                return "Please enter your name";
              }
              if (fullname.length < 3) {
                return "Name must be at least 3 characters";
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          /// Email
          SharedTextFeild(
            controller: widget.emailcontroller,
            obscureText: false,
            hintText: "Email",
            prefixIcon: const Icon(Icons.email, color: Color(0xff969ACA)),
            validator: (email) {
              if (email == null || email.isEmpty) {
                return "Enter your email";
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                return "Enter valid email";
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          /// Password
          SharedTextFeild(
            obscureText: !isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isPasswordVisible = !isPasswordVisible;
                });
              },
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: Color(0xff969ACA),
              ),
            ),
            hintText: "Password",

            prefixIcon: const Icon(Icons.lock, color: Color(0xff969ACA)),
            controller: widget.passwordcontroller,
            validator: (password) {
              if (password == null || password.isEmpty) {
                return "Enter password";
              }
              if (password.length < 6) {
                return "Password must be at least 6 characters";
              }
              return null;
            },
          ),

          const SizedBox(height: 12),

          /// Confirm Password
          SharedTextFeild(
            hintText: "Confirm Password",
            obscureText: !isConfirmPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isConfirmPasswordVisible = !isConfirmPasswordVisible;
                });
              },
              icon: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: Color(0xff969ACA),
              ),
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xff969ACA),
            ),
            validator: (confirmPassword) {
              if (confirmPassword == null || confirmPassword.isEmpty) {
                return "Please confirm your password";
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
