import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import '../../domain/repository/local_repository/portfolio_local_repository.dart';

class SettingsModel extends ChangeNotifier {
  final PortfolioLocalRepository portfolioLocalRepository;
  late bool _darkMode;

  SettingsModel({required this.portfolioLocalRepository});

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

  Future<String> portfolioToJson(String portfolioName) async {
    final Portfolio portfolioModel = await portfolioLocalRepository.getPortfolio(portfolioName);
    return jsonEncode(portfolioModel.toJson());
  }

  Future<void> portfolioFromJson(String jsonPortfolio, String portfolioName) async {
    final Portfolio portfolioModel = Portfolio.fromJson(json.decode(jsonPortfolio));
    await portfolioLocalRepository.deletePortfolio(portfolioName);
    await portfolioLocalRepository.createPortfolio(portfolioName, portfolioModel);
  }
}