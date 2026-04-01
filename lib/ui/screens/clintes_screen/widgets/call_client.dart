import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:url_launcher/url_launcher.dart';

class CallClient extends StatelessWidget {
  const CallClient({super.key, required this.clinetModel});
  final ClinetModel clinetModel;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () async {
            final Uri tel = Uri(scheme: 'tel', path: clinetModel.clinetphone);
            if (await canLaunchUrl(tel)) {
              await launchUrl(tel, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cannot make a call')),
              );
            }
          },
          icon: const Icon(Icons.call, color: Colors.blue),
        ),
        IconButton(
          onPressed: () async {
            final Uri whatsapp = Uri.parse(
              'https://wa.me/+02${clinetModel.clinetphone}',
            );
            if (await canLaunchUrl(whatsapp)) {
              await launchUrl(whatsapp, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Cannot open WhatsApp')),
              );
            }
          },
          icon: const Icon(FontAwesomeIcons.whatsapp, color: Colors.green),
        ),
      ],
    );
  }
}
