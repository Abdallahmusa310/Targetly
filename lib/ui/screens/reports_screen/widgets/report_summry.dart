import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/report_card.dart';

class ReportSummry extends StatelessWidget {
  const ReportSummry({super.key, required this.start, required this.end});

  final DateTime? start;
  final DateTime? end;

  @override
  Widget build(BuildContext context) {
    if (start == null || end == null) {
      return const Center(
        child: Text(
          "Select date range and generate report",
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return BlocBuilder<TargetCubit, TargetState>(
      builder: (context, targetstate) {
        double target = 0;
        double commissionPercent = 0;

        if (targetstate is TargetSuccess) {
          final targetModel = targetstate.target;

          /// 🔥 check لو الرينج داخل فترة التارجت
          final hasTargetRange =
              targetModel?.startDate != null && targetModel?.endDate != null;

          final isInTargetRange =
              hasTargetRange &&
              !start!.isAfter(targetModel!.endDate) &&
              !end!.isBefore(targetModel.startDate);

          if (isInTargetRange) {
            target = targetModel.target;
            commissionPercent = targetModel.commission;
          }
        }

        return BlocBuilder<ClinetCubit, Clientstate>(
          builder: (context, clientstate) {
            double achieved = 0;
            int totalClients = 0;

            if (clientstate is Clientsucsess) {
              final stats = context.read<ClinetCubit>().getStatsInRange(
                start!,
                end!,
              );

              achieved = stats.achieved;
              totalClients = stats.totalClients;
            }

            final remaining = (target - achieved).clamp(0, double.infinity);

            final commissionValue = achieved * (commissionPercent / 100);

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Report Summary',
                  style: TextStyle(fontSize: 18, color: Color(0xff8F92C2)),
                ),
                const SizedBox(height: 20),

                /// 🔥 لو مفيش تارجت في الفترة
                if (target == 0)
                  const Padding(
                    padding: EdgeInsets.only(bottom: 10),
                    child: Text(
                      "No target in this period",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),

                GridView.count(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisCount: 2,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: 1.4,
                  children: [
                    /// 👥 Clients
                    Reportcard(
                      title: 'Clients',
                      value: totalClients.toString(),
                    ),

                    /// 💰 Remaining
                    Reportcard(
                      title: 'Remaining',
                      value: remaining.toStringAsFixed(0),
                    ),

                    /// 📊 Sales
                    Reportcard(
                      title: 'Sales',
                      value: achieved.toStringAsFixed(0),
                    ),

                    /// 💸 Commission
                    Reportcard(
                      title: 'Commission',
                      value: commissionValue.toStringAsFixed(0),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
