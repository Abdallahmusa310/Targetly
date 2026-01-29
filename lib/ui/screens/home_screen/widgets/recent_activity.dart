import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/home_screen/widgets/build_recent_activity_item.dart';

class BuildRecentActivity extends StatelessWidget {
  const BuildRecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          const Text(
            'Recent Activity',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 12),
          BuildRecentActivityItem(text: 'New client added'),
          BuildRecentActivityItem(text: 'Commission updated'),
          BuildRecentActivityItem(text: 'Target reached 65%'),
        ],
      ),
    );
  }
}
