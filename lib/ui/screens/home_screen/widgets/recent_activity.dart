import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_state.dart';
import 'package:targetly/ui/screens/home_screen/widgets/build_recent_activity_item.dart';

class BuildRecentActivity extends StatelessWidget {
  const BuildRecentActivity({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Card(
      elevation: 4,
      color: isDark ? const Color.fromARGB(255, 39, 39, 70) : Colors.white,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recent Activity'.tr(),
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: isDark ? Colors.white : const Color(0xff2B1E5E),
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    context.read<ActivityCubit>().clearActivities();
                  },
                  icon: const Icon(
                    Icons.delete_outline,
                    size: 18,
                    color: Colors.red,
                  ),
                  label: Text(
                    'Clear'.tr(),
                    style: const TextStyle(color: Colors.red),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            BlocBuilder<ActivityCubit, ActivityState>(
              builder: (context, state) {
                if (state is ActivityLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is ActivitySuccess) {
                  if (state.activities.isEmpty) {
                    return Text(
                      'No recent activity'.tr(),
                      style: TextStyle(
                        color: isDark ? Colors.white54 : Colors.grey,
                      ),
                    );
                  }

                  return Column(
                    children: state.activities
                        .map((a) => BuildRecentActivityItem(text: a.text))
                        .toList(),
                  );
                }

                if (state is ActivityFailure) {
                  return Text(
                    '${'Error'.tr()}: ${state.message}',
                    style: const TextStyle(color: Colors.red),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
