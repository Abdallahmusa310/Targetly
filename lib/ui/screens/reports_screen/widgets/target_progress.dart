import 'package:flutter/material.dart';

class TargetProgress extends StatelessWidget {
  const TargetProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'Targer progress',
              style: TextStyle(fontSize: 18, color: Color(0xff8F92C2)),
            ),
            SizedBox(height: 8),

            LinearProgressIndicator(value: 0.75, minHeight: 10),
            SizedBox(height: 8),
            Text(
              "75%",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
