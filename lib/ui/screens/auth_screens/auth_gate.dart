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
        print(
          'AuthGate state: ${snapshot.connectionState}, hasData: ${snapshot.hasData}',
        );

        // Still loading - add timeout
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading...'),
                ],
              ),
            ),
          );
        }

        // Error handling
        if (snapshot.hasError) {
          print('AuthGate error: ${snapshot.error}');
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, color: Colors.red, size: 50),
                  SizedBox(height: 16),
                  Text('Authentication error occurred'),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => const SignInScreen()),
                    ),
                    child: Text('Continue to Sign In'),
                  ),
                ],
              ),
            ),
          );
        }

        if (snapshot.hasData) {
          print('User is authenticated, going to NavigationScreen');
          return const NavigationScreen();
        }

        print('No user authenticated, going to SignInScreen');
        return const SignInScreen();
      },
    );
  }
}
