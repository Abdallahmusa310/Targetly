import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class ConfirmMessage extends StatelessWidget {
  const ConfirmMessage({super.key, required this.onConfirm});

  final Future<void> Function()? onConfirm;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Confirm".tr()),
      content: Text("Are you sure?".tr()),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text("Cancel".tr()),
        ),
        TextButton(
          onPressed: () async {
            if (onConfirm != null) {
              await onConfirm!();
            }
          },
          child: Text("Confirm".tr(), style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
