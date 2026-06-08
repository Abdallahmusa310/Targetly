import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class BuildRecentActivityItem extends StatelessWidget {
  const BuildRecentActivityItem({super.key, required this.text});
  final String text;

  String _getDisplayText(BuildContext context) {
    if (text.startsWith("target_updated:")) {
      final value = text.split(":")[1];
      return "target_updated_msg".tr(args: [value]);
    } else if (text.startsWith("New client:")) {
      final name = text.split(":")[1];
      return "new_client_msg".tr(args: [name]);
    }
    return text;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: isDark ? const Color.fromARGB(255, 39, 39, 70) : Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            size: 24,
            color: isDark ? const Color(0xFF7F73E6) : const Color(0xFF5B5F97),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _getDisplayText(context),
              style: TextStyle(
                fontSize: 13,
                color: isDark ? Colors.white70 : const Color(0xff2B1E5E),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
