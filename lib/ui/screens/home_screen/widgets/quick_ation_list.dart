import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_sheet.dart';
import 'package:targetly/ui/screens/home_screen/widgets/quick_action_card.dart';
import 'package:targetly/ui/screens/home_screen/widgets/target_sheet.dart';

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
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: ClinetSheet(),
                    );
                  },
                );
              },
              textcard: 'Add client',
              iconcard: Icon(Icons.add, color: Colors.white),
              iconcolor: Color(0xFF5B5F97),
            ),
            QuickActionCard(
              ontap: () {
                Navigator.pushNamed(context, '/reports');
              },
              textcard: 'View report',
              iconcard: Icon(Icons.assessment, color: Colors.white),
              iconcolor: Color.fromARGB(255, 13, 157, 201),
            ),
            QuickActionCard(
              ontap: () {
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(
                          bottom: MediaQuery.of(context).viewInsets.bottom,
                        ),
                        child: const TargetSheet(),
                      ),
                    );
                  },
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
