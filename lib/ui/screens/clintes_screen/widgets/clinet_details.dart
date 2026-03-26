import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:targetly/data/models/client_model.dart';

class ClinetDetails extends StatelessWidget {
  const ClinetDetails({super.key, required this.clinetModel});
  final ClinetModel clinetModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(32),
      child: Column(
        children: [
          Text('clinet name :${clinetModel.clinetname} '),
          SizedBox(height: 4),
          Text('clinet id : ${clinetModel.clinetid}'),
          SizedBox(height: 4),
          Text('clinet fees : ${clinetModel.clinetfees}'),
          SizedBox(height: 4),

          SizedBox(height: 4),
          InkWell(
            onTap: () {
              showModalBottomSheet(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                  ),
                ),
                context: context,
                builder: (context) {
                  return Padding(
                    padding: EdgeInsetsGeometry.all(8),
                    child: Column(
                      children: [
                        IconButton(
                          onPressed: () {},
                          icon: Row(
                            children: [
                              const Icon(Icons.call, color: Colors.blue),
                              SizedBox(width: 4),
                              Text('clinet phone : ${clinetModel.clinetphone}'),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Row(
                            children: [
                              const FaIcon(
                                FontAwesomeIcons.whatsapp,
                                color: Colors.green,
                              ),
                              SizedBox(width: 4),
                              Text('clinet phone : ${clinetModel.clinetphone}'),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
            child: Text(
              'clinet phone : ${clinetModel.clinetphone}',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
