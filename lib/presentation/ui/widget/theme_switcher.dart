import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/provider/settings_provider.dart';

class ThemeSwitcher extends StatelessWidget{
  const ThemeSwitcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<SettingsModel>(
      builder: (context, model, child) {
        return Row(
          children: [
            const Text('Тема'),
            const Spacer(),
            const Icon(Icons.light_mode_outlined),
            Switch(
              value: model.darkMode,
              onChanged: (value) async => await model.setDarkMode(!model.darkMode)
            ),
            const Icon(Icons.dark_mode_outlined),
          ],
        );
      },
    );
  }
}
