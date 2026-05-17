import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:targetly/ui/shared/dialog.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinetDetailsDialog extends StatelessWidget {
  const ClinetDetailsDialog({super.key, required this.clinetModel});

  final ClinetModel clinetModel;

  @override
  Widget build(BuildContext context) {
    final Uri whatsapp = Uri.parse(
      'https://wa.me/+2${clinetModel.clinetphone}',
    );

    return SharedDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// HEADER
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color(0xff9367FA).withOpacity(.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.person, color: Color(0xff9367FA)),
              ),
              const SizedBox(width: 12),
              Text(
                'Client Details'.tr(),
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 24),

          _buildRow('Name'.tr(), clinetModel.clinetname),
          _buildRow('Phone'.tr(), clinetModel.clinetphone),
          _buildRow('ID'.tr(), clinetModel.clinetid ?? '-'),
          _buildRow('Fees'.tr(), clinetModel.clinetfees ?? '-'),
          _buildRow(
            'Added'.tr(),
            DateFormat(
              'dd/M/yyyy',
            ).format(clinetModel.createdAt ?? DateTime.now()),
          ),

          const SizedBox(height: 24),

          /// ACTIONS
          Row(
            children: [
              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff9367FA),
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    final Uri uri = Uri(
                      scheme: 'tel',
                      path: clinetModel.clinetphone,
                    );

                    await launchUrl(uri);
                  },
                  icon: const Icon(Icons.call, color: Colors.white),
                  label: Text(
                    'Call'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.green,
                    padding: const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () async {
                    await launchUrl(whatsapp);
                  },
                  icon: const FaIcon(
                    FontAwesomeIcons.whatsapp,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: Text(
                    'WhatsApp'.tr(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            width: double.infinity,
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(14),
                ),
              ),
              onPressed: () => Navigator.pop(context),
              child: Text('Close'.tr()),
            ),
          ),
        ],
      ),
    );
  }

  static Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 70,
            child: Text(
              '$title:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
