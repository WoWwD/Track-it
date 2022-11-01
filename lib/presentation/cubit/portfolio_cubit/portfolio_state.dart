part of 'portfolio_cubit.dart';

@immutable
abstract class PortfolioState {}

class PortfolioInitial extends PortfolioState {}
class PortfolioLoading extends PortfolioState {}
class PortfolioNotCreated extends PortfolioState {}

class PortfolioCoins extends PortfolioState {
  final String portfolioName;
  final List<MarketCoin> listCoins;

  PortfolioCoins(this.portfolioName, this.listCoins);
}

class PortfolioList extends PortfolioState {
  final List<Portfolio> listPortfolio;
  final String currentPortfolioName;

  PortfolioList(this.listPortfolio, this.currentPortfolioName);
}

class PortfolioTransactions extends PortfolioState {
  final List<Transaction> listTransactions;

  PortfolioTransactions(this.listTransactions);
}