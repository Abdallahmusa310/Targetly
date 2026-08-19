import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/logic/Clients/cubit/client_cubit.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/logic/thems/cubit/thems_cubit.dart';
import 'package:targetly/logic/user/cubit/user_cubit.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/sign_in_screen.dart';

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
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
              final userCubit = context.read<UserCubit>();
              final themsCubit = context.read<ThemsCubit>();
              final targetCubit = context.read<TargetCubit>();
              final clientCubit = context.read<ClinetCubit>();
              final activityCubit = context.read<ActivityCubit>();

              userCubit.loadUser();
              themsCubit.loadTheme();
              targetCubit.fetchTarget();
              clientCubit.fetchClients();
              activityCubit.fetchActivities();

              final isNewUser = HiveManager.getUser() == null;

              Navigator.of(
                context,
              ).pushReplacementNamed(AppRoutes.navigationScreen);

              if (isNewUser) {
                await Future.delayed(const Duration(milliseconds: 300));
                if (context.mounted) {
                  _showUsernameDialog(context, userCubit);
                }
              }
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        return const SignInScreen();
      },
    );
  }
}

void _showUsernameDialog(BuildContext context, UserCubit userCubit) {
  final nameController = TextEditingController();
  final jobController = TextEditingController();

  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (dialogContext) => AlertDialog(
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
              labelText: 'Name'.tr(),
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
            userCubit.saveUser(
              username: nameController.text.trim(),
              jobTitle: jobController.text.trim().isEmpty
                  ? 'Sales Manager'
                  : jobController.text.trim(),
            );
            Navigator.pop(dialogContext);
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
