import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/auth_screens/sign_in_screen/sign_in_screen.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/build_tile.dart';

class AccounntSction extends StatelessWidget {
  const AccounntSction({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildTile(
          icon: Icons.edit,
          title: "Edit Profile".tr(),
          subtitle: "Update username and job title".tr(),
          onTap: () {},
          iconColor: const Color(0xFF7F73E6),
        ),

        BuildTile(
          icon: Icons.logout,
          title: "Logout".tr(),
          subtitle: "Sign out from your account".tr(),
          iconColor: Colors.red,
          onTap: () async {
            await FirebaseAuth.instance.signOut();

            if (context.mounted) {
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const SignInScreen()),
                (route) => false,
              );
            }
          },
        ),
      ],
    );
  }
}
