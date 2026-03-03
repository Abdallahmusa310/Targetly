import 'package:flutter/material.dart';
import 'package:targetly/ui/screens/sign_in_screen/widgets/waves.dart';

class Header extends StatelessWidget {
  const Header({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        LightWave(),
        MidWave(),
        MainWave(),
        Positioned(
          left: 0,
          right: 0,
          bottom: -130,
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.asset(
                  'assets/targetly icon.png',
                  width: 180,
                  height: 180,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 100),
      ],
    );
  }
}
