import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/ui/shared/confirm_message.dart';
import 'package:targetly/ui/screens/profile_screen/profile_screen.dart';

class Buildheader extends StatelessWidget {
  const Buildheader({super.key});

  @override
  Widget build(BuildContext context) {
    final username = HiveManager.getUsername();
    final jobTitle = HiveManager.getJobTitle();
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
                style: TextStyle(fontSize: 14, color: Colors.grey),
              ),
              SizedBox(height: 4),
              Row(
                children: [
                  IconButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => ConfirmMessage(
                          onConfirm: () async {
                            Navigator.pop(context);
                            await HiveManager.closeUserBoxes();
                            HiveManager.clearUser();
                            await AuthService().signOut();
                            Navigator.of(context).pushNamedAndRemoveUntil(
                              AppRoutes.signInScreen,
                              (route) => false,
                            );
                          },
                        ),
                      );
                    },
                    icon: Icon(Icons.logout),
                  ),
                  Text(
                    username.isNotEmpty ? username : '${'username'.tr()} 👋',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                jobTitle.isNotEmpty ? jobTitle : 'job_title'.tr(),
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
        InkWell(
          onTap: () {
            showDialog(context: context, builder: (_) => const ProfileDialog());
          },
          child: Container(
            width: 50,
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              gradient: LinearGradient(
                colors: [Color(0xFF7F73E6), Color.fromARGB(255, 13, 157, 201)],
              ),
            ),
            child: const Icon(Icons.person, size: 30, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
