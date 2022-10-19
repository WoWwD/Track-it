import 'package:flutter/cupertino.dart';

class TransactionTransferOutModel extends ChangeNotifier {
  double _amount = 0.0;
  DateTime _dateTime = DateTime.now();
  String _note = '';

  get amount => _amount;
  get dateTime => _dateTime;
  get note => _note;

  void setAmount(double amount) {
    _amount = amount;
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