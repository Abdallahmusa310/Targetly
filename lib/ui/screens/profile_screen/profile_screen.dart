import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/accounnt_sction.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/apout_section.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/prefrance_section.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/productivity_section.dart';
import 'package:targetly/ui/screens/profile_screen/widgets/profile_section.dart';
import 'package:targetly/ui/shared/dialog.dart';

class ProfileDialog extends StatelessWidget {
  const ProfileDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SharedDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: const Icon(Icons.close),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          ProfileSection(),
          const SizedBox(height: 14),

          _sectionTitle("Account".tr()),
          const SizedBox(height: 14),
          AccountSection(),
          const SizedBox(height: 14),

          _sectionTitle("Productivity".tr()),
          const SizedBox(height: 14),
          ProductivitySection(),
          const SizedBox(height: 14),

          _sectionTitle("Preferences".tr()),
          const SizedBox(height: 14),
          const PrefranceSection(),
          const SizedBox(height: 14),

          ApoutSection(),
          const SizedBox(height: 24), // ← مسافة قبل الزرار

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text("Close".tr()),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        title,
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
    );
  }
}
