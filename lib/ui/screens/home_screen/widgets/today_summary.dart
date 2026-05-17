import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/home_screen/widgets/build_today_summary_item.dart';

class BuildTodaySummary extends StatelessWidget {
  const BuildTodaySummary({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TargetCubit, TargetState>(
      builder: (context, state) {
        final clientCubit = context.watch<ClinetCubit>();

        final stats = clientCubit.getTodayStats();

        return Card(
          elevation: 4,
          child: Column(
            children: [
              Text(
                'Today Summary'.tr(),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),

              const SizedBox(height: 12),

              BuildTodaySummaryItem(
                icon: Icons.people,
                text: '${'New clients'.tr()}: ${stats.totalClients}',
              ),

              const SizedBox(height: 6),

              BuildTodaySummaryItem(
                icon: Icons.monetization_on,
                text:
                    '${'Sales today'.tr()}: ${stats.achieved.toStringAsFixed(0)}',
              ),
            ],
          ),
        );
      },
    );
  }
}
