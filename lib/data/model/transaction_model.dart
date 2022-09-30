import 'package:track_it/data/model/coin_model.dart';

enum TypeOfTransaction {
  buy, sell, transferIn, transferOut
}

class Transaction {
  final Coin coin;
  final DateTime dateTime;
  final String description;
  final TypeOfTransaction typeOfTransaction;

  Transaction({
    required this.coin,
    required this.dateTime,
    required this.description,
    required this.typeOfTransaction
  });
}