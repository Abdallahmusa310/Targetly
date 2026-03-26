import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clients_list.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_sheet.dart';
import 'package:targetly/ui/shared/boutton.dart';
import 'package:targetly/ui/shared/text_field.dart';

class ClientsScreen extends StatelessWidget {
  const ClientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(' Clients ', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: const Column(
          children: [
            SharedTextFeild(
              obscureText: false,
              hintText: 'Search clients...',
              prefixIcon: Icon(Icons.search),
            ),
            SizedBox(height: 16),
            Expanded(child: ClientsList()),
          ],
        ),
      ),
      floatingActionButton: Sharedboutton(
        text: 'Add clinet',
        onTap: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return const ClinetSheet();
            },
          );
        },
      ),
    );
  }
}
