import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:targetly/ui/screens/clintes_screen/clients_screen.dart';
import 'package:targetly/ui/screens/home_screen/home_screen.dart';
import 'package:targetly/ui/screens/reports_screen/reports_screen.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({super.key});

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  int currentIndex = 1;
  final List<SalomonBottomBarItem> items = [
    SalomonBottomBarItem(icon: Icon(Icons.people), title: Text('Clients')),
    SalomonBottomBarItem(icon: Icon(Icons.home), title: Text('Home')),
    SalomonBottomBarItem(icon: Icon(Icons.bar_chart), title: Text('Report')),
  ];
  final List<Widget> screen = [
    const ClientsScreen(),
    const HomeScreen(),
    const ReportsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Targetly'), centerTitle: true),
      body: screen[currentIndex],
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFF7F73E6), Color.fromARGB(255, 13, 157, 201)],
            ),

            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: SalomonBottomBar(
            items: items,
            currentIndex: currentIndex,
            onTap: (index) {
              setState(() {
                currentIndex = index;
              });
            },

            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.white.withOpacity(0.6),
          ),
        ),
      ),
    );
  }
}
