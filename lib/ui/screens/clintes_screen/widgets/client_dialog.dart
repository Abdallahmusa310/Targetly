import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/ui/shared/dialog.dart';
import 'package:targetly/ui/shared/text_field.dart';

class Clientdialog extends StatefulWidget {
  const Clientdialog({super.key});

  @override
  State<Clientdialog> createState() => _ClientdialogState();
}

class _ClientdialogState extends State<Clientdialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController clientname = TextEditingController();
  final TextEditingController clientphone = TextEditingController();
  final TextEditingController clientfees = TextEditingController();
  final TextEditingController clientid = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SharedDialog(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            /// HEADER
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff9367FA).withOpacity(.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.person_add_alt_1,
                    color: Color(0xff9367FA),
                  ),
                ),
                const SizedBox(width: 12),
                Text(
                  'Add Client'.tr(),
                  style: const TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SharedTextFeild(
              controller: clientname,
              hintText: 'Client Name'.tr(),
              obscureText: false,
              prefixIcon: const Icon(Icons.person),
              validator: (name) {
                if (name == null || name.isEmpty) {
                  return 'Enter client name'.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            SharedTextFeild(
              controller: clientphone,
              hintText: 'Client Phone'.tr(),
              obscureText: false,
              prefixIcon: const Icon(Icons.phone),
              keyboardType: TextInputType.number,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              validator: (phone) {
                if (phone == null || phone.isEmpty) {
                  return 'Enter client phone'.tr();
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            SharedTextFeild(
              controller: clientid,
              hintText: 'Client ID'.tr(),
              obscureText: false,
              prefixIcon: const Icon(Icons.badge),
            ),

            const SizedBox(height: 16),

            SharedTextFeild(
              controller: clientfees,
              hintText: 'Client Fees'.tr(),
              obscureText: false,
              prefixIcon: const Icon(Icons.attach_money),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
              ],
            ),

            const SizedBox(height: 28),

            /// BUTTONS
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff9367FA),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        context.read<ClinetCubit>().addclient(
                          name: clientname.text.trim(),
                          phone: clientphone.text.trim(),
                          fees: clientfees.text.trim().isEmpty
                              ? null
                              : clientfees.text.trim(),
                          id: clientid.text.trim().isEmpty
                              ? null
                              : clientid.text.trim(),
                          activityCubit: context.read<ActivityCubit>(),
                        );

                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Add'.tr(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text('Cancel'.tr()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    clientname.dispose();
    clientphone.dispose();
    clientfees.dispose();
    clientid.dispose();
    super.dispose();
  }
}
