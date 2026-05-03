import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/home_screen/widgets/header.dart';
import 'package:targetly/ui/screens/home_screen/widgets/quick_ation_list.dart';
import 'package:targetly/ui/screens/home_screen/widgets/recent_activity.dart';
import 'package:targetly/ui/screens/home_screen/widgets/stat_list.dart';
import 'package:targetly/ui/screens/home_screen/widgets/target_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/today_summary.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<TargetCubit>(context).fetchTarget();
    BlocProvider.of<ClinetCubit>(context).fetchClients();
    BlocProvider.of<ActivityCubit>(context).fetchActivities();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            title: const Text(
              'Targetly',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            centerTitle: true,
            backgroundColor: Colors.white.withValues(alpha: 0.8),
            elevation: 0,
            floating: true,
            snap: true,
            pinned: false,
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
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
        ],
      ),
    );
  }
}
