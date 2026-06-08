import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/dialog.dart';
import 'package:targetly/ui/shared/formate_numpers.dart';

class ComissionDialog extends StatelessWidget {
  const ComissionDialog({
    super.key,
    required this.commissionValue,
    required this.commissionPercent,
    required this.totalFees,
    this.start,
    this.end,
  });

  final double commissionValue;
  final double commissionPercent;
  final double totalFees;
  final DateTime? start;
  final DateTime? end;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final now = DateTime.now();
    final daysRemaining = end != null
        ? end!.difference(now).inDays.clamp(0, double.infinity).toInt()
        : 0;

    return SharedDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xFF5B5F97).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.monetization_on,
                  color: Color(0xFF5B5F97),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Commission'.tr(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xff2B1E5E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Divider(color: isDark ? Colors.white12 : Colors.grey.shade300),
          const SizedBox(height: 12),
          _commissionRow(
            icon: Icons.percent,
            title: 'Commission rate'.tr(),
            value: '$commissionPercent%',
            color: const Color(0xFF5B5F97),
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _commissionRow(
            icon: Icons.monetization_on,
            title: 'Total sales'.tr(),
            value: totalFees.toLocalizedString(context),
            color: const Color.fromARGB(255, 13, 157, 201),
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _commissionRow(
            icon: Icons.account_balance_wallet,
            title: 'Commission earned'.tr(),
            value: commissionValue.toLocalizedString(context),
            color: Colors.green,
            isDark: isDark,
          ),
          const SizedBox(height: 12),
          _commissionRow(
            icon: Icons.calendar_today,
            title: 'Days remaining'.tr(),
            value: daysRemaining.toLocalizedString(context),
            color: daysRemaining <= 5 ? Colors.red : const Color(0xFF5B5F97),
            isDark: isDark,
          ),
          const SizedBox(height: 20),
          Divider(color: isDark ? Colors.white12 : Colors.grey.shade300),
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                side: BorderSide(
                  color: isDark ? Colors.white24 : const Color(0xFF7F73E6),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Close'.tr(),
                style: TextStyle(
                  color: isDark ? Colors.white70 : const Color(0xFF7F73E6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _commissionRow({
    required IconData icon,
    required String title,
    required String value,
    required Color color,
    required bool isDark,
  }) {
    return Row(
      children: [
        CircleAvatar(
          radius: 18,
          backgroundColor: color.withOpacity(0.1),
          child: Icon(icon, color: color, size: 18),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            title,
            style: TextStyle(
              color: isDark ? Colors.white54 : Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );
  }
}
