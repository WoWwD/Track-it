import 'package:flutter/cupertino.dart';
import 'package:track_it/presentation/ui/screen/portfolio_screen.dart';
import 'package:track_it/presentation/ui/screen/settings/import_export_json_screen.dart';
import 'package:track_it/presentation/ui/screen/settings/settings_screen.dart';
import 'package:track_it/presentation/ui/screen/main_screen.dart';

class AppRoutes {
  static Map<String, Widget Function(BuildContext)> getRoutes() {
    return {
      '/main': (context) => const MainScreen(),
      '/settings': (context) => const SettingsScreen(),
      '/portfolio': (context) => const PortfolioScreen(),
      '/importExportJson': (context) => const ImportExportJsonScreen(),
    };
  }
}