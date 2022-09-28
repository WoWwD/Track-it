import 'package:flutter/cupertino.dart';
import 'package:track_it/presentation/ui/screen/settings_screen.dart';
import 'package:track_it/presentation/ui/widget/nav_bar_widget.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/main': (context) => const NavBarWidget(),
      '/settings': (context) => const SettingsScreen(),
    };
  }
}