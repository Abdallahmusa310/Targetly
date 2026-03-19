import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/home_screen/widgets/state_card.dart';

class StatList extends StatelessWidget {
  const StatList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BuildStatCard(
          title: 'Comission',
          value: '1500',
          icon: Icon(Icons.monetization_on, color: Colors.white),
          color: Color(0xFF5B5F97),
        ),
        SizedBox(width: 16),
        BuildStatCard(
          title: 'clintes',
          value: '350',
          icon: Icon(Icons.people, color: Colors.white),
          color: Color.fromARGB(255, 13, 157, 201),
        ),
      ],
    );
  }
}
