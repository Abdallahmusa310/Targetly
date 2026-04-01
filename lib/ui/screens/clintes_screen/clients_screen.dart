import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clients_list.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_sheet.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class ClientsScreen extends StatefulWidget {
  const ClientsScreen({super.key});

  @override
  State<ClientsScreen> createState() => _ClientsScreenState();
}

class _ClientsScreenState extends State<ClientsScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClinetCubit()..fetchClients(),

      child: Builder(
        builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: Text(
                ' Clients ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  SharedTextFeild(
                    obscureText: false,
                    hintText: 'Search by id or phone...',
                    prefixIcon: Icon(Icons.search),
                    onChanged: (value) {
                      BlocProvider.of<ClinetCubit>(
                        context,
                      ).searchClients(value);
                    },
                  ),
                  SizedBox(height: 16),
                  Expanded(child: ClientsList()),
                ],
              ),
            ),
            floatingActionButton: Sharedboutton(
              text: 'Add clinet',
              onTap: () {
                final cubit = context.read<ClinetCubit>();
                showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) {
                    return Padding(
                      padding: EdgeInsets.only(
                        bottom: MediaQuery.of(context).viewInsets.bottom,
                      ),
                      child: BlocProvider.value(
                        value: cubit,
                        child: const ClinetSheet(),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
