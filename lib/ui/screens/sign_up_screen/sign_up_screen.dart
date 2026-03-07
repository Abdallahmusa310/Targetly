import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/ui/screens/sign_in_screen/widgets/header.dart';
import 'package:targetly/ui/screens/sign_up_screen/widgets/sign_up_form.dart';
import 'package:targetly/ui/screens/sign_up_screen/widgets/sign_up_prompt.dart';
import 'package:targetly/ui/shared/boutton.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final AuthService authService = AuthService();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 80),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xff2B1E5E),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Sign up to get started',
                      style: TextStyle(fontSize: 16, color: Color(0xff8F92C2)),
                    ),
                    const SizedBox(height: 16),
                    SignUpForm(
                      formKey: formKey,
                      emailcontroller: emailController,
                      passwordcontroller: passwordController,
                    ),
                    const SizedBox(height: 30),
                    InkWell(
                      child: Sharedboutton(text: 'Create Account'),
                      onTap: () async {
                        if (formKey.currentState!.validate()) {
                          try {
                            await authService.signUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            Navigator.pushNamed(context, '/navigation');
                          } on FirebaseAuthException catch (e) {
                            if (e.code == 'weak-password') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Password is too weak'),
                                ),
                              );
                            } else if (e.code == 'email-already-in-use') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Email already exists'),
                                ),
                              );
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        }
                      },
                    ),
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
