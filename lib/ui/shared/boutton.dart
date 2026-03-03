import 'package:flutter/material.dart';

class Sharedboutton extends StatelessWidget {
  const Sharedboutton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 200,
      decoration: BoxDecoration(
        color: Color(0xff9367FA),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Center(
        child: Text(
          'Sign In',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
