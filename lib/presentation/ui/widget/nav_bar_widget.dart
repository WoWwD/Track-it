import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/screen/main_screen.dart';
import 'package:track_it/presentation/ui/screen/settings_screen.dart';

class NavBarWidget extends StatefulWidget {
  const NavBarWidget({Key? key}) : super(key: key);

  @override
  State<NavBarWidget> createState() => _NavBarWidget();
}

class _NavBarWidget extends State<NavBarWidget> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
        items: _items,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
      body: _screens.elementAt(_selectedIndex),
    );
  }

  List<BottomNavigationBarItem> get _items => [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
  ];

  static const List<Widget> _screens = [MainScreen(), SettingsScreen()];
}