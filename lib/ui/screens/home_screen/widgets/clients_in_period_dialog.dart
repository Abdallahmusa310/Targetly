import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/cubit/client_cubit.dart';
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

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
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : const Color(0xff2B1E5E),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          clients.isEmpty
              ? Text(
                  'no clients in period'.tr(),
                  style: TextStyle(
                    color: isDark ? Colors.white54 : Colors.grey,
                  ),
                )
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
                side: BorderSide(
                  color: isDark ? Colors.white24 : const Color(0xFF7F73E6),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Close'.tr(),
                style: TextStyle(
                  color: isDark ? Colors.white70 : const Color(0xFF7F73E6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
