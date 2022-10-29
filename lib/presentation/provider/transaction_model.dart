import 'package:flutter/cupertino.dart';
import 'package:track_it/service/extension/date_time_extension.dart';
import 'package:track_it/service/helpers.dart';
import 'package:track_it/service/transaction_type_enum.dart';
import '../../data/model/transaction_model.dart';
import '../../domain/repository/local_repository/portfolio_local_repository.dart';

class TransactionModel extends ChangeNotifier {
  final PortfolioLocalRepository portfolioLocalRepository;
  double _amount = 0.0;
  double _price = 0.0;
  double _cost = 0.0;
  DateTime _dateTime = DateTime.now();
  String _note = '';

  TransactionModel({required this.portfolioLocalRepository});

  get amount => _amount;
  get price => _price;
  get cost => _cost;
  DateTime get dateTime => _dateTime;
  get note => _note;

  void setAmount(double amount) {
    _amount = amount;
    notifyListeners();
  }

  void setPrice(double price) {
    _price = price;
    notifyListeners();
  }

  void setCost(double cost) {
    _cost = cost;
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

  Future<void> addTransaction(String namePortfolio, String idCoin, TransactionType transactionType) async {
    final Transaction transactionModel = Transaction(
      typeOfTransaction: Helpers.setTypeTransactionToModel(transactionType),
      dateTime: _dateTime.dateTimeFormatToString(),
      note: _note,
      amount: _amount,
      price: _isBuyOrSell(transactionType)? _price: 0.0,
      cost: _isBuyOrSell(transactionType)? _cost: 0.0
    );
    await portfolioLocalRepository.addTransaction(namePortfolio, idCoin, transactionModel);
  }

  bool _isBuyOrSell(TransactionType transactionType)
    => transactionType == TransactionType.buy || transactionType == TransactionType.sell;
}