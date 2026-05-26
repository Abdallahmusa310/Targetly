import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/sign_in_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // لو لسه بيحمل - مش بيروح لأي مكان
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return Scaffold(
            body: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, color: Colors.red, size: 50),
                  const SizedBox(height: 16),
                  const Text('Authentication error occurred'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pushReplacementNamed(
                      context,
                      AppRoutes.signInScreen,
                    ),
                    child: const Text('Continue to Sign In'),
                  ),
                ],
              ),
            ),
          );
        }
        if (snapshot.hasData) {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await HiveManager.openUserBoxes();
            if (context.mounted) {
              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.navigationScreen);

              // لو مفيش اسم يفتح dialog
              if (HiveManager.getUser() == null) {
                _showUsernameDialog(context);
              }
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // مفيش يوزر - روح للـ SignIn
        return const SignInScreen();
      },
    );
  }
}

void _showUsernameDialog(BuildContext context) {
  final nameController = TextEditingController();
  final jobController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false, // مينفعش يقفله من غير ما يحط اسم
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('welcome'.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'enter your info'.tr(),
            style: const TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'name'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: jobController,
            decoration: InputDecoration(
              labelText: 'job title'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          onPressed: () {
            if (nameController.text.trim().isEmpty) return;
            HiveManager.saveUser(
              username: nameController.text.trim(),
              jobTitle: jobController.text.trim().isEmpty
                  ? 'Sales Manager'
                  : jobController.text.trim(),
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7F73E6),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('save'.tr()),
        ),
      ],
    ),
  );
}
