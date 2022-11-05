import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/screen/main_screen.dart';
import 'package:track_it/presentation/ui/screen/settings/settings_screen.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  @override
  State<NavBarWidget> createState() => _MainScreen();
}

class _MainScreen extends State<NavBarWidget> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> get _items => [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
  ];

  static const List<Widget> _screens = [MainScreen(), SettingsScreen()];
}