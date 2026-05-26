import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/data/firebase/auth_service.dart';
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
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('reset_password'.tr()),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),

                // Icon
                Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/targetlyicon.png',
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                const SizedBox(height: 32),

                Text(
                  'reset_password_title'.tr(),
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Color(0xff2B1E5E),
                  ),
                ),

                const SizedBox(height: 8),

                Text(
                  'reset_password_subtitle'.tr(),
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xff8F92C2),
                  ),
                ),

                const SizedBox(height: 32),

                Form(
                  key: formKey,
                  child: SharedTextFeild(
                    controller: emailController,
                    hintText: 'email'.tr(),
                    prefixIcon: const Icon(
                      Icons.email,
                      color: Color(0xff969ACA),
                    ),
                    obscureText: false,
                    validator: (email) {
                      if (email == null || email.isEmpty) {
                        return 'enter_email'.tr();
                      }
                      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                        return 'valid_email'.tr();
                      }
                      return null;
                    },
                  ),
                ),

                const SizedBox(height: 24),

                Sharedboutton(
                  text: 'reset_password'.tr(),
                  onTap: () async {
                    try {
                      if (formKey.currentState!.validate()) {
                        await AuthService().resetPassword(
                          email: emailController.text.trim(),
                        );
                        if (!context.mounted) return;
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('reset_email_sent'.tr()),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pop(context);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.toString())));
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
