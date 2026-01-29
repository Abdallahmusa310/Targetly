import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/home_screen/widgets/header.dart';
import 'package:targetly/ui/screens/home_screen/widgets/quick_action_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/recent_activity.dart';
import 'package:targetly/ui/screens/home_screen/widgets/state_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/target_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/today_summary.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6F7FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Buildheader(),
                SizedBox(height: 16),
                BuildTargetCard(),
                SizedBox(height: 16),
                Row(
                  children: [
                    buildStatCard(
                      'Comission',
                      '1500',
                      Icon(Icons.monetization_on, color: Colors.white),
                      Color(0xFF5B5F97),
                    ),
                    SizedBox(width: 16),
                    buildStatCard(
                      'clintes',
                      '350',
                      Icon(Icons.people, color: Colors.white),
                      Color.fromARGB(255, 13, 157, 201),
                    ),
                  ],
                ),
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    QuickActionCard(
                      textcard: 'Add client',
                      iconcard: Icon(Icons.add, color: Colors.white),
                      iconcolor: Color(0xFF5B5F97),
                    ),
                    QuickActionCard(
                      textcard: 'View report',
                      iconcard: Icon(Icons.person, color: Colors.white),
                      iconcolor: Color.fromARGB(255, 13, 157, 201),
                    ),
                    QuickActionCard(
                      textcard: 'update target',
                      iconcard: Icon(
                        Icons.arrow_circle_up,
                        color: Colors.white,
                      ),
                      iconcolor: Color(0xFF5B5F97),
                    ),
                  ],
                ),
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
