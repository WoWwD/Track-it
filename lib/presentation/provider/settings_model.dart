import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_it/service/constants/app_constants.dart';

class SettingsModel extends ChangeNotifier {
  late bool _darkMode;

  get darkMode => _darkMode;

  Future<void> setDarkMode(bool darkMode) async {
    _darkMode = darkMode;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool(AppConstants.themeModeStorage, darkMode);
    notifyListeners();
  }

  Future<void> getValueTheme() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final bool? result = sp.getBool(AppConstants.themeModeStorage);
    await setDarkMode(result ?? false);
    notifyListeners();
  }
}