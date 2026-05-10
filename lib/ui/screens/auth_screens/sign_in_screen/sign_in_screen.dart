import 'package:flutter/material.dart';
import 'package:targetly/core/animations/homescreenanimation.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/widgets/sign_in_body.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/widgets/sign_in_form.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/widgets/header.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/widgets/sign_in_prompt.dart';
import 'package:targetly/ui/shared/boutton.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
              Staggeredwidget(index: 0, animate: true, child: const Header()),
              const SizedBox(height: 130),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    Staggeredwidget(
                      index: 1,
                      animate: true,
                      child: SignInBody(),
                    ),
                    const SizedBox(height: 16),
                    Staggeredwidget(
                      index: 3,
                      animate: true,
                      child: SignInForm(
                        formKey: formKey,
                        emailcontroller: emailController,
                        passwordcontroller: passwordController,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Staggeredwidget(
                      index: 4,
                      animate: true,
                      child: Sharedboutton(
                        text: 'Sign In',
                        onTap: () async {
                          try {
                            if (formKey.currentState!.validate()) {
                              final user = await AuthService().signIn(
                                email: emailController.text.trim(),
                                password: passwordController.text.trim(),
                              );
                              if (!context.mounted) return;
                              if (user != null) {
                                await HiveManager.openUserBoxes();
                                HiveManager.saveUsername(
                                  user.displayName ??
                                      emailController.text.trim().split('@')[0],
                                );

                                Navigator.pushReplacementNamed(
                                  context,
                                  '/navigation',
                                );
                              }
                            }
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.toString())),
                            );
                          }
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    Staggeredwidget(
                      index: 5,
                      animate: true,
                      child: SignInPrompt(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
