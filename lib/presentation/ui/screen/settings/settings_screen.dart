import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/theme_switcher.dart';
import 'package:track_it/service/constant/app_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
          child: ListView(
            padding: AppStyles.mainPadding,
            children: [
              const ThemeSwitcher(),
              const SizedBox(height: 16),
              ListTile(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
                onTap: () => Navigator.pushNamed(context, '/importExportJson'),
                title: const Text('Импорт / экспорт портфеля'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 18),
              ),
            ],
          ),
        ),
      )
    );
  }
}