import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';

abstract class PortfolioLocalAction {
  Future<void> addTransaction(String namePortfolio, Transaction transactionModel);
  Future<bool> portfolioStorageIsEmpty(String namePortfolio);
  Future<void> createPortfolio(String namePortfolio, [Portfolio? portfolioModel]);
  Future<Portfolio> getPortfolio(String namePortfolio);
  Future<void> deletePortfolio(String namePortfolio);
  Future<void> deleteTransactionByIndex(String namePortfolio, int indexTransaction, String idCoin);
  Future<void> editTransactionByIndex(String namePortfolio, int indexTransaction, Transaction newTransactionModel);
  Future<void> deleteAssetById(String namePortfolio, String idAsset);
}