import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/text_field.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm({
    super.key,
    required this.formKey,
    required this.emailcontroller,
    required this.passwordcontroller,
    required this.nameController,
  });
  final GlobalKey<FormState> formKey;
  final TextEditingController? emailcontroller;
  final TextEditingController? passwordcontroller;
  final TextEditingController? nameController;

  @override
  State<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          SharedTextFeild(
            controller: widget.emailcontroller,
            obscureText: false,
            hintText: 'email'.tr(),
            prefixIcon: const Icon(Icons.email, color: Color(0xff969ACA)),
            validator: (email) {
              if (email == null || email.isEmpty) return 'enter_email'.tr();
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
                return 'valid_email'.tr();
              }
              return null;
            },
          ),
          const SizedBox(height: 12),
          SharedTextFeild(
            obscureText: !isPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () =>
                  setState(() => isPasswordVisible = !isPasswordVisible),
              icon: Icon(
                isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                color: const Color(0xff969ACA),
              ),
            ),
            hintText: 'password'.tr(),
            prefixIcon: const Icon(Icons.lock, color: Color(0xff969ACA)),
            controller: widget.passwordcontroller,
            validator: (password) {
              if (password == null || password.isEmpty)
                return 'enter_password'.tr();
              if (password.length < 6) return 'password_length'.tr();
              return null;
            },
          ),
          const SizedBox(height: 12),
          SharedTextFeild(
            hintText: 'confirm_password'.tr(),
            obscureText: !isConfirmPasswordVisible,
            suffixIcon: IconButton(
              onPressed: () => setState(
                () => isConfirmPasswordVisible = !isConfirmPasswordVisible,
              ),
              icon: Icon(
                isConfirmPasswordVisible
                    ? Icons.visibility
                    : Icons.visibility_off,
                color: const Color(0xff969ACA),
              ),
            ),
            prefixIcon: const Icon(
              Icons.lock_outline,
              color: Color(0xff969ACA),
            ),
            validator: (confirmPassword) {
              if (confirmPassword == null || confirmPassword.isEmpty) {
                return 'confirm_password_empty'.tr();
              }
              if (confirmPassword != widget.passwordcontroller?.text) {
                return 'passwords_not_match'.tr();
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
