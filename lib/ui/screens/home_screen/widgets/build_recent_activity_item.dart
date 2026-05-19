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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, size: 24, color: Color(0xFF5B5F97)),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              _getDisplayText(context),
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}
