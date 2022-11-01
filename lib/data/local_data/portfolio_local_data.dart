import 'dart:convert';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';
import '../model/asset_model.dart';
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
  Future<Portfolio> getPortfolioByName(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return Portfolio.fromJson(json.decode(sp.getString(portfolioName) ?? ''));
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
  Future<void> deletePortfolioByName(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String> portfolioListKeys = sp.getStringList(_portfolioStorageKeys) ?? [];
    portfolioListKeys.remove(portfolioName);
    await sp.remove(portfolioName);
    await sp.setStringList(_portfolioStorageKeys, portfolioListKeys);
  }

  @override
  Future<void> addTransaction(String portfolioName, Transaction transactionModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(portfolioName)!));
    if (portfolio.listAssets.isEmpty) {
      final asset = Asset(idCoin: transactionModel.idCoin, listTransactions: [transactionModel]);
      portfolio.listAssets.add(asset);
    }
    else {
      final int indexAsset = portfolio.listAssets.indexWhere((element) => element.idCoin == transactionModel.idCoin);
      if(indexAsset != -1) {
        portfolio.listAssets[indexAsset].listTransactions.add(transactionModel);
      } else {
        /// Если монеты нет в портфолио
        final asset = Asset(idCoin: transactionModel.idCoin, listTransactions: [transactionModel]);
        portfolio.listAssets.add(asset);
      }
    }
    await sp.setString(portfolioName, json.encode(portfolio.toJson()));
  }

  @override
  Future<void> deleteTransactionByIndex(String portfolioName, int indexTransaction, String idCoin) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(portfolioName)!));
    final int indexAsset = portfolio.listAssets.indexWhere((element) => element.idCoin == idCoin);
    portfolio.listAssets[indexAsset].listTransactions.removeAt(indexTransaction);
    await sp.setString(portfolioName, json.encode(portfolio.toJson()));
  }

  @override
  Future<void> deleteAssetById(String portfolioName, String idAsset) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(portfolioName)!));
    final Asset assetModel = portfolio.listAssets.firstWhere((element) => element.idCoin == idAsset);
    portfolio.listAssets.remove(assetModel);
    await sp.setString(portfolioName, json.encode(portfolio.toJson()));
  }

  @override
  Future<void> editTransactionByIndex(String portfolioName, int indexTransaction, Transaction newTransactionModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(portfolioName)!));
    final int indexAsset = portfolio.listAssets.indexWhere((element) => element.idCoin == newTransactionModel.idCoin);
    portfolio.listAssets[indexAsset].listTransactions.removeAt(indexTransaction);
    portfolio.listAssets[indexAsset].listTransactions.add(newTransactionModel);
    await sp.setString(portfolioName, json.encode(portfolio.toJson()));
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
  Future<bool> portfolioIsEmpty(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(portfolioName)!));
    if(portfolio.listAssets.isEmpty) {
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<bool> portfolioAlreadyExists(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final List<String> listPortfolioKeys = sp.getStringList(_portfolioStorageKeys) ?? [];
    return listPortfolioKeys.contains(portfolioName);
  }

  @override
  Future<Portfolio> getCurrentPortfolio() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return Portfolio.fromJson(json.decode(sp.getString(_currentPortfolioStorage)!));
  }

  @override
  Future<void> setToCurrentPortfolio(String portfolioName) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.setString(_currentPortfolioStorage, portfolioName);
  }
}