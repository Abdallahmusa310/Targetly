import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/core/routing/routs.dart';

class SignInPrompt extends StatelessWidget {
  const SignInPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: () => Navigator.pushReplacementNamed(
            context,
            AppRoutes.resetPasswordScreen,
          ),
          child: Text(
            'forgot_password'.tr(),
            style: const TextStyle(
              color: Color(0xff2B1E5E),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'no_account'.tr(),
              style: const TextStyle(color: Color(0xff8F92C2)),
            ),
            InkWell(
              onTap: () => Navigator.pushNamed(context, '/sign-up'),
              child: Text(
                'sign_up_link'.tr(),
                style: const TextStyle(
                  color: Color(0xff6A5AE0),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
