import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';

class BuildTargetCard extends StatelessWidget {
  const BuildTargetCard({super.key});

  String formatNumber(num number) {
    return NumberFormat.decimalPattern(Intl.getCurrentLocale()).format(number);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TargetCubit, TargetState>(
      builder: (context, targetState) {
        if (targetState is TargetLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (targetState is TargetSuccess) {
          final targetModel = targetState.target;

          final target = targetModel?.target ?? 0;
          final start = targetModel?.startDate;
          final end = targetModel?.endDate;

          final now = DateTime.now();

          final isActiveRange =
              start != null &&
              end != null &&
              !now.isBefore(start) &&
              !now.isAfter(end);

          return BlocBuilder<ClinetCubit, Clientstate>(
            builder: (context, clientState) {
              double achieved = 0;

              if (clientState is Clientsucsess) {
                final clients = clientState.clinet ?? [];

                if (start != null && end != null) {
                  if (isActiveRange) {
                    final stats = context.read<ClinetCubit>().getStatsInRange(
                      start,
                      end,
                    );

                    achieved = stats.achieved;
                  } else {
                    achieved = 0;
                  }
                } else {
                  achieved = clients.fold<double>(
                    0,
                    (sum, client) =>
                        sum + (double.tryParse(client.clinetfees ?? '0') ?? 0),
                  );
                }
              }

              final remaining = (target - achieved).clamp(0, double.infinity);

              final progress = target == 0
                  ? 0
                  : (achieved / target).clamp(0, 1);

              final percentage = progress * 100;

              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF7F73E6),
                      Color.fromARGB(255, 13, 157, 201),
                    ],
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Monthly Target'.tr(),
                      style: const TextStyle(color: Colors.white70),
                    ),

                    const SizedBox(height: 8),

                    Text(
                      '${formatNumber(achieved.toStringAsFixed(0) == achieved ? achieved.toInt() : achieved)} / ${formatNumber(target)} ${'EGP / Month'.tr()}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 16),

                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0, end: progress.toDouble()),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.easeInOut,
                      builder: (context, value, child) {
                        return ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: LinearProgressIndicator(
                            value: value,
                            minHeight: 8,
                            backgroundColor: Colors.white24,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              value >= 1 ? Colors.green : Colors.white,
                            ),
                          ),
                        );
                      },
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${'Remaining:'.tr()} ${formatNumber(remaining)}',
                              style: const TextStyle(color: Colors.white),
                            ),

                            if (start != null && end != null)
                              Text(
                                '${'Period:'.tr()} '
                                '${DateFormat.yMd(context.locale.languageCode).format(start)}'
                                ' - '
                                '${DateFormat.yMd(context.locale.languageCode).format(end)}',
                                style: const TextStyle(color: Colors.white),
                              ),
                          ],
                        ),

                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '${'Achieved:'.tr()} ${formatNumber(double.parse(percentage.toStringAsFixed(1)))}%',
                              style: const TextStyle(color: Colors.white),
                            ),

                            Text(
                              '${'Commission:'.tr()} ${formatNumber(targetModel?.commission ?? 0)}%',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),

                    if (start != null && end != null && !isActiveRange)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Target period ended'.tr(),
                          style: const TextStyle(
                            color: Colors.redAccent,
                            fontSize: 12,
                          ),
                        ),
                      ),
                  ],
                ),
              );
            },
          );
        }

        return Text('No Target'.tr());
      },
    );
  }
}
