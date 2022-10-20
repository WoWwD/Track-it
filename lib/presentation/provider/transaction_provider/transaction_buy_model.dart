import 'package:flutter/cupertino.dart';
import 'package:track_it/service/interface/transaction_action_interface.dart';

class TransactionBuyModel extends ChangeNotifier implements TransactionAction {
  double _amount = 0.0;
  double _price = 0.0;
  DateTime _dateTime = DateTime.now();
  String _note = '';

  get amount => _amount;
  get price => _price;
  get dateTime => _dateTime;
  get note => _note;

  @override
  void setAmount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  @override
  void setPrice(double price) {
    _price = price;
    notifyListeners();
  }

  @override
  void setDateTime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  @override
  void setNote(String note) {
    _note = note;
    notifyListeners();
  }

  @override
  void addTransaction() {
    // TODO: implement addTransaction
  }
}