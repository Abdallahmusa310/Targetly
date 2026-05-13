import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:targetly/logic/Clients/client_cubit/clinet_cubit.dart';
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
  @override
  void initState() {
    super.initState();
    BlocProvider.of<ClinetCubit>(context).fetchClients();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Clients ', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            SharedTextFeild(
              obscureText: false,
              hintText: 'Search by id or phone,name...',
              prefixIcon: Icon(Icons.search),
              onChanged: (value) {
                BlocProvider.of<ClinetCubit>(context).searchClients(value);
              },
            ),
            SizedBox(height: 12),
            Expanded(child: ClientsList()),
          ],
        ),
      ),
      floatingActionButton: Sharedboutton(
        text: 'Add clinet',
        onTap: () {
          showDialog(
            context: context,
            builder: (context) => const Clientdialog(),
          );
        },
      ),
    );
  }
}
