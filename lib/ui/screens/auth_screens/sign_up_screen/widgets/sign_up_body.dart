import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SignUpBody extends StatelessWidget {
  const SignUpBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Image.asset(
            'assets/targetlyicon.png',
            width: 180,
            height: 180,
            fit: BoxFit.cover,
          ),
        ),
        ShaderMask(
          shaderCallback: (bounds) => const LinearGradient(
            colors: [Color(0xFF7F73E6), Color.fromARGB(255, 13, 157, 201)],
          ).createShader(bounds),
          child: Text(
            'Targetly',
            style: GoogleFonts.poppins(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'app_subtitle'.tr(),
          style: const TextStyle(fontSize: 16, color: Color(0xff8F92C2)),
        ),
        const SizedBox(height: 20),
        Text(
          'Create account'.tr(),
          style: const TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xff2B1E5E),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'sign_up_subtitle'.tr(),
          style: const TextStyle(fontSize: 16, color: Color(0xff8F92C2)),
        ),
      ],
    );
  }
}
