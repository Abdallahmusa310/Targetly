import 'package:flutter/material.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          'Targetly',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff2B1E5E),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Your Targets, Simplified',
          style: TextStyle(fontSize: 16, color: Color(0xff8F92C2)),
        ),
        SizedBox(height: 40),
        Text(
          'Create Account',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff2B1E5E),
          ),
        ),
        SizedBox(height: 8),
        Text(
          'Sign up to get started',
          style: TextStyle(fontSize: 16, color: Color(0xff8F92C2)),
        ),
      ],
    );
  }
}
