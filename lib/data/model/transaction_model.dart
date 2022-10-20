import 'package:track_it/data/model/coin/coin_model.dart';

enum TypeOfTransaction {
  buy, sell, transferIn, transferOut
}

class Transaction {
  final TypeOfTransaction typeOfTransaction;
  final Coin coin;
  final DateTime dateTime;
  final String? note;
  final double amount;
  final double price;

  Transaction({
    required this.typeOfTransaction,
    required this.coin,
    required this.dateTime,
    this.note,
    required this.amount,
    required this.price
  });
}