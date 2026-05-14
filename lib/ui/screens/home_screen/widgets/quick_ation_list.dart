import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/target/target_cubit/cubit/target_cubit.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/client_dialog.dart';
import 'package:targetly/ui/screens/home_screen/widgets/quick_action_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/target_dialog.dart';
import 'package:targetly/ui/screens/reports_screen/reports_screen.dart';

class QuickAtionList extends StatelessWidget {
  const QuickAtionList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            QuickActionCard(
              ontap: () {
                showDialog(
                  context: context,
                  builder: (context) => const Clientdialog(),
                );
              },

              textcard: 'Add client',
              iconcard: Icon(Icons.person_add_alt_1, color: Colors.white),
              iconcolor: Color(0xFF5B5F97),
            ),
            QuickActionCard(
              ontap: () {
                final targetState = context.read<TargetCubit>().state;

                if (targetState is TargetSuccess &&
                    targetState.target != null) {
                  final target = targetState.target!;

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ReportsScreen(
                        initialStart: target.startDate,
                        initialEnd: target.endDate,
                      ),
                    ),
                  );
                }
              },
              textcard: 'View report',
              iconcard: Icon(Icons.assessment, color: Colors.white),
              iconcolor: Color.fromARGB(255, 13, 157, 201),
            ),
            QuickActionCard(
              ontap: () {
                showDialog(
                  context: context,
                  builder: (context) => const Targetdialog(),
                );
              },
              textcard: 'update target',
              iconcard: Icon(Icons.arrow_circle_up, color: Colors.white),
              iconcolor: Color(0xFF5B5F97),
            ),
          ],
        ),
      ),
    );
  }
}

// abali2792004@gmail.com
