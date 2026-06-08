import 'package:flutter/material.dart';

class BuildTodaySummaryItem extends StatelessWidget {
  const BuildTodaySummaryItem({
    super.key,
    required this.text,
    required this.icon,
  });
  final String text;
  final IconData icon;

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
            icon,
            size: 24,
            color: isDark ? const Color(0xFF7F73E6) : const Color(0xFF5B5F97),
          ),
          const SizedBox(width: 10),
          Text(
            text,
            style: TextStyle(
              fontSize: 13,
              color: isDark ? Colors.white70 : const Color(0xff2B1E5E),
            ),
          ),
        ],
      ),
    );
  }
}
