import 'package:flutter/material.dart';
import 'package:targetly/core/const/string.dart';
import 'package:targetly/ui/screens/clintes_screen/clients_screen.dart';
import 'package:targetly/ui/screens/home_screen/home_screen.dart';
import 'package:targetly/ui/screens/reports_screen/reports_screen.dart';
import 'package:targetly/ui/screens/splash_screen/splash_screen.dart';

class AppRouter {
  Route ongenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.splashScreen:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case AppRoutes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoutes.clientsScreen:
        return MaterialPageRoute(builder: (_) => ClientsScreen());
      case AppRoutes.reportsScreen:
        return MaterialPageRoute(builder: (_) => ReportsScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
