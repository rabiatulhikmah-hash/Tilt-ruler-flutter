import 'package:flutter/material.dart';
import 'level_screen.dart';
import 'tilt_screen.dart';
import 'compass_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  final List<Widget> _screens = const [
    LevelScreen(),
    TiltScreen(),
    CompassScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() => _currentIndex = index);
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.bubble_chart),
            label: 'Level',
          ),
          NavigationDestination(
            icon: Icon(Icons.screen_rotation),
            label: 'Tilt',
          ),
          NavigationDestination(
            icon: Icon(Icons.explore),
            label: 'Kompas',
          ),
        ],
      ),
    );
  }
}