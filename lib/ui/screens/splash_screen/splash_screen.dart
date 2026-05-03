import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:targetly/ui/screens/auth_screens/auth_gate.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          AnimatedTextKit(
            animatedTexts: [
              TyperAnimatedText(
                'Targetly',
                textStyle: const TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF5B5F97),
                ),
                speed: const Duration(milliseconds: 200),
              ),
            ],
          ),
          SizedBox(
            height: 300,
            child: LottieBuilder.asset(
              'assets/Mission.json',
              errorBuilder: (context, error, stackTrace) {
                print('Lottie asset loading error: $error');
                return Container(
                  height: 300,
                  child: Icon(
                    Icons.business_center,
                    size: 100,
                    color: Color(0xFF5B5F97),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      duration: 1600, // Increased duration to ensure proper loading
      splashIconSize: 900,
      centered: true,
      nextScreen: AuthGate(),
      splashTransition: SplashTransition.fadeTransition,
    );
  }
}
