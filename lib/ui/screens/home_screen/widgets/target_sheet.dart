import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/floating_action_boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class TargetSheet extends StatefulWidget {
  const TargetSheet({super.key});

  @override
  State<TargetSheet> createState() => _TargetSheetState();
}

class _TargetSheetState extends State<TargetSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

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
                  validator: (target) {
                    if (target == null || target.isEmpty) {
                      return "Enter your email";
                    }
                    return null;
                  },
                  obscureText: false,
                  hintText: 'Your target',
                  prefixIcon: Icon(Icons.money),
                ),
                SizedBox(height: 16),
                SharedTextFeild(
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
                SharedFloatingActionButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                  },
                  lable: Text('Set target'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
