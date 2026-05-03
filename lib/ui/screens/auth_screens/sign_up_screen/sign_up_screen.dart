import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/widgets/header.dart';
import 'package:targetly/ui/screens/auth_screens/sign_up_screen/widgets/sign_up_form.dart';
import 'package:targetly/ui/screens/auth_screens/sign_up_screen/widgets/sign_up_prompt.dart';
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
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

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
                      nameController: nameController,
                    ),
                    const SizedBox(height: 30),

                    /// زر التسجيل
                    Sharedboutton(
                      text: 'Create Account',
                      onTap: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            final user = await authService.signUp(
                              email: emailController.text.trim(),
                              password: passwordController.text.trim(),
                            );

                            if (user != null) {
                              final name = nameController.text.trim();

                              if (name.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Name cannot be empty"),
                                  ),
                                );
                                return;
                              }

                              await user.updateDisplayName(name);
                              HiveManager.saveUsername(name);

                              if (!context.mounted) return;
                              await HiveManager.openUserBoxes(); // ← أضفها هنا

                              Navigator.pushReplacementNamed(
                                context,
                                '/navigation',
                              );
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Sign up failed")),
                              );
                            }
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
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
