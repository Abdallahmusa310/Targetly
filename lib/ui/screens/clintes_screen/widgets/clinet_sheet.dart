import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/floating_action_boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class ClinetSheet extends StatelessWidget {
  const ClinetSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            child: Column(
              children: [
                const SizedBox(height: 15),
                SharedTextFeild(
                  obscureText: false,
                  hintText: 'Client Name',
                  prefixIcon: Icon(Icons.person),
                ),
                SizedBox(height: 16),
                SharedTextFeild(
                  obscureText: false,
                  hintText: 'Client phone',
                  prefixIcon: Icon(Icons.phone),
                ),
                SizedBox(height: 16),
                SharedTextFeild(
                  obscureText: false,
                  hintText: 'Client id',
                  prefixIcon: Icon(Icons.key),
                ),
                SizedBox(height: 16),
                SharedFloatingActionButton(
                  onPressed: () {},
                  lable: Text('Add Client'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
