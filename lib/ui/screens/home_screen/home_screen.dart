import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/home_screen/widgets/header.dart';

import 'package:targetly/ui/screens/home_screen/widgets/quick_ation_list.dart';
import 'package:targetly/ui/screens/home_screen/widgets/recent_activity.dart';
import 'package:targetly/ui/screens/home_screen/widgets/stat_list.dart';
import 'package:targetly/ui/screens/home_screen/widgets/target_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/today_summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Targetly', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      backgroundColor: Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Buildheader(),
                SizedBox(height: 16),
                BuildTargetCard(),
                SizedBox(height: 16),
                StatList(),
                SizedBox(height: 16),
                QuickAtionList(),
                SizedBox(height: 16),
                BuildRecentActivity(),
                SizedBox(height: 16),
                BuildTodaySummary(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
