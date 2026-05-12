import 'package:flutter/material.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/ui/screens/auth_screens/reset_password_screen/confirm_message.dart';

class Buildheader extends StatelessWidget {
  const Buildheader({super.key});

  @override
  Widget build(BuildContext context) {
    final username = HiveManager.getUsername();
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome back',
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
                    '$username 👋',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
            ],
          ),
        ),
        CircleAvatar(
          radius: 22,
          backgroundColor: Color(0xFF5B5F97),
          child: Icon(Icons.person, color: Colors.white),
        ),
      ],
    );
  }
}
