import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';

abstract class PortfolioLocalAction {
  Future<void> addTransaction(String namePortfolio, String idCoin, Transaction transactionModel);
  Future<bool> portfolioStorageIsEmpty(String namePortfolio);
  Future<void> createPortfolio(String namePortfolio);
  Future<Portfolio> getPortfolio(String namePortfolio);
  Future<void> deleteTransactionByIndex(String namePortfolio, String idCoin, int indexTransaction);
  Future<void> deleteAssetById(String namePortfolio, String idAsset);
}