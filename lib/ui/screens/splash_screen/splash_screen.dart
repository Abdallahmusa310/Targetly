import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:targetly/ui/screens/navigation/navigation_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: Center(
        child: Column(
          children: [
            SizedBox(
              height: 350,
              child: LottieBuilder.asset('assets/Mission.json'),
            ),
          ],
        ),
      ),
      duration: 500,
      splashIconSize: 900,
      centered: true,
      nextScreen: NavigationScreen(),
    );
  }
}
