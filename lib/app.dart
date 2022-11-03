import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_it/app_routes.dart';
import 'package:track_it/presentation/provider/settings_model.dart';
import 'package:track_it/presentation/ui/widget/nav_bar_widget.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeMode = Provider.of<SettingsModel>(context);

    return MaterialApp(
      theme: ThemeData(brightness: Brightness.light),
      darkTheme: ThemeData(brightness: Brightness.dark),
      themeMode: themeMode.darkMode ? ThemeMode.dark : ThemeMode.light,
      home: const MainScreen(),
      routes: AppRoutes.getRoutes(),
    );
  }
}