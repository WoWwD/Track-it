part of 'portfolio_cubit.dart';

@immutable
abstract class PortfolioState {}

class PortfolioInitial extends PortfolioState {}
class PortfolioLoading extends PortfolioState {}
class PortfolioFirstLaunch extends PortfolioState {}

class PortfolioInit extends PortfolioState {
  final Portfolio portfolio;
  final List<MarketCoin> listCoins;

  PortfolioInit(this.portfolio, this.listCoins);
}

class PortfolioTransactions extends PortfolioState {
  final List<Transaction> listTransactions;

  PortfolioTransactions(this.listTransactions);
}