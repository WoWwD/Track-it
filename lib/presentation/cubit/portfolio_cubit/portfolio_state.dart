part of 'portfolio_cubit.dart';

@immutable
abstract class PortfolioState {}

class PortfolioInitial extends PortfolioState {}
class PortfolioLoading extends PortfolioState {}
class PortfolioNotCreated extends PortfolioState {}

class PortfolioList extends PortfolioState {
  final List<Portfolio> listPortfolio;
  final String currentPortfolioName;

  PortfolioList(this.listPortfolio, this.currentPortfolioName);
}

class PortfolioReceived extends PortfolioState {
  final Portfolio portfolioModel;
  final List<MarketCoin> listCoins;

  PortfolioReceived(this.portfolioModel, this.listCoins);

  double getAmountInvestment() {
    double amount = 0.0;
    for (int i = 0; i < portfolioModel.listAssets.length; i++) {
      for (int j = 0; j < portfolioModel.listAssets[i].listTransactions.length; j++) {
        final Transaction transactionModel = portfolioModel.listAssets[i].listTransactions[j];

        if (transactionModel.typeOfTransaction == AppConstants.buyTypeTransaction) {
          amount += transactionModel.cost;
        }
        if (transactionModel.typeOfTransaction == AppConstants.sellTypeTransaction) {
          amount -= transactionModel.cost;
        }
      }
    }
    return amount;
  }

  double getCurrentCostPortfolio() {
    double cost = 0.0;
    for (int i = 0; i < portfolioModel.listAssets.length; i++) {
      double amountCoins = 0.0;
      for (int j = 0; j < portfolioModel.listAssets[i].listTransactions.length; j++) {
        final Transaction transactionModel = portfolioModel.listAssets[i].listTransactions[j];

        if (transactionModel.typeOfTransaction == AppConstants.buyTypeTransaction ||
            transactionModel.typeOfTransaction == AppConstants.transferInTypeTransaction
          ) {
          amountCoins += transactionModel.amount;
        }
        if (transactionModel.typeOfTransaction == AppConstants.sellTypeTransaction ||
            transactionModel.typeOfTransaction == AppConstants.transferOutTypeTransaction
        ) {
          amountCoins -= transactionModel.amount;
        }
      }
      if (amountCoins != 0.0) {
        final currentPriceCoin = listCoins.firstWhere((element) => element.id == portfolioModel.listAssets[i].idCoin);
        cost += amountCoins * currentPriceCoin.currentPrice;
      }
    }
    return cost;
  }
}