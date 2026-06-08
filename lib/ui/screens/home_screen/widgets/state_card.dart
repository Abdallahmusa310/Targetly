import 'package:flutter/material.dart';

class BuildStatCard extends StatelessWidget {
  const BuildStatCard({
    super.key,
    required this.icon,
    required this.color,
    required this.title,
    this.value,
    this.textfont,
    this.onTap,
  });
  final String? title, value;
  final Widget icon;
  final Color color;
  final double? textfont;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return InkWell(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        elevation: 4,
        color: isDark ? const Color.fromARGB(255, 39, 39, 70) : Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(radius: 18, backgroundColor: color, child: icon),
                  const SizedBox(width: 6),
                  FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      title ?? "",
                      style: TextStyle(
                        fontSize: textfont ?? 16,
                        fontWeight: FontWeight.w600,
                        color: isDark ? Colors.white : const Color(0xff2B1E5E),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ),
                ],
              ),
              Center(
                child: Text(
                  value ?? "",
                  style: TextStyle(
                    color: isDark ? Colors.white70 : Colors.black,
                    fontSize: textfont ?? 23,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
