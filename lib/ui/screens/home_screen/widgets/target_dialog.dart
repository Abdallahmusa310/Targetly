import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/home_screen/widgets/date_range.dart';
import 'package:targetly/ui/shared/dialog.dart';
import 'package:targetly/ui/shared/text_field.dart';

class Targetdialog extends StatefulWidget {
  const Targetdialog({super.key});

  @override
  State<Targetdialog> createState() => _TargetdialogState();
}

class _TargetdialogState extends State<Targetdialog> {
  late TextEditingController targetController;
  late TextEditingController commissionController;

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

    startDate = targetModel?.startDate;
    endDate = targetModel?.endDate;
  }

  @override
  Widget build(BuildContext context) {
    return SharedDialog(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// HEADER
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF5B5F97).withOpacity(.1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: const Icon(
                    Icons.arrow_circle_up,
                    color: Color(0xFF5B5F97),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Text(
                    "Set Your Target".tr(),
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 28),

            /// TARGET FIELD
            SharedTextFeild(
              controller: targetController,
              keyboardType: TextInputType.number,
              obscureText: false,
              hintText: "Your target".tr(),
              prefixIcon: const Icon(Icons.attach_money),
              validator: (target) {
                if (target == null || target.isEmpty) {
                  return "Enter your target".tr();
                }
                return null;
              },
            ),

            const SizedBox(height: 18),

            /// COMMISSION FIELD
            SharedTextFeild(
              controller: commissionController,
              keyboardType: TextInputType.number,
              obscureText: false,
              hintText: "Commission percentage".tr(),
              prefixIcon: const Icon(Icons.percent),
              validator: (commission) {
                if (commission == null || commission.isEmpty) {
                  return "Enter your commission".tr();
                }
                return null;
              },
            ),

            const SizedBox(height: 20),

            /// DATE RANGE
            DateRangeField(
              initialStart: startDate,
              initialEnd: endDate,
              onChanged: (start, end) {
                startDate = start;
                endDate = end;
              },
            ),

            const SizedBox(height: 30),

            /// BUTTONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF5B5F97),
                      elevation: 0,
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      if (!formKey.currentState!.validate()) {
                        return;
                      }

                      if (startDate == null || endDate == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please select date range".tr()),
                          ),
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
                    child: Text(
                      "Save".tr(),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Cancel".tr()),
                  ),
                ),
              ],
            ),
          ],
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
