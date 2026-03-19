import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/sign_in_screen.dart';
import 'package:targetly/ui/screens/navigation/navigation_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // لسه بيحمل
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // مسجل دخول
        if (snapshot.hasData) {
          return const NavigationScreen();
        }

        // مش مسجل
        return const SignInScreen();
      },
    );
  }
}
