import 'package:flutter/material.dart';

class BuildStatCard extends StatelessWidget {
  const BuildStatCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    required this.value,
    this.textfont,
  });
  final String title, value;
  final Widget icon;
  final Color color;
  final double? textfont;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(radius: 18, backgroundColor: color, child: icon),
                SizedBox(width: 6),
                FittedBox(
                  fit: BoxFit.scaleDown,

                  child: Text(
                    title,
                    style: TextStyle(
                      fontSize: textfont ?? 16,
                      fontWeight: FontWeight.w600,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                value,
                style: TextStyle(
                  color: Color.fromARGB(255, 0, 0, 0),
                  fontSize: textfont ?? 23,
                ),
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
