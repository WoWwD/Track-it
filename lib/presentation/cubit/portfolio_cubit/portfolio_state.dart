part of 'portfolio_cubit.dart';

@immutable
abstract class PortfolioState {}

class PortfolioInitial extends PortfolioState {}
class PortfolioLoading extends PortfolioState {}
class PortfolioFirstLaunch extends PortfolioState {}

class PortfolioCoins extends PortfolioState {
  final Portfolio portfolio;
  final List<MarketCoin> listCoins;

  PortfolioCoins(this.portfolio, this.listCoins);
}

class PortfolioTransactions extends PortfolioState {
  final Portfolio portfolio;
  final String idCoin;
  final List<Transaction> listTransactions;

  PortfolioTransactions(this.portfolio, this.idCoin, this.listTransactions);
}