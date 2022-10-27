import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/theme_switcher.dart';
import '../../../theme/app_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: Center(
        child: ListView(
          padding: AppStyles.mainPadding,
          children: const [
            ThemeSwitcher()
          ],
        ),
      )
    );
  }
}