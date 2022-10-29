import 'package:flutter/cupertino.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/exception/app_exception.dart';
import 'package:track_it/service/interface/transaction_action_interface.dart';
import '../../../domain/repository/local_repository/portfolio_local_repository.dart';

class TransactionTransferOutModel extends ChangeNotifier implements TransactionAction {
  final PortfolioLocalRepository portfolioLocalRepository;
  double _amount = 0.0;
  DateTime _dateTime = DateTime.now();
  String _note = '';

  TransactionTransferOutModel({required this.portfolioLocalRepository});

  get amount => _amount;
  get dateTime => _dateTime;
  get note => _note;

  @override
  void setAmount(double amount) {
    _amount = amount;
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
      typeOfTransaction: AppConstants.transferOutTypeTransaction,
      dateTime: dateTime.toString(),
      note: note,
      amount: amount,
      price: 0.0,
      cost: 0.0
    );
    await portfolioLocalRepository.addTransaction(namePortfolio, idCoin, transactionModel);
  }

  @override
  void setPrice(double price) => throw AppException('Цена не нужна');

  @override
  void setCost(double cost) => throw AppException('Общая стоимость не нужна');
}