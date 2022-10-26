import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/theme_switcher.dart';
import 'package:track_it/service/constant/app_constants_size.dart';
import '../../../theme/app_styles.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Настройки')),
      body: Center(
        child: Container(
          padding: AppStyles.paddingScreen,
          constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH),
          child: ListView(
            children: const [
              ThemeSwitcher()
            ],
          ),
        ),
      )
    );
  }
}