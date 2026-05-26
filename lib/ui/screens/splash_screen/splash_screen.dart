import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/ui/screens/auth_screens/auth_gate.dart';
import 'package:targetly/ui/screens/splash_screen/Animated_logo.dart';
import 'package:targetly/ui/screens/welcome_screen/welcome_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // اسم الأبب المتحرك
          ShaderMask(
            shaderCallback: (bounds) => const LinearGradient(
              colors: [Color(0xFF7F73E6), Color.fromARGB(255, 13, 157, 201)],
            ).createShader(bounds),
            child: AnimatedTextKit(
              totalRepeatCount: 1,
              animatedTexts: [
                TyperAnimatedText(
                  'Targetly',
                  speed: const Duration(milliseconds: 350),
                  textStyle: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // اللوجو المتحرك
          const AnimatedLogo(),
        ],
      ),
      duration: 3200,
      splashIconSize: 800,
      centered: true,
      nextScreen: HiveManager.isFirstTime()
          ? const WelcomeScreen()
          : const AuthGate(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
