import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clients_list.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/search_feild.dart';

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
        child: Column(
          children: [
            SearchFeild(),
            SizedBox(height: 16),
            Expanded(child: ClientsList()),
          ],
        ),
      ),
    );
  }
}
