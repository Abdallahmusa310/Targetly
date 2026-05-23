import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/client_dialog.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/state_card.dart';
import 'package:targetly/ui/screens/reports_screen/reports_screen.dart';
import 'package:targetly/ui/shared/dialog.dart';
import 'package:targetly/ui/shared/formate_numpers.dart';

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
        DateTime? start;
        DateTime? end;

        if (state is TargetSuccess) {
          final target = state.target;
          commissionPercent = target?.commission ?? 0;
          start = target?.startDate;
          end = target?.endDate;

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

        return Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: BuildStatCard(
                    title: 'Commission'.tr(),
                    value: commissionValue.toLocalizedString(context),
                    icon: const Icon(
                      Icons.monetization_on,
                      color: Colors.white,
                    ),
                    color: const Color(0xFF5B5F97),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BuildStatCard(
                    title: 'Clients'.tr(),
                    value: totalClients.toLocalizedString(context),
                    icon: const Icon(Icons.people, color: Colors.white),
                    color: const Color.fromARGB(255, 13, 157, 201),
                    onTap: () => showClientsInRange(context, start, end),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: BuildStatCard(
                    title: 'View report'.tr(),
                    icon: const Icon(Icons.assessment, color: Colors.white),
                    color: const Color.fromARGB(255, 13, 157, 201),
                    onTap: () {
                      if (state is TargetSuccess && state.target != null) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => ReportsScreen(
                              initialStart: state.target!.startDate,
                              initialEnd: state.target!.endDate,
                            ),
                          ),
                        );
                      }
                    },
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: BuildStatCard(
                    title: 'Add client'.tr(),
                    icon: const Icon(
                      Icons.person_add_alt_1,
                      color: Colors.white,
                    ),
                    color: const Color(0xFF5B5F97),
                    onTap: () => showDialog(
                      context: context,
                      builder: (_) => const Clientdialog(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

void showClientsInRange(BuildContext context, DateTime? start, DateTime? end) {
  if (start == null || end == null) return;

  final clients = context.read<ClinetCubit>().allClients.where((c) {
    final date = c.createdAt;
    if (date == null) return false;
    return !date.isBefore(start) && !date.isAfter(end);
  }).toList();

  showDialog(
    context: context,
    builder: (_) => SharedDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 13, 157, 201),
                child: Icon(Icons.people, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(
                'clients_in_period'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          clients.isEmpty
              ? Text('no_clients_in_period'.tr())
              : SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: clients.length,
                    itemBuilder: (context, index) =>
                        ClinetCard(clinetModel: clients[index]),
                  ),
                ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('close'.tr()),
            ),
          ),
        ],
      ),
    ),
  );
}
