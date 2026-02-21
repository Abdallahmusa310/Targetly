import 'package:flutter/material.dart';

class ReportSummary extends StatelessWidget {
  const ReportSummary({
    super.key,
    required this.iconcard,
    required this.textcard,
    required this.iconcolor,
  });

  final IconData iconcard;
  final String textcard;
  final Color iconcolor;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.all(12),
            child: CircleAvatar(
              radius: 20,
              backgroundColor: iconcolor,
              child: Icon(iconcard, color: Colors.white),
            ),
          ),

          Padding(padding: const EdgeInsets.all(8), child: Text(textcard)),
        ],
      ),
    );
  }
}
