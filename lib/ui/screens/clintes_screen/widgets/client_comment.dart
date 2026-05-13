import 'package:flutter/material.dart';
import 'package:targetly/ui/shared/boutton.dart';

class ClientComment extends StatelessWidget {
  const ClientComment({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Comments'),

      content: SizedBox(
        width: double.maxFinite,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListView(
              shrinkWrap: true,
              children: const [
                Text('comment 1'),
                Text('comment 2'),
                Text('comment 3'),
              ],
            ),

            const SizedBox(height: 20),

            Sharedboutton(
              text: 'Add Comment',

              onTap: () {
                showDialog(
                  context: context,

                  builder: (context) {
                    return AlertDialog(
                      title: const Text('Add Comment'),

                      content: const TextField(
                        decoration: InputDecoration(
                          hintText: 'Enter your comment',
                        ),
                      ),

                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: const Text('Cancel'),
                        ),

                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },

                          child: const Text('Submit'),
                        ),
                      ],
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
