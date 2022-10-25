import 'package:flutter/material.dart';
import 'package:track_it/app_routes.dart';
import 'package:track_it/presentation/ui/screen/main_screen.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MainScreen(),
      routes: AppRoutes.getRoutes(),
    );
  }
}