import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/sign_in_screen/widgets/header.dart';
import 'package:targetly/ui/screens/sign_up_screen/widgets/sign_up_form.dart';
import 'package:targetly/ui/screens/sign_up_screen/widgets/sign_up_prompt.dart';
import 'package:targetly/ui/shared/boutton.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 100),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Hello',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2B1E5E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please sign up ',
                      style: TextStyle(fontSize: 16, color: Color(0xff8F92C2)),
                    ),
                    SignUpForm(),
                    const SizedBox(height: 16),

                    const SizedBox(height: 16),
                    Sharedboutton(text: 'Sign Up'),
                    const SizedBox(height: 20),
                    const SignUpPrompt(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
