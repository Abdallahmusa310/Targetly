import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 15),
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
                  prefixIcon: Icon(Icons.money),
                ),
                SizedBox(height: 16),
                SharedTextFeild(
                  keyboardType: TextInputType.number,
                  controller: commissionController,
                  validator: (comission) {
                    if (comission == null || comission.isEmpty) {
                      return "Enter your comission percent";
                    }
                    return null;
                  },
                  obscureText: false,
                  hintText: 'Comission percentge',
                  prefixIcon: Icon(Icons.percent),
                ),
                SizedBox(height: 16),
                Sharedboutton(
                  text: 'set target',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      context.read<TargetCubit>().setTarget(
                        target: double.parse(targetController.text),
                        commission: double.parse(commissionController.text),
                      );
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    targetController.dispose();
    commissionController.dispose();
    super.dispose();
  }
}
