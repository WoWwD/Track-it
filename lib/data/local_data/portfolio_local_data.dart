import 'package:hive/hive.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/interface/portfolio_local_action_interface.dart';

class PortfolioLocalData implements PortfolioLocalAction {
  @override
  Future<void> addPortfolio(Portfolio portfolio) async {
    final Box portfolioBox = await _openBox();
    await portfolioBox.put(portfolio.name, portfolio);
    await portfolioBox.close();
  }

  @override
  Future<void> deletePortfolio(String name) async {
    final Box portfolioBox = await  _openBox();
    await portfolioBox.delete(name);
    await portfolioBox.close();
  }

  @override
  Future<Portfolio> getPortfolio(String name) async {
    final Box portfolioBox = await _openBox();
    final res = await portfolioBox.get(name);
    await portfolioBox.close();
    return res;
  }

  Future<Box> _openBox() async => await Hive.openBox(AppConstants.PORTFOLIOS_COLLECTION_HIVE);
}