import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/sign_in_screen/widgets/sign_in_form.dart';
import 'package:targetly/ui/screens/sign_in_screen/widgets/header.dart';
import 'package:targetly/ui/screens/sign_in_screen/widgets/sign_in_prompt.dart';
import 'package:targetly/ui/shared/boutton.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
                      'Welcome Back!',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2B1E5E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Please sign in to continue',
                      style: TextStyle(fontSize: 16, color: Color(0xff8F92C2)),
                    ),
                    const SizedBox(height: 16),
                    SignInForm(formKey: formKey),
                    const SizedBox(height: 30),
                    InkWell(
                      child: Sharedboutton(text: 'Sign In'),
                      onTap: () {
                        if (formKey.currentState!.validate()) {
                          Navigator.pushNamed(context, '/navigation');
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    SignInPrompt(),
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
