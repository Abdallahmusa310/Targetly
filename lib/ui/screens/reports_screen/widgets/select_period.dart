import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/date_card.dart';
import 'package:targetly/ui/shared/boutton.dart';

class SelectPeriod extends StatelessWidget {
  const SelectPeriod({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select period',
          style: TextStyle(fontSize: 18, color: Color(0xff8F92C2)),
        ),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(
              child: DateCard(title: "Start Date", date: "01 May 2024"),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: DateCard(title: "End Date", date: "31 May 2024"),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Sharedboutton(
          text: 'Generate Report',
          onTap: () {},
          borderRadius: 12,
          width: double.infinity,
          height: 50,
        ),
      ],
    );
  }
}
