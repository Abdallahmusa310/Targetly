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
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Icon(icon, size: 24, color: Color(0xFF5B5F97)),
          const SizedBox(width: 10),
          Text(text, style: TextStyle(fontSize: 13)),
        ],
      ),
    );
  }
}
