import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/home_screen/widgets/state_card.dart';

class StatList extends StatelessWidget {
  const StatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildStatCard(
          'Comission',
          '1500',
          Icon(Icons.monetization_on, color: Colors.white),
          Color(0xFF5B5F97),
        ),
        SizedBox(width: 16),
        buildStatCard(
          'clintes',
          '350',
          Icon(Icons.people, color: Colors.white),
          Color.fromARGB(255, 13, 157, 201),
        ),
      ],
    );
  }
}
