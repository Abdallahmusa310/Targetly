import 'package:flutter/material.dart';

class ConfirmMessage extends StatelessWidget {
  const ConfirmMessage({super.key, required this.onConfirm});

  final Future<void> Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Confirm"),
      content: const Text("Are you sure?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            if (onConfirm != null) {
              await onConfirm!();
            }
          },
          child: const Text("Confirm", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
