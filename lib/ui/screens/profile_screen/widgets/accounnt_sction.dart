import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/core/routing/routs.dart';
import 'package:targetly/data/firebase/auth_service.dart';
import 'package:targetly/data/hive/hive_manager.dart';
import 'package:targetly/ui/shared/confirm_message.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/build_tile.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/edit_profile.dart';

class AccountSection extends StatefulWidget {
  const AccountSection({super.key});

  @override
  State<AccountSection> createState() => _AccountSectionState();
}

class _AccountSectionState extends State<AccountSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        BuildTile(
          icon: Icons.edit,
          title: "Edit Profile".tr(),
          subtitle: "Update username and job title".tr(),
          iconColor: const Color(0xFF7F73E6),
          onTap: () {
            showDialog(
              context: context,
              builder: (_) => EditProfileDialog(
                currentUsername: HiveManager.getUsername(),
                currentJobTitle: HiveManager.getJobTitle(),
                onSaved: () {
                  setState(() {});
                },
              ),
            );
          },
        ),

        BuildTile(
          icon: Icons.logout,
          title: "Logout".tr(),
          subtitle: "Sign out from your account".tr(),
          iconColor: Colors.red,
          onTap: () async {
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
        ),
      ],
    );
  }
}
