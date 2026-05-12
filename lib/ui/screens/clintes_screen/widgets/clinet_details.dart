import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:targetly/data/models/client_model.dart';
import 'package:url_launcher/url_launcher.dart';

class ClinetDetails extends StatefulWidget {
  const ClinetDetails({super.key, required this.clinetModel});
  final ClinetModel clinetModel;

  @override
  State<ClinetDetails> createState() => _ClinetDetailsState();
}

class _ClinetDetailsState extends State<ClinetDetails>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> opacity;
  late Animation<Offset> offset;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );

    opacity = Tween(begin: 0.0, end: 1.0).animate(controller);

    offset = Tween<Offset>(
      begin: const Offset(0, 0.15),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: controller, curve: Curves.easeOutCubic));

    controller.forward();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Uri whatsapp = Uri.parse(
      'https://wa.me/+02${widget.clinetModel.clinetphone}',
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: FadeTransition(
        opacity: opacity,
        child: SlideTransition(
          position: offset,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              /// 🔥 Drag handle
              Container(
                width: 40,
                height: 5,
                margin: const EdgeInsets.only(bottom: 16),
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(10),
                ),
              ),

              /// 🔥 Info
              _buildRow("Name", widget.clinetModel.clinetname),
              _buildRow("ID", widget.clinetModel.clinetid ?? ''),
              _buildRow("Fees", widget.clinetModel.clinetfees ?? ''),
              _buildRow(
                "Added",
                DateFormat(
                  'dd/M/yyyy',
                ).format(widget.clinetModel.createdAt ?? DateTime.now()),
              ),

              const SizedBox(height: 12),

              /// 🔥 Phone action
              InkWell(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: const Icon(
                                Icons.call,
                                color: Colors.blue,
                              ),
                              title: Text(widget.clinetModel.clinetphone),
                              onTap: () async {
                                final Uri uri = Uri(
                                  scheme: 'tel',
                                  path: widget.clinetModel.clinetphone,
                                );
                                await launchUrl(uri);
                              },
                            ),
                            ListTile(
                              leading: const FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.green,
                              ),
                              title: Text(widget.clinetModel.clinetphone),
                              onTap: () async {
                                await launchUrl(whatsapp);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: Text(
                  widget.clinetModel.clinetphone,
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildRow(String title, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Text("$title: ", style: const TextStyle(fontWeight: FontWeight.bold)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
