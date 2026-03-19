import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/auth_screens/reset_password_screen/confirm_message.dart';

class Buildheader extends StatelessWidget {
  const Buildheader({super.key});

  @override
  Widget build(BuildContext context) {
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
                    onPressed: () async {
                      showLogoutDialog(context);
                    },
                    icon: Icon(Icons.logout),
                  ),
                  Text(
                    'Abdallah 👋',
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
