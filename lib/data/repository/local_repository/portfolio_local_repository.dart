import 'package:track_it/data/local_data/portfolio_local_data.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';

class PortfolioLocalRepository implements PortfolioLocalAction {
  final PortfolioLocalData portfolioLocalData;

  PortfolioLocalRepository(this.portfolioLocalData);

  @override
  Future<void> addPortfolio(Portfolio portfolio) async => portfolioLocalData.addPortfolio(portfolio);

  @override
  Future<void> deletePortfolio(String name) async => portfolioLocalData.deletePortfolio(name);

  @override
  Future<Portfolio> getPortfolio(String name) async => portfolioLocalData.getPortfolio(name);
}