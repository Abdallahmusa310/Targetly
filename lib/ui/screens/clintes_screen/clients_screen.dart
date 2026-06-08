import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:targetly/logic/Clients/cubit/client_cubit.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/client_dialog.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clients_list.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  ClientFilter selectedFilter = ClientFilter.all;

  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClinetCubit>(context).fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Clients'.tr(),
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SharedTextFeild(
              obscureText: false,
              hintText: 'Search by id or phone,name...'.tr(),
              prefixIcon: const Icon(Icons.search),
              onChanged: (value) {
                context.read<ClinetCubit>().searchClients(value);
              },
            ),

            const SizedBox(height: 16),

            /// FILTERS
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildFilterChip(
                    title: 'All Clients'.tr(),
                    filter: ClientFilter.all,
                  ),
                  const SizedBox(width: 10),
                  _buildFilterChip(
                    title: 'Subscribed'.tr(),
                    filter: ClientFilter.subscribed,
                  ),
                  const SizedBox(width: 10),
                  _buildFilterChip(
                    title: 'Unsubscribed'.tr(),
                    filter: ClientFilter.unsubscribed,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 14),

            const Expanded(child: ClientsList()),
          ],
        ),
      ),

      floatingActionButton: Sharedboutton(
        text: 'Add client'.tr(),
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const Clientdialog(),
          );
        },
      ),
    );
  }

  Widget _buildFilterChip({
    required String title,
    required ClientFilter filter,
  }) {
    final bool isSelected = selectedFilter == filter;

    return ChoiceChip(
      label: Text(title),
      selected: isSelected,
      showCheckmark: false,
      selectedColor: const Color(0xff9367FA),
      backgroundColor: Colors.grey.shade100,
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : Colors.black87,
        fontWeight: FontWeight.w600,
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onSelected: (_) {
        setState(() {
          selectedFilter = filter;
        });

        context.read<ClinetCubit>().filterClients(filter);
      },
    );
  }
}

enum ClientFilter { all, subscribed, unsubscribed }
