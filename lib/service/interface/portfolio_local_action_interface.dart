import 'package:track_it/data/model/portfolio_model.dart';

abstract class PortfolioLocalAction {
  Future<bool> portfolioStorageIsEmpty();
  Future<bool> portfolioNameAlreadyExists(String portfolioName);
  Future<void> createPortfolio(String portfolioName);
  Future<Portfolio?> getPortfolioByName(String portfolioName);
  Future<List<Portfolio>> getListPortfolio();
  Future<Portfolio?> getCurrentPortfolio();
  Future<String?> getCurrentPortfolioName();
  Future<void> clearCurrentPortfolioStorage();
  Future<void> setToCurrentPortfolio(String portfolioName);
  Future<void> setPortfolio(String portfolioName, Portfolio portfolioModel);
  Future<bool> deletePortfolioByName(String portfolioName);
}