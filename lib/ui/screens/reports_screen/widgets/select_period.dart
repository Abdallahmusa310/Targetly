import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/home_screen/widgets/date_range.dart';
import 'package:targetly/ui/shared/boutton.dart';

class SelectPeriod extends StatefulWidget {
  const SelectPeriod({super.key, required this.onGenerate});

  final Function(DateTime start, DateTime end) onGenerate;

  @override
  State<SelectPeriod> createState() => _SelectPeriodState();
}

class _SelectPeriodState extends State<SelectPeriod> {
  DateTime? selectedStart;
  DateTime? selectedEnd;

  @override
  void initState() {
    super.initState();
    final targetModel = context.read<TargetCubit>().targetModel;
    selectedStart = targetModel?.startDate;
    selectedEnd = targetModel?.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        /// 📅 Date Range
        DateRangeField(
          initialStart: selectedStart,
          initialEnd: selectedEnd,
          onChanged: (start, end) {
            selectedStart = start;
            selectedEnd = end;
          },
        ),

        const SizedBox(height: 16),

        /// 🔘 Generate Button
        Sharedboutton(
          text: "generate_report_btn".tr(),
          onTap: () {
            if (selectedStart == null || selectedEnd == null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("select_valid_date_range_error".tr())),
              );
              return;
            }

            widget.onGenerate(selectedStart!, selectedEnd!);
          },
          borderRadius: 12,
          width: double.infinity,
          height: 50,
        ),
      ],
    );
  }
}
