import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/home_screen/widgets/date_range.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class TargetSheet extends StatefulWidget {
  const TargetSheet({super.key});

  @override
  State<TargetSheet> createState() => _TargetSheetState();
}

class _TargetSheetState extends State<TargetSheet> {
  late TextEditingController targetController, commissionController;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();

    final targetModel = context.read<TargetCubit>().targetModel;

    targetController = TextEditingController(
      text: targetModel?.target.toString() ?? "",
    );

    commissionController = TextEditingController(
      text: targetModel?.commission.toString() ?? "",
    );

    /// 🔥 مهم عشان الـ edit
    startDate = targetModel?.startDate;
    endDate = targetModel?.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: formKey,
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),

              /// 🎯 Target
              SharedTextFeild(
                keyboardType: TextInputType.number,
                controller: targetController,
                validator: (target) {
                  if (target == null || target.isEmpty) {
                    return "Enter your target";
                  }
                  return null;
                },
                obscureText: false,
                hintText: 'Your target',
                prefixIcon: const Icon(Icons.money),
              ),

              const SizedBox(height: 16),

              /// 💰 Commission
              SharedTextFeild(
                keyboardType: TextInputType.number,
                controller: commissionController,
                validator: (comission) {
                  if (comission == null || comission.isEmpty) {
                    return "Enter your commission percent";
                  }
                  return null;
                },
                obscureText: false,
                hintText: 'Commission percentage',
                prefixIcon: const Icon(Icons.percent),
              ),

              const SizedBox(height: 16),

              /// 📅 Date Range
              DateRangeField(
                initialStart: startDate,
                initialEnd: endDate,
                onChanged: (start, end) {
                  startDate = start;
                  endDate = end;
                },
              ),

              const SizedBox(height: 20),

              /// 🔘 Button
              Sharedboutton(
                text: 'Set Target',
                onTap: () {
                  if (!formKey.currentState!.validate()) return;

                  /// 🔥 Validation مهم
                  if (startDate == null || endDate == null) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Please select date range")),
                    );
                    return;
                  }

                  context.read<TargetCubit>().setTarget(
                    target: double.parse(targetController.text),
                    commission: double.parse(commissionController.text),
                    startDate: startDate!,
                    endDate: endDate!,
                    activityCubit: context.read<ActivityCubit>(),
                  );

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    targetController.dispose();
    commissionController.dispose();
    super.dispose();
  }
}
