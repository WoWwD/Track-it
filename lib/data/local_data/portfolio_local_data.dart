import 'dart:convert';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/service/constants/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../interface/portfolio_local_action_interface.dart';

class PortfolioLocalData implements PortfolioLocalAction {
  final String _portfolioKeysStorage = AppConstants.portfolioKeysStorage;
  final String _currentPortfolioStorage = AppConstants.currentPortfolioStorage;

  @override
  Future<bool> portfolioStorageIsEmpty() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? listKeys = sp.getStringList(_portfolioKeysStorage);
    if (listKeys == null || listKeys.isEmpty) {
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<Portfolio?> getPortfolioByName(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? portfolioJson = sp.getString(portfolioName);
    if (portfolioJson != null) {
      return Portfolio.fromJson(json.decode(portfolioJson));
    }
    else {
      return null;
    }
  }

  @override
  Future<void> createPortfolio(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio newPortfolioModel = Portfolio(name: portfolioName, listAssets: []);
    final List<String> portfolioListKeys = sp.getStringList(_portfolioKeysStorage) ?? [];
    portfolioListKeys.add(portfolioName);
    await sp.setString(portfolioName, json.encode(newPortfolioModel.toJson()));
    await sp.setStringList(_portfolioKeysStorage, portfolioListKeys);
  }

  @override
  Future<bool> deletePortfolioByName(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? portfolioListKeys = sp.getStringList(_portfolioKeysStorage);
    if (portfolioListKeys != null && portfolioListKeys.contains(portfolioName)) {
      portfolioListKeys.remove(portfolioName);
      await sp.remove(portfolioName);
      await sp.setStringList(_portfolioKeysStorage, portfolioListKeys);
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<void> setPortfolio(String portfolioName, Portfolio portfolioModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(portfolioName, json.encode(portfolioModel.toJson()));
  }

  @override
  Future<List<Portfolio>?> getListPortfolio() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<Portfolio> listPortfolio = [];
    final List<String>? listPortfolioNames = sp.getStringList(_portfolioKeysStorage);
    if (listPortfolioNames != null) {
      for (int i = 0; i < listPortfolioNames.length; i++) {
        String? portfolioJson = sp.getString(listPortfolioNames[i]);
        if (portfolioJson != null) {
          listPortfolio.add(Portfolio.fromJson(json.decode(portfolioJson)));
        }
      }
      return listPortfolio;
    }
    return null;
  }

  @override
  Future<bool?> portfolioNameAlreadyExists(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? listPortfolioKeys = sp.getStringList(_portfolioKeysStorage);
    if (listPortfolioKeys != null) {
      return listPortfolioKeys.contains(portfolioName);
    }
    return null;
  }

  @override
  Future<Portfolio?> getCurrentPortfolio() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? currentPortfolioName = sp.getString(_currentPortfolioStorage);
    if (currentPortfolioName != null) {
      final String? currentPortfolioJson = sp.getString(currentPortfolioName);
      if (currentPortfolioJson != null) {
        return Portfolio.fromJson(json.decode(currentPortfolioJson));
      }
    }
    return null;
  }

  @override
  Future<void> setToCurrentPortfolio(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(_currentPortfolioStorage, portfolioName);
  }

  @override
  Future<void> clearCurrentPortfolioStorage() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove(_currentPortfolioStorage);
  }

  @override
  Future<String?> getCurrentPortfolioName() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? currentPortfolioName = sp.getString(_currentPortfolioStorage);
    if (currentPortfolioName != null) {
      return currentPortfolioName;
    }
    else {
      return null;
    }
  }
}