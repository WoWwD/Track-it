import 'package:flutter/cupertino.dart';
import 'package:track_it/presentation/ui/screen/main_screen.dart';
import 'package:track_it/presentation/ui/screen/settings/import_export_json_screen.dart';
import 'package:track_it/presentation/ui/screen/settings/settings_screen.dart';
import 'package:track_it/presentation/ui/widget/nav_bar_widget.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/main': (context) => const NavBarWidget(),
      '/settings': (context) => const SettingsScreen(),
      '/portfolio': (context) => const MainScreen(),
      '/importExportJson': (context) => const ImportExportJsonScreen(),
    };
  }
}