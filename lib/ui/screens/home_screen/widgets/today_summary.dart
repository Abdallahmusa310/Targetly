import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/home_screen/widgets/build_today_summary_item.dart';

class BuildTodaySummary extends StatelessWidget {
  const BuildTodaySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Column(
        children: [
          const Text(
            'Today Summary',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          BuildTodaySummaryItem(icon: Icons.people, text: 'new client added'),
          const SizedBox(height: 6),
          BuildTodaySummaryItem(
            icon: Icons.monetization_on,
            text: 'sales today 450',
          ),
        ],
      ),
    );
  }
}
