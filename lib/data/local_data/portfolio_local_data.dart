import 'dart:convert';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';
import '../model/asset_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../model/coin/coin_model.dart';

class PortfolioLocalData implements PortfolioLocalAction {

  @override
  Future<bool> portfolioStorageIsEmpty() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    /// если будет функционал с несколькими портфолио, то использовать setStringList
    final result = sp.getString(AppConstants.PORTFOLIOS_COLLECTION);
    if(result == null || result.isEmpty) {
      return true;
    }
    else {
      return false;
    }
  }

  @override
  Future<void> addTransaction(String namePortfolio, Coin coinModel, Transaction transactionModel) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final Portfolio portfolio = Portfolio.fromJson(json.decode(sp.getString(AppConstants.PORTFOLIOS_COLLECTION)!));
    if(portfolio.listAssets.isEmpty) {
      final asset = Asset(coin: coinModel, listTransactions: [transactionModel]);
      portfolio.listAssets.add(asset);
    }
    else {
      for(Asset asset in portfolio.listAssets) {
        /// Если монета есть в портфолио
        if(asset.coin.id == coinModel.id) {
          asset.listTransactions.add(transactionModel);
        }
        /// Если монеты нет в портфолио (первая транзакция)
        else {
          final asset = Asset(coin: coinModel, listTransactions: [transactionModel]);
          portfolio.listAssets.add(asset);
        }
      }
    }
    await sp.setString(AppConstants.PORTFOLIOS_COLLECTION, json.encode(portfolio.toJson()));
  }

  @override
  Future<Portfolio> getPortfolio(String namePortfolio) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    return Portfolio.fromJson(json.decode(sp.getString(AppConstants.PORTFOLIOS_COLLECTION)!));
  }

  @override
  Future<void> createPortfolio(Portfolio portfolio) async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    /// если будет функционал с несколькими портфолио, то использовать setStringList
    await sp.setString(AppConstants.PORTFOLIOS_COLLECTION, json.encode(portfolio.toJson()));
  }
}