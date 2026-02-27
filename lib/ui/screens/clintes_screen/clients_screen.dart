import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clients_list.dart';
import 'package:targetly/ui/shared/search_feild.dart';
import 'package:targetly/ui/shared/floating_action_boutton.dart';

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
            SharedTextFeild(
              hintText: 'Search clients...',
              prefixIcon: Icon(Icons.search),
            ),
            SizedBox(height: 16),
            Expanded(child: ClientsList()),
          ],
        ),
      ),
      floatingActionButton: SharedFloatingActionButton(
        lable: Icon(Icons.add),
        tooltip: 'Add Client',
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16),
                    child: Form(
                      child: Column(
                        children: [
                          const SizedBox(height: 15),
                          SharedTextFeild(
                            hintText: 'Client Name',
                            prefixIcon: Icon(Icons.person),
                          ),
                          SizedBox(height: 16),
                          SharedTextFeild(
                            hintText: 'Client phone',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          SizedBox(height: 16),
                          SharedTextFeild(
                            hintText: 'Client id',
                            prefixIcon: Icon(Icons.key),
                          ),
                          SizedBox(height: 16),
                          SharedFloatingActionButton(
                            onPressed: () {},
                            lable: Text('Add Client'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
