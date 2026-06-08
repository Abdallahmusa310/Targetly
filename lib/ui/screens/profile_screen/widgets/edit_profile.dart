import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/user/cubit/user_cubit.dart';

class ProfileDialog extends StatelessWidget {
  final String currentUsername;
  final String currentJobTitle;
  final VoidCallback? onSaved;

  ProfileDialog({
    super.key,
    required this.currentUsername,
    required this.currentJobTitle,
    this.onSaved,
  });

  final TextEditingController nameController = TextEditingController();
  final TextEditingController jobController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    nameController.text = currentUsername;
    jobController.text = currentJobTitle;

    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text('edit_profile'.tr()),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(
              labelText: 'Name'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: jobController,
            decoration: InputDecoration(
              labelText: 'job_title'.tr(),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('cancel'.tr()),
        ),
        ElevatedButton(
          onPressed: () {
            context.read<UserCubit>().saveUser(
              username: nameController.text.trim(),
              jobTitle: jobController.text.trim(),
            );
            Navigator.pop(context);
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF7F73E6),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: Text('save'.tr()),
        ),
      ],
    );
  }
}
