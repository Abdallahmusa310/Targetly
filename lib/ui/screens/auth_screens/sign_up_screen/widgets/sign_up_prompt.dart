import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class SignUpPrompt extends StatelessWidget {
  const SignUpPrompt({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'have_account'.tr(),
          style: const TextStyle(color: Color(0xff8F92C2)),
        ),
        GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/sign-in'),
          child: Text(
            'Sign In'.tr(),
            style: const TextStyle(
              color: Color(0xff6A5AE0),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
