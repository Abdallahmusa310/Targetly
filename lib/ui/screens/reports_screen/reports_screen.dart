import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/calender.dart';
import 'package:targetly/ui/screens/reports_screen/widgets/report_summary.dart';

class ReportsScreen extends StatelessWidget {
  const ReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          ' Sales Reports ',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Calender(),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ReportSummary(
                    iconcard: Icons.people,
                    textcard: 'Clintes : 29',
                    iconcolor: Color(0xFF5B5F97),
                  ),
                  ReportSummary(
                    iconcard: Icons.monetization_on,
                    textcard: 'Comission : 29000',
                    iconcolor: Color(0xFF5B5F97),
                  ),
                  ReportSummary(
                    iconcard: Icons.money,
                    textcard: 'total sales : 160000',
                    iconcolor: Color(0xFF5B5F97),
                  ),
                ],
              ),
              SizedBox(height: 16),
              Column(
                children: [
                  Text(' target'),
                  CircularPercentIndicator(
                    radius: 100,
                    lineWidth: 10,
                    percent: 0.7,
                    center: Text('70%'),

                    progressColor: Color(0xFF5B5F97),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
