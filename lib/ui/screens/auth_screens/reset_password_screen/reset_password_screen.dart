import 'package:flutter/material.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/widgets/header.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Header(),
              SizedBox(height: 120),
              Padding(
                padding: const EdgeInsets.all(18),
                child: Column(
                  children: [
                    Text(
                      'enter your email to reset your password',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Form(
                      key: formKey,
                      child: SharedTextFeild(
                        controller: emailController,
                        hintText: 'email',
                        prefixIcon: Icon(Icons.email),
                        obscureText: false,
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
                    ),
                    SizedBox(height: 16),
                    InkWell(
                      onTap: () async {
                        try {
                          if (formKey.currentState!.validate()) {
                            await AuthService().resetPassword(
                              email: emailController.text.trim(),
                            );
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text("Password reset email sent"),
                              ),
                            );
                          }
                        } catch (e) {
                          ScaffoldMessenger.of(
                            context,
                          ).showSnackBar(SnackBar(content: Text(e.toString())));
                        }
                      },
                      child: Sharedboutton(text: 'Reset Password'),
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
}
