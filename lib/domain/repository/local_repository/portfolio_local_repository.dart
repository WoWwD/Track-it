import 'package:track_it/data/local_data/portfolio_local_data.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';

class PortfolioLocalRepository implements PortfolioLocalAction {
  final PortfolioLocalData portfolioLocalData;

  PortfolioLocalRepository(this.portfolioLocalData);

  @override
  Future<void> addTransaction(String portfolioName, Transaction transactionModel) async
    => await portfolioLocalData.addTransaction(portfolioName, transactionModel);

  @override
  Future<void> createPortfolio(String portfolioName) async => await portfolioLocalData.createPortfolio(portfolioName);

  @override
  Future<bool> portfolioStorageIsEmpty() async => await portfolioLocalData.portfolioStorageIsEmpty();

  @override
  Future<Portfolio?> getPortfolioByName(String portfolioName) async => await portfolioLocalData.getPortfolioByName(portfolioName);

  @override
  Future<void> deleteAssetById(String portfolioName, String idAsset) async
    => await portfolioLocalData.deleteAssetById(portfolioName, idAsset);

  @override
  Future<bool> deletePortfolioByName(String portfolioName) async => await portfolioLocalData.deletePortfolioByName(portfolioName);

  @override
  Future<void> deleteTransactionByIndex(String portfolioName, int indexTransaction, String idCoin) async
    => await portfolioLocalData.deleteTransactionByIndex(portfolioName, indexTransaction, idCoin);

  @override
  Future<void> editTransactionByIndex(String portfolioName, int indexTransaction, Transaction newTransactionModel) async
    => portfolioLocalData.editTransactionByIndex(portfolioName, indexTransaction, newTransactionModel);

  @override
  Future<void> setPortfolio(String portfolioName, Portfolio portfolioModel) async
    => portfolioLocalData.setPortfolio(portfolioName, portfolioModel);

  @override
  Future<List<Portfolio>> getListPortfolio() async => await portfolioLocalData.getListPortfolio();

  @override
  Future<bool> portfolioIsEmpty(String portfolioName) async => await portfolioLocalData.portfolioIsEmpty(portfolioName);

  @override
  Future<bool> portfolioAlreadyExists(String portfolioName) async
    => await portfolioLocalData.portfolioAlreadyExists(portfolioName);

  @override
  Future<Portfolio?> getCurrentPortfolio() async => await portfolioLocalData.getCurrentPortfolio();

  @override
  Future<void> setToCurrentPortfolio(String portfolioName) async
    => await portfolioLocalData.setToCurrentPortfolio(portfolioName);

  @override
  Future<void> clearCurrentPortfolioStorage() async => await portfolioLocalData.clearCurrentPortfolioStorage();

  @override
  Future<String?> getCurrentPortfolioName() async => await portfolioLocalData.getCurrentPortfolioName();
}