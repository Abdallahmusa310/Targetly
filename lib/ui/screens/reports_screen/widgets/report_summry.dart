import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/report_card.dart';

class ReportSummry extends StatelessWidget {
  const ReportSummry({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Report Summary',
          style: TextStyle(fontSize: 18, color: Color(0xff8F92C2)),
        ),
        const SizedBox(height: 20),

        GridView.count(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 1.4,
          children: [
            Reportcard(title: 'Clients', value: '24'),
            Reportcard(title: 'Remaning', value: '50,000'),
            Reportcard(title: 'Sales', value: '120,000'),
            Reportcard(title: 'comission', value: '3,500'),
          ],
        ),
      ],
    );
  }
}
