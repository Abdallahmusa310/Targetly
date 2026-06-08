import 'package:flutter/material.dart';

class Reportcard extends StatelessWidget {
  const Reportcard({super.key, required this.title, required this.value});
  final String title, value;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 4,
      color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
      child: Column(
        children: [
          const SizedBox(height: 10),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white54 : const Color(0xff8F92C2),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: isDark ? Colors.white : const Color(0xff2B1E5E),
            ),
          ),
        ],
      ),
    );
  }
}
