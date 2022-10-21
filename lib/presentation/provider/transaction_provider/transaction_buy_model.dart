import 'package:flutter/cupertino.dart';
import 'package:track_it/data/repository/local_repository/portfolio_local_repository.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/interface/transaction_action_interface.dart';
import '../../../data/model/transaction_model.dart';

class TransactionBuyModel extends ChangeNotifier implements TransactionAction {
  final PortfolioLocalRepository portfolioLocalRepository;
  double _amount = 0.0;
  double _price = 0.0;
  DateTime _dateTime = DateTime.now();
  String _note = '';

  TransactionBuyModel({required this.portfolioLocalRepository});

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
  Future<void> addTransaction(String namePortfolio, String idCoin) async {
    final Transaction transactionModel = Transaction(
      typeOfTransaction: AppConstants.BUY_TYPE_TRANSACTION,
      dateTime: dateTime.toString(),
      note: note,
      amount: amount,
      price: price
    );
    await portfolioLocalRepository.addTransaction(namePortfolio, idCoin, transactionModel);
  }
}