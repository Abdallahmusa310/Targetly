import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
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
                  child: const Icon(Icons.edit, color: Color(0xff9367FA)),
                ),
                const SizedBox(width: 12),
                const Text(
                  'Edit Client',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
              ],
            ),

            const SizedBox(height: 24),

            /// NAME
            SharedTextFeild(
              obscureText: false,
              controller: nameController,
              hintText: 'Client Name',
              prefixIcon: const Icon(Icons.person),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter client name";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            /// PHONE
            SharedTextFeild(
              obscureText: false,
              controller: phoneController,
              hintText: 'Client Phone',
              prefixIcon: const Icon(Icons.phone),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "Enter client phone";
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            /// ID
            SharedTextFeild(
              obscureText: false,
              controller: idController,
              hintText: 'Client ID',
              prefixIcon: const Icon(Icons.badge),
            ),

            const SizedBox(height: 16),

            /// FEES
            SharedTextFeild(
              obscureText: false,
              controller: feesController,
              hintText: 'Client Fees',
              prefixIcon: const Icon(Icons.attach_money),
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
                        widget.client.clinetname = nameController.text.trim();
                        widget.client.clinetphone = phoneController.text.trim();
                        widget.client.clinetfees = feesController.text.trim();
                        widget.client.clinetid = idController.text.trim();

                        widget.client.save();

                        context.read<ClinetCubit>().fetchClients();
                        Navigator.pop(context);
                      }
                    },
                    child: const Text(
                      'Save',
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
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
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
