import 'package:flutter/material.dart';

class ApoutSection extends StatelessWidget {
  const ApoutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Text(
          "Targetly CRM",
          style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w600),
        ),

        SizedBox(height: 4),

        Text("Version 1.0.0", style: TextStyle(color: Colors.grey)),
      ],
    );
  }
}
