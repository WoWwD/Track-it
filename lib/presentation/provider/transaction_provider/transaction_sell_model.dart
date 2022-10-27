import 'package:flutter/cupertino.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/data/repository/local_repository/portfolio_local_repository.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/interface/transaction_action_interface.dart';

class TransactionSellModel extends ChangeNotifier implements TransactionAction {
  final PortfolioLocalRepository portfolioLocalRepository;
  double _amount = 0.0;
  double _price = 0.0;
  double _cost = 0.0;
  DateTime _dateTime = DateTime.now();
  String _note = '';

  TransactionSellModel({required this.portfolioLocalRepository});

  get amount => _amount;
  get price => _price;
  get cost => _cost;
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
  void setCost(double cost) {
    _cost = cost;
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
  Future<void> addTransaction(String namePortfolio, String idCoin) async {
    final Transaction transactionModel = Transaction(
      typeOfTransaction: AppConstants.SELL_TYPE_TRANSACTION,
      dateTime: dateTime.toString(),
      note: note,
      amount: amount,
      price: price,
      cost: cost
    );
    await portfolioLocalRepository.addTransaction(namePortfolio, idCoin, transactionModel);
  }
}