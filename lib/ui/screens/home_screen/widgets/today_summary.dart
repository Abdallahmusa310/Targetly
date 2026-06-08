import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/cubit/client_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/home_screen/widgets/build_today_summary_item.dart';
import 'package:targetly/ui/shared/formate_numpers.dart';

class BuildTodaySummary extends StatelessWidget {
  const BuildTodaySummary({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<TargetCubit, TargetState>(
      builder: (context, state) {
        final clientCubit = context.watch<ClinetCubit>();
        final stats = clientCubit.getTodayStats();

        return Card(
          elevation: 4,
          color: isDark ? const Color.fromARGB(255, 39, 39, 70) : Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                Text(
                  'Today Summary'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xff2B1E5E),
                  ),
                ),
                const SizedBox(height: 12),
                BuildTodaySummaryItem(
                  icon: Icons.people,
                  text:
                      '${'New clients'.tr()}: ${stats.totalClients.toLocalizedString(context)}',
                ),
                const SizedBox(height: 6),
                BuildTodaySummaryItem(
                  icon: Icons.monetization_on,
                  text:
                      '${'Sales today'.tr()}: ${stats.achieved.toLocalizedString(context)}',
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
