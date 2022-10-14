import 'package:track_it/data/model/portfolio_model.dart';

abstract class PortfolioLocalAction {
  Future<void> addPortfolio(Portfolio portfolio);
  Future<void> deletePortfolio(String name);
  Future<Portfolio> getPortfolio(String name);
  Future<bool> portfolioStorageIsEmpty();
}