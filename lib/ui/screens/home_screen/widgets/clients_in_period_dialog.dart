import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_card.dart';
import 'package:targetly/ui/shared/dialog.dart';

class ClientsInPeriodDialog extends StatelessWidget {
  const ClientsInPeriodDialog({
    super.key,
    required this.start,
    required this.end,
  });

  final DateTime start;
  final DateTime end;

  @override
  Widget build(BuildContext context) {
    final clients = context.read<ClinetCubit>().allClients.where((c) {
      final date = c.createdAt;
      if (date == null) return false;
      return !date.isBefore(start) && !date.isAfter(end);
    }).toList();

    return SharedDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              const CircleAvatar(
                backgroundColor: Color.fromARGB(255, 13, 157, 201),
                child: Icon(Icons.people, color: Colors.white),
              ),
              const SizedBox(width: 12),
              Text(
                'clients in period'.tr(),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          clients.isEmpty
              ? Text('no clients in period'.tr())
              : SizedBox(
                  height: 400,
                  child: ListView.builder(
                    itemCount: clients.length,
                    itemBuilder: (context, index) =>
                        ClinetCard(clinetModel: clients[index]),
                  ),
                ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              onPressed: () => Navigator.pop(context),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text('Close'.tr()),
            ),
          ),
        ],
      ),
    );
  }
}
