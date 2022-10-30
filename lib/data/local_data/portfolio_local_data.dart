import 'dart:convert';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';
import '../model/asset_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PortfolioLocalData implements PortfolioLocalAction {

  @override
  Future<bool> portfolioStorageIsEmpty(String namePortfolio) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final result = sp.getString(namePortfolio);
    if(result == null || result.isEmpty) {
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<void> addTransaction(String namePortfolio, Transaction transactionModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
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
    await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
  }

  @override
  Future<Portfolio> getPortfolio(String namePortfolio) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
  }

  @override
  Future<void> createPortfolio(String namePortfolio, [Portfolio? portfolioModel]) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    if (portfolioModel != null) {
      await sp.setString(namePortfolio, json.encode(portfolioModel.toJson()));
    }
    else {
      final Portfolio portfolio = Portfolio(name: namePortfolio, listAssets: []);
      await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
    }
  }

  @override
  Future<void> deletePortfolio(String namePortfolio) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    await sp.remove(namePortfolio);
  }

  @override
  Future<void> deleteTransactionByIndex(String namePortfolio, int indexTransaction, String idCoin) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
    final int indexAsset = portfolio.listAssets.indexWhere((element) => element.idCoin == idCoin);
    portfolio.listAssets[indexAsset].listTransactions.removeAt(indexTransaction);
    await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
  }

  @override
  Future<void> deleteAssetById(String namePortfolio, String idAsset) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
    final Asset assetModel = portfolio.listAssets.firstWhere((element) => element.idCoin == idAsset);
    portfolio.listAssets.remove(assetModel);
    await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
  }

  @override
  Future<void> editTransactionByIndex(String namePortfolio, int indexTransaction, Transaction newTransactionModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
    final int indexAsset = portfolio.listAssets.indexWhere((element) => element.idCoin == newTransactionModel.idCoin);
    portfolio.listAssets[indexAsset].listTransactions.removeAt(indexTransaction);
    portfolio.listAssets[indexAsset].listTransactions.add(newTransactionModel);
    await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
  }
}