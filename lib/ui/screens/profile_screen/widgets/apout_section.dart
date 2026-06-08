// ApoutSection
import 'package:flutter/material.dart';

class ApoutSection extends StatelessWidget {
  const ApoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      children: [
        Text(
          "Targetly CRM",
          style: TextStyle(
            color: isDark ? Colors.white38 : Colors.grey,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          "Version 1.0.0",
          style: TextStyle(color: isDark ? Colors.white38 : Colors.grey),
        ),
      ],
    );
  }
}
