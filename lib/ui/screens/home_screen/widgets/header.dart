import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/logic/user/cubit/user_cubit.dart';
import 'package:targetly/ui/shared/confirm_message.dart';
import 'package:targetly/ui/screens/profile_screen/profile_screen.dart';

class Buildheader extends StatefulWidget {
  const Buildheader({super.key});

  @override
  State<Buildheader> createState() => _BuildheaderState();
}

class _BuildheaderState extends State<Buildheader> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<UserCubit, UserState>(
      builder: (context, state) {
        final username = state is UserLoaded
            ? state.user?.username ?? 'User'
            : 'User';
        final jobTitle = state is UserLoaded
            ? state.user?.jobTitle ?? 'Sales Manager'
            : 'Sales Manager';

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome back'.tr(),
                    style: TextStyle(
                      fontSize: 14,
                      color: isDark ? Colors.white54 : Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (dialogContext) => ConfirmMessage(
                              onConfirm: () async {
                                Navigator.pop(dialogContext);
                                await HiveManager.closeUserBoxes();
                                HiveManager.clearUser();
                                await AuthService().signOut();
                                if (context.mounted) {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                    AppRoutes.signInScreen,
                                    (route) => false,
                                  );
                                }
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.logout,
                          color: isDark
                              ? Colors.white70
                              : const Color.fromARGB(255, 39, 39, 70),
                        ),
                      ),
                      Text(
                        username,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDark
                              ? Colors.white
                              : const Color.fromARGB(255, 39, 39, 70),
                        ),
                      ),
                    ],
                  ),
                  Text(
                    jobTitle,
                    style: TextStyle(
                      fontSize: 16,
                      color: isDark ? Colors.white54 : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () => showDialog(
                context: context,
                builder: (_) => const ProfileDialog(),
              ),
              child: Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFF7F73E6),
                      Color.fromARGB(255, 13, 157, 201),
                    ],
                  ),
                ),
                child: const Icon(Icons.person, size: 30, color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
