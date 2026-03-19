import 'package:flutter/material.dart';
import 'package:targetly/data/firebase/auth_service.dart';

Future<void> showLogoutDialog(BuildContext context) async {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: const Text("Logout"),
        content: const Text("Are you sure you want to log out?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await AuthService().signOut();
            },
            child: const Text("Logout", style: TextStyle(color: Colors.red)),
          ),
        ],
      );
    },
  );
}
