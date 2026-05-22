import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:targetly/ui/shared/formate_numpers.dart';

class TargetProgress extends StatelessWidget {
  const TargetProgress({
    super.key,
    required this.achieved,
    required this.target,
  });

  final double achieved;
  final double target;

  @override
  Widget build(BuildContext context) {
    final progress = target == 0 ? 0.0 : (achieved / target).clamp(0.0, 1.0);
    final percentage = (progress * 100).toLocalizedString(context);

    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              "target_progress_title".tr(),
              style: const TextStyle(fontSize: 18, color: Color(0xff8F92C2)),
            ),

            const SizedBox(height: 8),

            LinearProgressIndicator(
              value: progress,
              minHeight: 10,
              valueColor: AlwaysStoppedAnimation<Color>(
                progress >= 1 ? Colors.green : const Color(0xFF7F73E6),
              ),
            ),

            const SizedBox(height: 8),

            Text(
              "$percentage %",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
