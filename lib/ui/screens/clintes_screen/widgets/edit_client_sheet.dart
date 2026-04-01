import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class EditClientSheet extends StatefulWidget {
  const EditClientSheet({super.key, required this.client});
  final ClinetModel client;

  @override
  State<EditClientSheet> createState() => _EditClientSheetState();
}

class _EditClientSheetState extends State<EditClientSheet> {
  TextEditingController? nameController,
      phoneController,
      feesController,
      idController;
  String? clientname, clientphone, clientfees, clientid;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
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
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 15),
              CloseButton(
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 15),

              /// 👤 Name
              SharedTextFeild(
                controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter client name";
                  }
                  return null;
                },
                obscureText: false,
                hintText: 'Client Name',
                prefixIcon: const Icon(Icons.person),
                onChanged: (value) {
                  clientname = value;
                },
              ),

              const SizedBox(height: 16),

              /// 📞 Phone
              SharedTextFeild(
                controller: phoneController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter client phone';
                  }
                  return null;
                },
                onChanged: (value) {
                  clientphone = value;
                },
                obscureText: false,
                hintText: 'Client phone',
                prefixIcon: const Icon(Icons.phone),
              ),

              const SizedBox(height: 16),

              /// 🆔 ID
              SharedTextFeild(
                controller: idController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter client id';
                  }
                  return null;
                },
                onChanged: (value) {
                  clientid = value;
                },
                obscureText: false,
                hintText: 'Client id',
                prefixIcon: const Icon(Icons.key),
              ),

              const SizedBox(height: 16),

              /// 💰 Fees
              SharedTextFeild(
                controller: feesController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return "Enter client fees";
                  }
                  return null;
                },
                onChanged: (value) {
                  clientfees = value;
                },
                obscureText: false,
                hintText: 'Client fees',
                prefixIcon: const Icon(Icons.money),
              ),

              const SizedBox(height: 20),

              /// 🔘 Button
              Sharedboutton(
                text: 'Save',
                onTap: () {
                  if (formKey.currentState!.validate()) {
                    widget.client.clinetname =
                        clientname ?? widget.client.clinetname;
                    widget.client.clinetphone =
                        clientphone ?? widget.client.clinetphone;
                    widget.client.clinetfees =
                        clientfees ?? widget.client.clinetfees;
                    widget.client.clinetid = clientid ?? widget.client.clinetid;
                    widget.client.save();

                    BlocProvider.of<ClinetCubit>(context).fetchClients();
                  }
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
