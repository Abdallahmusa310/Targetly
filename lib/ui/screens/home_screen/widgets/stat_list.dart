import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/home_screen/widgets/state_card.dart';

class StatList extends StatelessWidget {
  const StatList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TargetCubit, TargetState>(
      builder: (context, state) {
        final clientCubit = context.watch<ClinetCubit>();

        double totalFees = 0;
        int totalClients = 0;
        double commissionPercent = 0;

        if (state is TargetSuccess) {
          final target = state.target;
          commissionPercent = target?.commission ?? 0;
          final start = target?.startDate;
          final end = target?.endDate;
          if (start != null && end != null) {
            final stats = clientCubit.getStatsInRange(start, end);
            totalFees = stats.achieved;
            totalClients = stats.totalClients;
          } else {
            totalFees = clientCubit.getTotalFees();
            totalClients = clientCubit.getClientsCount();
          }
        }

        final commissionValue = totalFees * (commissionPercent / 100);

        return Row(
          children: [
            Expanded(
              child: BuildStatCard(
                title: 'Commission',
                value: commissionValue.toStringAsFixed(0),
                icon: const Icon(Icons.monetization_on, color: Colors.white),
                color: const Color(0xFF5B5F97),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: BuildStatCard(
                title: 'Clients',
                value: totalClients.toString(),
                icon: const Icon(Icons.people, color: Colors.white),
                color: const Color.fromARGB(255, 13, 157, 201),
              ),
            ),
          ],
        );
      },
    );
  }
}
