import 'package:flutter/material.dart';

class LightWave extends StatelessWidget {
  const LightWave({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: LightWaveClipper(),
      child: Container(
        height: 200,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xffC4ACFD), Color(0xffE8E2FD)],
          ),
        ),
      ),
    );
  }
}

class LightWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 80);

    path.quadraticBezierTo(
      size.width * 0.3,
      size.height,
      size.width * 0.6,
      size.height - 60,
    );

    path.quadraticBezierTo(
      size.width * 0.85,
      size.height - 120,
      size.width,
      size.height - 80,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

// ////light wave
class MidWave extends StatelessWidget {
  const MidWave({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MidWaveClipper(),
      child: Container(
        height: 150,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [Color(0xffA886FB), Color(0xffB398FC), Color(0xffB49AFB)],
          ),
        ),
      ),
    );
  }
}

class MidWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 60);

    path.quadraticBezierTo(
      size.width * 0.25,
      size.height,
      size.width * 0.45,
      size.height - 40,
    );

    path.quadraticBezierTo(
      size.width * 0.8,
      size.height - 100,
      size.width,
      size.height - 60,
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

////midwave
class MainWave extends StatelessWidget {
  const MainWave({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MainWaveClipper(),
      child: Container(
        height: 100,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF9774FB), Color(0xff9874FA), Color(0xff9A77FB)],
          ),
        ),
      ),
    );
  }
}

class MainWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();

    path.lineTo(0, size.height - 40);

    path.quadraticBezierTo(
      size.width * 0.2,
      size.height,
      size.width * 0.5,
      size.height - 30,
    );

    path.quadraticBezierTo(
      size.width * 0.85,
      size.height - 75,
      size.width,
      size.height - 90, //الارتفاع من اليمين
    );

    path.lineTo(size.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
