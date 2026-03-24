import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/floating_action_boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class ClinetSheet extends StatelessWidget {
  const ClinetSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Form(
      key: formKey,

      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              child: Column(
                children: [
                  const SizedBox(height: 15),
                  SharedTextFeild(
                    validator: (name) {
                      if (name == null || name.isEmpty) {
                        return "Enter your email";
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
                        return 'Enter client phone';
                      }
                      return null;
                    },
                    obscureText: false,
                    hintText: 'Client id',
                    prefixIcon: Icon(Icons.key),
                  ),
                  SizedBox(height: 16),
                  SharedFloatingActionButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        Navigator.pop(context);
                      }
                      return null;
                    },
                    lable: Text('Add Client'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
