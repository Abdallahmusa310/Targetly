import 'package:flutter/material.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.iconcard,
    required this.textcard,
    required this.iconcolor,
    required this.ontap,
  });

  final Widget iconcard;
  final String textcard;
  final Color iconcolor;
  final void Function() ontap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Card(
        elevation: 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(12),
              child: CircleAvatar(
                radius: 20,
                backgroundColor: iconcolor,
                child: IconButton(onPressed: ontap, icon: iconcard),
              ),
            ),

            Padding(padding: const EdgeInsets.all(8), child: Text(textcard)),
          ],
        ),
      ),
    );
  }
}
