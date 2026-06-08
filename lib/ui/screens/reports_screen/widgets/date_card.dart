import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.title, required this.date});
  final String title, date;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
        border: Border.all(
          color: isDark ? Colors.white12 : Colors.grey.shade300,
        ),
      ),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xff2B1E5E),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.calendar_today,
                size: 18,
                color: isDark ? Colors.white70 : const Color(0xff2B1E5E),
              ),
              const SizedBox(width: 6),
              Text(
                date,
                style: TextStyle(
                  color: isDark ? Colors.white70 : const Color(0xff2B1E5E),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
