import 'package:flutter/material.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Already have an account? ',
          style: TextStyle(color: Color(0xff8F92C2)),
        ),
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, '/sign-in');
          },
          child: const Text(
            'Sign In',
            style: TextStyle(
              color: Color(0xff6A5AE0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
