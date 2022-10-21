import 'package:track_it/data/model/coin/coin_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'coin/coin_model.dart';

class Asset {
  final Coin coin;
  final List<Transaction> listTransactions;

  Asset({required this.coin, required this.listTransactions});

  factory Asset.fromJson(Map<String, dynamic> json) {
    final List<Transaction> listTransactions = [];
    json['listTransactions'].forEach((item) {
      listTransactions.add(Transaction.fromJson(item));
    });

    return Asset(
      coin: Coin.fromJson(json['coin']),
      listTransactions: listTransactions,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['coin'] = coin.toJson();
    data['listTransactions'] = listTransactions.map((item) => item.toJson()).toList();
    return data;
  }
}