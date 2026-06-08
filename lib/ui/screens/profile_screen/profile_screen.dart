// ProfileDialog (profile_screen)
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SharedDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: IconButton(
              icon: Icon(
                Icons.close,
                color: isDark ? Colors.white70 : Colors.black54,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),

          ProfileSection(),
          const SizedBox(height: 14),

          _sectionTitle("Account".tr(), isDark),
          const SizedBox(height: 14),
          AccountSection(),
          const SizedBox(height: 14),

          _sectionTitle("Productivity".tr(), isDark),
          const SizedBox(height: 14),
          ProductivitySection(),
          const SizedBox(height: 14),

          _sectionTitle("Preferences".tr(), isDark),
          const SizedBox(height: 14),
          const PrefranceSection(),
          const SizedBox(height: 14),

          ApoutSection(),
          const SizedBox(height: 24),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(
                  color: isDark ? Colors.white24 : const Color(0xFF7F73E6),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text(
                "Close".tr(),
                style: TextStyle(
                  color: isDark ? Colors.white70 : const Color(0xFF7F73E6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String title, bool isDark) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: isDark ? Colors.white : const Color(0xff2B1E5E),
        ),
      ),
    );
  }
}
