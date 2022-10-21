part of 'portfolio_cubit.dart';

@immutable
abstract class PortfolioState {}

class PortfolioInitial extends PortfolioState {}
class PortfolioLoading extends PortfolioState {}
class PortfolioFirstLaunch extends PortfolioState {}

class PortfolioReceived extends PortfolioState {
  final Portfolio portfolio;

  PortfolioReceived(this.portfolio);
}