import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';

class BuildTargetCard extends StatefulWidget {
  const BuildTargetCard({super.key});

  @override
  State<BuildTargetCard> createState() => _BuildTargetCardState();
}

class _BuildTargetCardState extends State<BuildTargetCard> {
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
          return BlocBuilder<ClinetCubit, ClinetState>(
            builder: (context, clientState) {
              double achieved = 0;
              if (clientState is Clinetsucsess) {
                final clients =
                    clientState.clinet ?? []; // لو null خليها empty list

                achieved = clients.fold<double>(
                  0.0, // initial value double
                  (sum, client) =>
                      sum + (double.tryParse(client.clinetfees) ?? 0),
                );
              }

              final remaining = target - achieved;
              final progress = target == 0 ? 0 : achieved / target;
              final percentage = (progress * 100);

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
                    const Text(
                      'Monthly Target',
                      style: TextStyle(color: Colors.white70),
                    ),
                    const SizedBox(height: 8),

                    /// 🔥 Achieved / Target
                    Text(
                      '${achieved.toStringAsFixed(0)} / ${target.toStringAsFixed(0)} EGP',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    LinearProgressIndicator(
                      value: progress.toDouble(),
                      minHeight: 6,
                      backgroundColor: Color(0xFF7F73E6),
                      valueColor: AlwaysStoppedAnimation<Color>(
                        progress >= 1.0
                            ? Colors.white
                            : Colors.white, // أبيض لو خلص، موف لو لسه
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Target: ${target.toStringAsFixed(0)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              'Remaining: ${remaining.toStringAsFixed(0)}',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Achieved: ${percentage.toStringAsFixed(1)}%',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Commission: ${targetModel?.commission ?? 0}%',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        }

        return const Text('No Target');
      },
    );
  }
}
