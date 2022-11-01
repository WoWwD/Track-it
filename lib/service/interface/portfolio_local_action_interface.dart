import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';

abstract class PortfolioLocalAction {
  Future<void> addTransaction(String portfolioName, Transaction transactionModel);
  Future<bool> portfolioStorageIsEmpty();
  Future<bool> portfolioAlreadyExists(String portfolioName);
  Future<bool> portfolioIsEmpty(String portfolioName);
  Future<void> createPortfolio(String portfolioName);
  Future<Portfolio?> getPortfolioByName(String portfolioName);
  Future<List<Portfolio>> getListPortfolio();
  Future<Portfolio?> getCurrentPortfolio();
  Future<String?> getCurrentPortfolioName();
  Future<void> clearCurrentPortfolioStorage();
  Future<void> setToCurrentPortfolio(String portfolioName);
  Future<void> setPortfolio(String portfolioName, Portfolio portfolioModel);
  Future<bool> deletePortfolioByName(String portfolioName);
  Future<void> deleteTransactionByIndex(String portfolioName, int indexTransaction, String idCoin);
  Future<void> editTransactionByIndex(String portfolioName, int indexTransaction, Transaction newTransactionModel);
  Future<void> deleteAssetById(String portfolioName, String idAsset);
}