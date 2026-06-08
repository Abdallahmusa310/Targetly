import 'package:easy_localization/easy_localization.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/cubit/client_cubit.dart';

class SalesLineChart extends StatelessWidget {
  const SalesLineChart({super.key, required this.start, required this.end});

  final DateTime start;
  final DateTime end;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<ClinetCubit, Clientstate>(
      builder: (context, state) {
        if (state is! Clientsucsess) return const SizedBox();

        final Map<int, double> salesPerDay = {};
        final totalDays = end.difference(start).inDays + 1;

        for (int i = 0; i < totalDays; i++) {
          salesPerDay[i] = 0;
        }

        for (var client in context.read<ClinetCubit>().allClients) {
          final date = client.createdAt;
          if (date == null) continue;
          final inRange = !date.isBefore(start) && !date.isAfter(end);
          if (!inRange) continue;
          final dayIndex = date.difference(start).inDays;
          salesPerDay[dayIndex] =
              (salesPerDay[dayIndex] ?? 0) +
              (double.tryParse(client.clinetfees ?? '0') ?? 0);
        }

        final spots = salesPerDay.entries
            .map((e) => FlSpot(e.key.toDouble(), e.value))
            .toList();

        final maxY = salesPerDay.values.isEmpty
            ? 100.0
            : salesPerDay.values.reduce((a, b) => a > b ? a : b) * 1.2;

        return Card(
          color: isDark ? const Color(0xFF1A1A2E) : Colors.white,
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "sales_over_time_title".tr(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Color(0xff8F92C2),
                  ),
                ),
                const SizedBox(height: 16),
                SizedBox(
                  height: 200,
                  child: LineChart(
                    LineChartData(
                      minY: 0,
                      maxY: maxY == 0 ? 100 : maxY,
                      gridData: FlGridData(
                        show: true,
                        drawVerticalLine: false,
                        getDrawingHorizontalLine: (value) => FlLine(
                          color: isDark ? Colors.white12 : Colors.grey.shade200,
                          strokeWidth: 1,
                        ),
                      ),
                      borderData: FlBorderData(show: false),
                      titlesData: FlTitlesData(
                        leftTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 40,
                            getTitlesWidget: (value, meta) => Text(
                              value.toInt().toString(),
                              style: TextStyle(
                                fontSize: 10,
                                color: isDark ? Colors.white54 : Colors.grey,
                              ),
                            ),
                          ),
                        ),
                        bottomTitles: AxisTitles(
                          sideTitles: SideTitles(
                            showTitles: true,
                            reservedSize: 30,
                            getTitlesWidget: (value, meta) {
                              final date = start.add(
                                Duration(days: value.toInt()),
                              );
                              return Text(
                                '${date.day}/${date.month}',
                                style: TextStyle(
                                  fontSize: 10,
                                  color: isDark ? Colors.white54 : Colors.grey,
                                ),
                              );
                            },
                            interval: totalDays <= 7
                                ? 1
                                : (totalDays / 7).ceilToDouble(),
                          ),
                        ),
                        rightTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                        topTitles: const AxisTitles(
                          sideTitles: SideTitles(showTitles: false),
                        ),
                      ),
                      lineBarsData: [
                        LineChartBarData(
                          spots: spots,
                          isCurved: true,
                          gradient: const LinearGradient(
                            colors: [
                              Color(0xFF7F73E6),
                              Color.fromARGB(255, 13, 157, 201),
                            ],
                          ),
                          barWidth: 3,
                          isStrokeCapRound: true,
                          dotData: FlDotData(
                            show: true,
                            getDotPainter: (spot, percent, bar, index) =>
                                FlDotCirclePainter(
                                  radius: 4,
                                  color: isDark
                                      ? const Color(0xFF1A1A2E)
                                      : Colors.white,
                                  strokeWidth: 2,
                                  strokeColor: const Color(0xFF7F73E6),
                                ),
                          ),
                          belowBarData: BarAreaData(
                            show: true,
                            gradient: LinearGradient(
                              colors: [
                                const Color(0xFF7F73E6).withOpacity(0.3),
                                const Color(0xFF7F73E6).withOpacity(0.0),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
