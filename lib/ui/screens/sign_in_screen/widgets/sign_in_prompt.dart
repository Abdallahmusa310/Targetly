import 'package:flutter/material.dart';

class SignInPrompt extends StatelessWidget {
  const SignInPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text(
          'Forget Password?',
          style: TextStyle(
            color: Color(0xff2B1E5E),
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              'Don\'t have an account? ',
              style: TextStyle(color: Color(0xff8F92C2)),
            ),
            Text(
              'Sign Up',
              style: TextStyle(
                color: Color(0xff6A5AE0),
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
