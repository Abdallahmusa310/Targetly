import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/logic/Clients/cubit/client_cubit.dart';
import 'package:targetly/ui/shared/dialog.dart';
import 'package:targetly/ui/shared/text_field.dart';

class EditClientdialog extends StatefulWidget {
  const EditClientdialog({super.key, required this.client});
  final ClinetModel client;

  @override
  State<EditClientdialog> createState() => _EditClientdialogState();
}

class _EditClientdialogState extends State<EditClientdialog> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController phoneController;
  late TextEditingController feesController;
  late TextEditingController idController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.client.clinetname);
    phoneController = TextEditingController(text: widget.client.clinetphone);
    feesController = TextEditingController(text: widget.client.clinetfees);
    idController = TextEditingController(text: widget.client.clinetid);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SharedDialog(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xff9367FA).withOpacity(.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(Icons.edit, color: Color(0xff9367FA)),
                ),
                const SizedBox(width: 12),
                Text(
                  'Edit Client'.tr(),
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: isDark ? Colors.white : const Color(0xff2B1E5E),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 24),

            SharedTextFeild(
              obscureText: false,
              controller: nameController,
              hintText: 'Client Name'.tr(),
              prefixIcon: Icon(
                Icons.person,
                color: isDark ? Colors.white54 : const Color(0xff969ACA),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter client name";
                return null;
              },
            ),

            const SizedBox(height: 16),

            SharedTextFeild(
              obscureText: false,
              controller: phoneController,
              hintText: 'Client Phone'.tr(),
              prefixIcon: Icon(
                Icons.phone,
                color: isDark ? Colors.white54 : const Color(0xff969ACA),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) return "Enter client phone";
                return null;
              },
            ),

            const SizedBox(height: 16),

            SharedTextFeild(
              obscureText: false,
              controller: idController,
              hintText: 'Client ID'.tr(),
              prefixIcon: Icon(
                Icons.badge,
                color: isDark ? Colors.white54 : const Color(0xff969ACA),
              ),
            ),

            const SizedBox(height: 16),

            SharedTextFeild(
              obscureText: false,
              controller: feesController,
              hintText: 'Client Fees'.tr(),
              prefixIcon: Icon(
                Icons.attach_money,
                color: isDark ? Colors.white54 : const Color(0xff969ACA),
              ),
            ),

            const SizedBox(height: 28),

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
                        widget.client.clinetname = nameController.text.trim();
                        widget.client.clinetphone = phoneController.text.trim();
                        widget.client.clinetfees = feesController.text.trim();
                        widget.client.clinetid = idController.text.trim();
                        widget.client.save();
                        context.read<ClinetCubit>().fetchClients();
                        Navigator.pop(context);
                      }
                    },
                    child: Text(
                      'Save'.tr(),
                      style: TextStyle(
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
                      side: BorderSide(
                        color: isDark
                            ? Colors.white24
                            : const Color(0xff9367FA),
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      'Cancel'.tr(),
                      style: TextStyle(
                        color: isDark
                            ? Colors.white70
                            : const Color(0xff9367FA),
                      ),
                    ),
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
    nameController.dispose();
    phoneController.dispose();
    feesController.dispose();
    idController.dispose();
    super.dispose();
  }
}
