import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_it/service/constant/app_constants.dart';

class SettingsModel extends ChangeNotifier {
  late bool _darkMode;

  get darkMode => _darkMode;

  Future<void> setDarkMode(bool darkMode) async {
    _darkMode = darkMode;
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setBool(AppConstants.THEME_MODE_STORAGE, darkMode);
    notifyListeners();
  }

  Future<void> getValue() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final bool? result = sp.getBool(AppConstants.THEME_MODE_STORAGE);
    await setDarkMode(result ?? false);
    notifyListeners();
  }
}