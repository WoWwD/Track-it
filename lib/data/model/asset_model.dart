import 'package:track_it/data/model/transaction_model.dart';

class Asset {
  final String idCoin;
  final List<Transaction> listTransactions;

  Asset({required this.idCoin, required this.listTransactions});

  factory Asset.fromJson(Map<String, dynamic> json) {
    final List<Transaction> listTransactions = [];
    json['listTransactions'].forEach((item) {
      listTransactions.add(Transaction.fromJson(item));
    });

    return Asset(
      idCoin: json['idCoin'],
      listTransactions: listTransactions,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['idCoin'] = idCoin;
    data['listTransactions'] = listTransactions.map((item) => item.toJson()).toList();
    return data;
  }
}