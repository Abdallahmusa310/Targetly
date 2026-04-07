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
        final clientcubit = context.watch<ClinetCubit>();
        final totalclient = clientcubit.getClientsCount();
        final totalfees = clientcubit.getTotalFees();
        double comissionpercent = 0;
        if (state is TargetSuccess) {
          comissionpercent = state.target?.commission ?? 0;
        }
        final comissionvalue = totalfees * (comissionpercent / 100);
        return Card(
          elevation: 4,
          child: Column(
            children: [
              const Text(
                'Today Summary',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 12),
              BuildTodaySummaryItem(
                icon: Icons.people,
                text: 'new client added ${totalclient}',
              ),
              const SizedBox(height: 6),
              BuildTodaySummaryItem(
                icon: Icons.monetization_on,
                text: 'sales today $comissionvalue',
              ),
            ],
          ),
        );
      },
    );
  }
}
