import 'package:track_it/data/local_data/portfolio_local_data.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';

class PortfolioLocalRepository implements PortfolioLocalAction {
  final PortfolioLocalData portfolioLocalData;

  PortfolioLocalRepository(this.portfolioLocalData);

  @override
  Future<void> addTransaction(String namePortfolio, Transaction transactionModel) async
    => await portfolioLocalData.addTransaction(namePortfolio, transactionModel);

  @override
  Future<void> createPortfolio(Portfolio portfolio) async => await portfolioLocalData.createPortfolio(portfolio);

  @override
  Future<bool> portfolioStorageIsEmpty() async => await portfolioLocalData.portfolioStorageIsEmpty();

  @override
  Future<Portfolio> getPortfolio(String namePortfolio) async => await portfolioLocalData.getPortfolio(namePortfolio);
}