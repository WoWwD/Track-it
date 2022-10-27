part of 'statistics_cubit.dart';

@immutable
abstract class StatisticsState {}

class StatisticsInitial extends StatisticsState {}
class StatisticsLoading extends StatisticsState {}
class StatisticsSingleCoin extends StatisticsState {
  final List<Transaction> listTransactions;

  StatisticsSingleCoin(this.listTransactions);

  double getAllCost() {
    double allCost = 0.0;
    for(int i = 0; i < listTransactions.length; i++) {
      if(listTransactions[i].typeOfTransaction == AppConstants.BUY_TYPE_TRANSACTION) {
        allCost += listTransactions[i].cost;
      }
    }
    return allCost;
  }

  double getAllAmount() {
    double allAmount = 0.0;
    for(int i = 0; i < listTransactions.length; i++) {
      allAmount += listTransactions[i].amount;
    }
    return allAmount;
  }

  double getAveragePriceBuy() {
    double allAmount = 0.0;
    double allCost = 0.0;
    for(int i = 0; i < listTransactions.length; i++) {
      if(listTransactions[i].typeOfTransaction == AppConstants.BUY_TYPE_TRANSACTION) {
        allAmount += listTransactions[i].amount;
        allCost += listTransactions[i].cost;
      }
    }
    return allCost / allAmount;
  }
}
