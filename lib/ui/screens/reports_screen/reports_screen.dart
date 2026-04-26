import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/report_summry.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/select_period.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/target_progress.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key});

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTime? reportStart;
  DateTime? reportEnd;

  void onGenerate(DateTime start, DateTime end) {
    setState(() {
      reportStart = start;
      reportEnd = end;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Reports",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectPeriod(onGenerate: onGenerate),
              const SizedBox(height: 16),
              ReportSummry(start: reportStart, end: reportEnd),
              const SizedBox(height: 10),
              const TargetProgress(),
            ],
          ),
        ),
      ),
    );
  }
}
