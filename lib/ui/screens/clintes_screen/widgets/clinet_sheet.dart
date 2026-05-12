import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/logic/activity/cubit/recentactivity_cubit.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class ClinetSheet extends StatefulWidget {
  const ClinetSheet({super.key});
  @override
  State<ClinetSheet> createState() => _ClinetSheetState();
}

class _ClinetSheetState extends State<ClinetSheet> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController clientname = TextEditingController();
  final TextEditingController clientphone = TextEditingController();
  final TextEditingController clientfees = TextEditingController();
  final TextEditingController clientid = TextEditingController();
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
              SharedTextFeild(
                controller: clientname,
                validator: (name) {
                  if (name == null || name.isEmpty) {
                    return "Enter clinet name";
                  }
                  return null;
                },
                obscureText: false,
                hintText: 'Client Name',
                prefixIcon: Icon(Icons.person),
              ),
              SizedBox(height: 16),
              SharedTextFeild(
                controller: clientphone,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (clinetphone) {
                  if (clinetphone == null || clinetphone.isEmpty) {
                    return 'Enter client phone';
                  }
                  return null;
                },
                obscureText: false,
                hintText: 'Client phone',
                prefixIcon: Icon(Icons.phone),
              ),
              SizedBox(height: 16),
              SharedTextFeild(
                controller: clientid,
                obscureText: false,
                hintText: 'Client id',
                prefixIcon: Icon(Icons.key),
              ),
              SizedBox(height: 16),
              SharedTextFeild(
                controller: clientfees,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')),
                ],
                obscureText: false,
                hintText: 'Client fees',
                prefixIcon: Icon(Icons.money),
              ),
              SizedBox(height: 16),
              Sharedboutton(
                text: 'Add clinet',
                onTap: () async {
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
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    clientname.dispose();
    clientphone.dispose();
    clientid.dispose();
    clientfees.dispose();
    super.dispose();
  }
}
