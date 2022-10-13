part of 'portfolio_cubit.dart';

@immutable
abstract class PortfolioState {}

class PortfolioInitial extends PortfolioState {}
class PortfolioLoading extends PortfolioState {}
class PortfolioLoaded extends PortfolioState {
  final List<Coin> listCoins;

  PortfolioLoaded(this.listCoins);
}
class PortfolioError extends PortfolioState {
  final String error;

  PortfolioError(this.error);
}
