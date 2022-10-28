import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/screen/portfolio_screen.dart';
import 'package:track_it/presentation/ui/screen/settings/settings_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreen();
}

class _MainScreen extends State<MainScreen> {
  int _selectedIndex = 0;
  late StreamSubscription subscription;

  @override
  initState() {
    subscription = Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      //ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Нет интернета!')));
    });
    super.initState();
  }

  @override
  dispose() {
    subscription.cancel();
    super.dispose();
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

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  List<BottomNavigationBarItem> get _items => [
    const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Главная'),
    const BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Настройки'),
  ];

  static const List<Widget> _screens = [PortfolioScreen(), SettingsScreen()];
}