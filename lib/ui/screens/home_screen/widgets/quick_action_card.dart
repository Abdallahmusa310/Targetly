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
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: ontap,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 22,
                  backgroundColor: iconcolor,
                  child: IconButton(onPressed: ontap, icon: iconcard),
                ),

                const SizedBox(width: 14),

                Expanded(
                  child: Text(
                    textcard,
                    textAlign: TextAlign.start,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
