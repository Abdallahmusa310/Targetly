import 'package:flutter/material.dart';
import 'package:targetly/core/const/string.dart';
import 'package:targetly/core/routing/app_router.dart';
import 'package:targetly/ui/screens/splash_screen/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.splashScreen, // الشاشة الافتتاحية
      onGenerateRoute: AppRouter().ongenerateRoute,
    );
  }
}
