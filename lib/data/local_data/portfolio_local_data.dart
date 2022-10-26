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
  Future<void> addTransaction(String namePortfolio, String idCoin, Transaction transactionModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
    if (portfolio.listAssets.isEmpty) {
      final asset = Asset(idCoin: idCoin, listTransactions: [transactionModel]);
      portfolio.listAssets.add(asset);
    }
    else {
      for(int i = 0; i < portfolio.listAssets.length; i++) {
        /// Если монета есть в портфолио
        if(portfolio.listAssets[i].idCoin == idCoin) {
          portfolio.listAssets[i].listTransactions.add(transactionModel);
          break;
        }
      }
      /// Если монеты нет в портфолио
      final asset = Asset(idCoin: idCoin, listTransactions: [transactionModel]);
      portfolio.listAssets.add(asset);
    }
    await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
  }

  @override
  Future<Portfolio> getPortfolio(String namePortfolio) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
  }

  @override
  Future<void> createPortfolio(String namePortfolio) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio(name: namePortfolio, listAssets: []);
    await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
  }

  @override
  Future<void> deleteTransactionByIndex(String namePortfolio, String idCoin, int indexTransaction) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
    for(int i = 0; i < portfolio.listAssets.length; i++) {
      if(portfolio.listAssets[i].idCoin == idCoin) {
        portfolio.listAssets[i].listTransactions.removeAt(indexTransaction);
        break;
      }
    }
    await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
  }

  @override
  Future<void> deleteAssetById(String namePortfolio, String idAsset) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(namePortfolio)!));
    for(int i = 0; i < portfolio.listAssets.length; i++) {
      if(portfolio.listAssets[i].idCoin == idAsset) {
        portfolio.listAssets.removeAt(i);
        break;
      }
    }
    await sp.setString(namePortfolio, json.encode(portfolio.toJson()));
  }
}