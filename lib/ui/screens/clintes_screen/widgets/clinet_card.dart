import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/ui/screens/auth_screens/reset_password_screen/confirm_message.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/call_client.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/client_comment_dialog.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/client_details_dialog.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/edit_client_sheet.dart';

import 'package:easy_localization/easy_localization.dart';

class ClinetCard extends StatelessWidget {
  const ClinetCard({super.key, required this.clinetModel});
  final ClinetModel clinetModel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onDoubleTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ClientCommentdialog(client: clinetModel);
          },
        );
      },
      onTap: () {
        showDialog(
          context: context,
          builder: (context) {
            return ClinetDetailsDialog(clinetModel: clinetModel);
          },
        );
      },
      child: Slidable(
        startActionPane: ActionPane(
          motion: const ScrollMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => EditClientdialog(client: clinetModel),
                );
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.edit,
              label: 'Edit'.tr(),
            ),
            SlidableAction(
              onPressed: (context) {
                showDialog(
                  context: context,
                  builder: (context) => ConfirmMessage(
                    onConfirm: () async {
                      Navigator.pop(context);
                      context.read<ClinetCubit>().deleteClient(clinetModel);
                    },
                  ),
                );
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
              label: 'Delete'.tr(),
            ),
          ],
        ),
        child: Card(
          elevation: 2,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              clinetModel.clinetname,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              clinetModel.clinetid ?? 'No ID'.tr(),
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        clinetModel.clinetphone,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    ],
                  ),
                ),
                CallClient(clinetModel: clinetModel),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
