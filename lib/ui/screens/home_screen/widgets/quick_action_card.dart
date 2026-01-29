import 'package:flutter/material.dart';

class QuickActionCard extends StatelessWidget {
  const QuickActionCard({
    super.key,
    required this.iconcard,
    required this.textcard,
    required this.iconcolor,
  });

  final Widget iconcard;
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
              child: IconButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('تم الحفظ بنجاح'),
                      duration: Duration(seconds: 2),
                    ),
                  );
                },
                icon: iconcard,
              ),
            ),
          ),

          Padding(padding: const EdgeInsets.all(8), child: Text(textcard)),
        ],
      ),
    );
  }
}
