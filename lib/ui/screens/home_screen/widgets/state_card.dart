import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_card.dart';
import 'package:targetly/ui/shared/dialog.dart';

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
    return InkWell(
      onTap: onTap,
      child: Card(
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
                      title ?? "",
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
                  value ?? "",
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
      ),
    );
  }
}
