import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/clintes_screen/widgets/clinet_card.dart';

class ClientsList extends StatelessWidget {
  const ClientsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (context, index) {
        return ClinetCard();
      },
      itemCount: 10,
    );
  }
}
