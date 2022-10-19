import 'package:flutter/cupertino.dart';

class TransactionSellModel extends ChangeNotifier {
  double _amount = 0.0;
  double _price = 0.0;
  DateTime _dateTime = DateTime.now();
  String _note = '';

  get amount => _amount;
  get price => _price;
  get dateTime => _dateTime;
  get note => _note;

  void setAmount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  void setPrice(double price) {
    _price = price;
    notifyListeners();
  }

  void setDateTime(DateTime dateTime) {
    _dateTime = dateTime;
    notifyListeners();
  }

  void setNote(String note) {
    _note = note;
    notifyListeners();
  }
}