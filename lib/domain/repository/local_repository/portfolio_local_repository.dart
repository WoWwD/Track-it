import 'package:track_it/data/interface/portfolio_local_action_interface.dart';
import 'package:track_it/data/local_data/portfolio_local_data.dart';
import 'package:track_it/data/model/portfolio_model.dart';

class PortfolioLocalRepository implements PortfolioLocalAction {
  final PortfolioLocalData portfolioLocalData;

  PortfolioLocalRepository(this.portfolioLocalData);

  @override
  Future<void> createPortfolio(String portfolioName) async => await portfolioLocalData.createPortfolio(portfolioName);

  @override
  Future<bool> portfolioStorageIsEmpty() async => await portfolioLocalData.portfolioStorageIsEmpty();

  @override
  Future<Portfolio?> getPortfolioByName(String portfolioName) async =>
    await portfolioLocalData.getPortfolioByName(portfolioName);

  @override
  Future<bool> deletePortfolioByName(String portfolioName) async =>
    await portfolioLocalData.deletePortfolioByName(portfolioName);

  @override
  Future<void> setPortfolio(String portfolioName, Portfolio portfolioModel) async =>
    portfolioLocalData.setPortfolio(portfolioName, portfolioModel);

  @override
  Future<List<Portfolio>?> getListPortfolio() async => await portfolioLocalData.getListPortfolio();

  @override
  Future<bool?> portfolioNameAlreadyExists(String portfolioName) async =>
    await portfolioLocalData.portfolioNameAlreadyExists(portfolioName);

  @override
  Future<Portfolio?> getCurrentPortfolio() async => await portfolioLocalData.getCurrentPortfolio();

  @override
  Future<void> setToCurrentPortfolio(String portfolioName) async =>
    await portfolioLocalData.setToCurrentPortfolio(portfolioName);

  @override
  Future<void> clearCurrentPortfolioStorage() async => await portfolioLocalData.clearCurrentPortfolioStorage();

  @override
  Future<String?> getCurrentPortfolioName() async => await portfolioLocalData.getCurrentPortfolioName();
}