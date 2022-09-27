import 'package:track_it/data/model/coin_model.dart';
import 'package:track_it/data/model/transaction_model.dart';

class Asset {
  final Coin coin;
  final List<Transaction> listTransactions;

  Asset(this.coin, this.listTransactions);
}