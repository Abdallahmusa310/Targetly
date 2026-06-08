import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:targetly/logic/Clients/cubit/client_cubit.dart';

import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/line_chart.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/report_summry.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/select_period.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/target_progress.dart';

class ReportsScreen extends StatefulWidget {
  const ReportsScreen({super.key, this.initialStart, this.initialEnd});

  final DateTime? initialStart;
  final DateTime? initialEnd;

  @override
  State<ReportsScreen> createState() => _ReportsScreenState();
}

class _ReportsScreenState extends State<ReportsScreen> {
  DateTime? reportStart;
  DateTime? reportEnd;

  double _achieved = 0;
  double _target = 0;

  @override
  void initState() {
    super.initState();

    if (widget.initialStart != null && widget.initialEnd != null) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        onGenerate(widget.initialStart!, widget.initialEnd!);
      });
    }
  }

  void onGenerate(DateTime start, DateTime end) {
    final clientCubit = context.read<ClinetCubit>();
    final targetCubit = context.read<TargetCubit>();

    final stats = clientCubit.getStatsInRange(start, end);

    double target = 0;

    if (targetCubit.state is TargetSuccess) {
      final targetModel = (targetCubit.state as TargetSuccess).target;

      if (targetModel != null &&
          !start.isAfter(targetModel.endDate) &&
          !end.isBefore(targetModel.startDate)) {
        target = targetModel.target;
      }
    }

    setState(() {
      reportStart = start;
      reportEnd = end;
      _achieved = stats.achieved;
      _target = target;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "reports".tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Theme.of(context).appBarTheme.backgroundColor,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SelectPeriod(onGenerate: onGenerate),
              const SizedBox(height: 16),
              ReportSummry(start: reportStart, end: reportEnd),
              const SizedBox(height: 10),
              TargetProgress(achieved: _achieved, target: _target),
              if (reportStart != null && reportEnd != null) ...[
                const SizedBox(height: 16),
                SalesLineChart(start: reportStart!, end: reportEnd!),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
