import 'package:track_it/data/local_data/portfolio_local_data.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';

class PortfolioLocalRepository implements PortfolioLocalAction {
  final PortfolioLocalData portfolioLocalData;

  PortfolioLocalRepository(this.portfolioLocalData);

  @override
  Future<void> addTransaction(String namePortfolio, String idCoin, Transaction transactionModel) async
    => await portfolioLocalData.addTransaction(namePortfolio, idCoin, transactionModel);

  @override
  Future<void> createPortfolio(String namePortfolio, [Portfolio? portfolioModel]) async
    => await portfolioLocalData.createPortfolio(namePortfolio, portfolioModel);

  @override
  Future<bool> portfolioStorageIsEmpty(String namePortfolio) async
    => await portfolioLocalData.portfolioStorageIsEmpty(namePortfolio);

  @override
  Future<Portfolio> getPortfolio(String namePortfolio) async => await portfolioLocalData.getPortfolio(namePortfolio);

  @override
  Future<void> deleteTransactionByIndex(String namePortfolio, String idCoin, int indexTransaction) async
    => await portfolioLocalData.deleteTransactionByIndex(namePortfolio, idCoin, indexTransaction);

  @override
  Future<void> deleteAssetById(String namePortfolio, String idAsset) async
    => await portfolioLocalData.deleteAssetById(namePortfolio, idAsset);

  @override
  Future<void> deletePortfolio(String namePortfolio) async => await portfolioLocalData.deletePortfolio(namePortfolio);
}