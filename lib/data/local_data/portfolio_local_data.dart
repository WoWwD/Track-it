import 'package:hive/hive.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';
import '../model/asset_model.dart';

class PortfolioLocalData implements PortfolioLocalAction {

  @override
  Future<bool> portfolioStorageIsEmpty() async => await _openBox().then((value) => value.isEmpty);

  @override
  Future<void> addTransaction(String namePortfolio, Transaction transactionModel) async {
    final Box portfolioBox = await _openBox();
    final Portfolio portfolio = await portfolioBox.get(namePortfolio);

    for(Asset asset in portfolio.listAssets) {
      /// Если монета есть в портфолио
      if(asset.coin == transactionModel.coin) {
        asset.listTransactions.add(transactionModel);
      }
      /// Если монеты нет в портфолио (первая транзакция)
      else {
        final asset = Asset(coin: transactionModel.coin, listTransactions: [transactionModel]);
        portfolio.listAssets.add(asset);
      }
    }
    await portfolioBox.put(namePortfolio, portfolio);
    await portfolioBox.close();
  }

  @override
  Future<Portfolio> getPortfolio(String namePortfolio) async {
    final Box portfolioBox = await _openBox();
    final result = await portfolioBox.get(namePortfolio);
    await portfolioBox.close();
    return result;
  }

  @override
  Future<void> createPortfolio(Portfolio portfolio) async {
    final Box portfolioBox = await _openBox();
    //TODO: при функционале с несколькими портфолио нельзя добавить портфолио с уже существующим названием
    await portfolioBox.put(portfolio.name, portfolio);
    await portfolioBox.close();
  }

  Future<Box> _openBox() async => await Hive.openBox(AppConstants.PORTFOLIOS_COLLECTION_HIVE);
}