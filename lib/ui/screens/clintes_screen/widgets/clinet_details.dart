import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ClinetDetails extends StatelessWidget {
  const ClinetDetails({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsetsGeometry.all(32),
      child: Column(
        children: [
          Text('clinet name : abdallah ali '),
          SizedBox(height: 4),
          Text('clinet code : mAz5452'),
          SizedBox(height: 4),
          Text('clinet fees : 15,000'),
          SizedBox(height: 4),
          Text('clinet phone : 15,000'),
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
                              Text('clinet phone : 0102868195236'),
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
                              Text('clinet phone : 0102868195236'),
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
              'clinet phone : 0102868195236',
              style: TextStyle(decoration: TextDecoration.underline),
            ),
          ),
          SizedBox(height: 4),
        ],
      ),
    );
  }
}
