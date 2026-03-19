import 'package:flutter/material.dart';

class DateCard extends StatelessWidget {
  const DateCard({super.key, required this.title, required this.date});
  final String title, date;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.calendar_today, size: 18),
              const SizedBox(width: 6),
              Text(date),
            ],
          ),
        ],
      ),
    );
  }
}
