import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/client_dialog.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/target_dialog.dart';
import 'package:targetly/ui/screens/reports_screen/reports_screen.dart';
import 'package:targetly/ui/shared/confirm_message.dart';
import 'package:targetly/ui/shared/formate_numpers.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TargetCubit, TargetState>(
      builder: (context, targetState) {
        final clientCubit = context.watch<ClinetCubit>();

        double totalFees = 0;
        int totalClients = 0;
        double commissionPercent = 0;
        DateTime? start;
        DateTime? end;

        if (targetState is TargetSuccess) {
          final target = targetState.target;
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

        final items = [
          // Commission
          _GridItem(
            icon: Icons.monetization_on,
            color: const Color(0xFF5B5F97),
            title: 'Commission'.tr(),
            value: commissionValue.toLocalizedString(context),
            isAction: false,
          ),
          // Clients
          _GridItem(
            icon: Icons.people,
            color: const Color.fromARGB(255, 13, 157, 201),
            title: 'Clients'.tr(),
            value: totalClients.toLocalizedString(context),
            isAction: false,
            onTap: () => _showClientsInRange(context, start, end),
          ),
          // Add Client
          _GridItem(
            icon: Icons.person_add_alt_1,
            color: const Color(0xFF5B5F97),
            title: 'Add client'.tr(),
            isAction: true,
            onTap: () => showDialog(
              context: context,
              builder: (_) => const Clientdialog(),
            ),
          ),
          // Update Target
          _GridItem(
            icon: Icons.arrow_circle_up,
            color: const Color(0xFF5B5F97),
            title: 'Update target'.tr(),
            isAction: true,
            onTap: () => showDialog(
              context: context,
              builder: (_) => const Targetdialog(),
            ),
          ),
          // View Report
          _GridItem(
            icon: Icons.assessment,
            color: const Color.fromARGB(255, 13, 157, 201),
            title: 'View report'.tr(),
            isAction: true,
            onTap: () {
              if (targetState is TargetSuccess && targetState.target != null) {
                final target = targetState.target!;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => ReportsScreen(
                      initialStart: target.startDate,
                      initialEnd: target.endDate,
                    ),
                  ),
                );
              }
            },
          ),
          // Reset Period
          _GridItem(
            icon: Icons.refresh,
            color: Colors.redAccent,
            title: 'Reset period'.tr(),
            isAction: true,
            onTap: () => _showResetDialog(context),
          ),
        ];

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.5,
          ),
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];
            return GestureDetector(
              onTap: item.onTap,
              child: Card(
                elevation: 4,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: item.color,
                            child: Icon(
                              item.icon,
                              color: Colors.white,
                              size: 18,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Expanded(
                            child: Text(
                              item.title,
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ],
                      ),
                      if (!item.isAction && item.value != null)
                        Text(
                          item.value!,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: item.color,
                          ),
                        ),
                      if (item.isAction)
                        Icon(
                          Icons.arrow_forward_ios,
                          size: 14,
                          color: Colors.grey,
                        ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showClientsInRange(
    BuildContext context,
    DateTime? start,
    DateTime? end,
  ) {
    if (start == null || end == null) return;

    final clients = context.read<ClinetCubit>().allClients.where((c) {
      final date = c.createdAt;
      if (date == null) return false;
      return !date.isBefore(start) && !date.isAfter(end);
    }).toList();

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('clients in period'.tr()),
        content: clients.isEmpty
            ? Text('no clients in period'.tr())
            : SizedBox(
                width: double.maxFinite,
                height: 400,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: clients.length,
                  itemBuilder: (context, index) {
                    final client = clients[index];
                    return ClinetCard(clinetModel: client);
                  },
                ),
              ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('close'.tr()),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('reset period'.tr()),
        content: Text('reset period confirm'.tr()),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('cancel'.tr()),
          ),
          ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => ConfirmMessage(
                  onConfirm: () async {
                    context.read<TargetCubit>().clearTarget();
                    Navigator.pop(context);
                  },
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: Text('reset'.tr()),
          ),
        ],
      ),
    );
  }
}

class _GridItem {
  final IconData icon;
  final Color color;
  final String title;
  final String? value;
  final bool isAction;
  final VoidCallback? onTap;

  _GridItem({
    required this.icon,
    required this.color,
    required this.title,
    this.value,
    required this.isAction,
    this.onTap,
  });
}
