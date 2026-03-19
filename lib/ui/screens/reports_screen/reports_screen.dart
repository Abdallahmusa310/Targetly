import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/report_summry.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/select_period.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/target_progress.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

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
              const SelectPeriod(),
              const SizedBox(height: 16),
              const ReportSummry(),
              const SizedBox(height: 10),
              const TargetProgress(),
            ],
          ),
        ),
      ),
    );
  }
}
