import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class ClinetSheet extends StatefulWidget {
  const ClinetSheet({super.key});

  @override
  State<ClinetSheet> createState() => _ClinetSheetState();
}

class _ClinetSheetState extends State<ClinetSheet> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                const SizedBox(height: 15),
                SharedTextFeild(
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return "Enter clinet name";
                    }
                    return null;
                  },
                  obscureText: false,
                  hintText: 'Client Name',
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 16),
                SharedTextFeild(
                  validator: (clinetphone) {
                    if (clinetphone == null || clinetphone.isEmpty) {
                      return 'Enter client phone';
                    }
                    return null;
                  },
                  obscureText: false,
                  hintText: 'Client phone',
                  prefixIcon: Icon(Icons.phone),
                ),
                SizedBox(height: 16),
                SharedTextFeild(
                  validator: (clinetid) {
                    if (clinetid == null || clinetid.isEmpty) {
                      return 'Enter client id';
                    }
                    return null;
                  },
                  obscureText: false,
                  hintText: 'Client id',
                  prefixIcon: Icon(Icons.key),
                ),
                SizedBox(height: 16),
                SharedTextFeild(
                  validator: (name) {
                    if (name == null || name.isEmpty) {
                      return "Enter clinet fees";
                    }
                    return null;
                  },
                  obscureText: false,
                  hintText: 'Client fees',
                  prefixIcon: Icon(Icons.money),
                ),
                SizedBox(height: 16),
                Sharedboutton(
                  text: 'Add clinet',
                  onTap: () {
                    if (formKey.currentState!.validate()) {
                      Navigator.pop(context);
                    }
                    null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
