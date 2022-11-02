import 'dart:convert';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioLocalData implements PortfolioLocalAction {
  final String _portfolioStorageKeys = AppConstants.portfolioStorageKeys;
  final String _currentPortfolioStorage = AppConstants.currentPortfolioStorage;

  @override
  Future<bool> portfolioStorageIsEmpty() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final result = sp.getStringList(_portfolioStorageKeys);
    if(result == null || result.isEmpty) {
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
    if(portfolioJson != null) {
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
    final List<String> portfolioListKeys = sp.getStringList(_portfolioStorageKeys) ?? [];
    portfolioListKeys.add(portfolioName);
    await sp.setString(portfolioName, json.encode(newPortfolioModel.toJson()));
    await sp.setStringList(_portfolioStorageKeys, portfolioListKeys);
  }

  @override
  Future<bool> deletePortfolioByName(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String>? portfolioListKeys = sp.getStringList(_portfolioStorageKeys);
    if(portfolioListKeys != null) {
      portfolioListKeys.remove(portfolioName);
      await sp.remove(portfolioName);
      await sp.setStringList(_portfolioStorageKeys, portfolioListKeys);
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
  Future<List<Portfolio>> getListPortfolio() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<Portfolio> listPortfolio =  [];
    final List<String> listPortfolioNames = sp.getStringList(_portfolioStorageKeys) ?? [];
    for(int i = 0; i < listPortfolioNames.length; i++) {
      listPortfolio.add(Portfolio.fromJson(json.decode(sp.getString(listPortfolioNames[i]) ?? '')));
    }
    return listPortfolio;
  }

  @override
  Future<bool> portfolioNameAlreadyExists(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String> listPortfolioKeys = sp.getStringList(_portfolioStorageKeys) ?? [];
    return listPortfolioKeys.contains(portfolioName);
  }

  @override
  Future<Portfolio?> getCurrentPortfolio() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? nameCurrentPortfolio = sp.getString(_currentPortfolioStorage);
    if(nameCurrentPortfolio != null) {
      return Portfolio.fromJson(json.decode(sp.getString(nameCurrentPortfolio)!));
    }
    else {
      return null;
    }
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
    final String? nameCurrentPortfolio = sp.getString(_currentPortfolioStorage);
    if(nameCurrentPortfolio != null) {
      return nameCurrentPortfolio;
    }
    else {
      return null;
    }
  }
}