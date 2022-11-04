import 'package:flutter/cupertino.dart';
import 'package:track_it/service/extension/date_time_extension.dart';
import 'package:track_it/service/helpers.dart';
import 'package:track_it/service/transaction_type_enum.dart';
import '../../data/model/asset_model.dart';
import '../../data/model/portfolio_model.dart';
import '../../data/model/transaction_model.dart';
import '../../domain/repository/local_repository/portfolio_local_repository.dart';

class TransactionModel extends ChangeNotifier {
  final PortfolioLocalRepository portfolioLocalRepository;
  final TransactionType transactionType;
  double _amount = 0.0;
  double _price = 0.0;
  double _cost = 0.0;
  DateTime _dateTime = DateTime.now();
  String _note = '';


  TransactionModel({
    required this.portfolioLocalRepository,
    this.transactionType = TransactionType.buy
  });

  double get amount => _amount;
  double get price => _price;
  double get cost => _cost;
  DateTime get dateTime => _dateTime;
  String get note => _note;

  void initForEditing(Transaction transactionModel) {
    _amount = transactionModel.amount;
    _price = transactionModel.price;
    _cost = transactionModel.cost;
    _dateTime = DateTime.now();
    _note = transactionModel.note ?? '';
  }

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

  Future<void> addTransaction(String portfolioName, String idCoin) async {
    final Transaction transactionModel = Transaction(
      idCoin: idCoin,
      typeOfTransaction: Helpers.typeTransactionEnumToModel(transactionType),
      dateTime: _dateTime.dateTimeFormatToString(),
      note: _note,
      amount: _amount,
      price: _isBuyOrSell()? _price: 0.0,
      cost: _isBuyOrSell()? _cost: 0.0,
    );

    final Portfolio? portfolioModel = await portfolioLocalRepository.getPortfolioByName(portfolioName);
    if(portfolioModel != null) {
      if (portfolioModel.listAssets.isEmpty) {
        final asset = Asset(idCoin: transactionModel.idCoin, listTransactions: [transactionModel]);
        portfolioModel.listAssets.add(asset);
      }
      else {
        final int indexAsset = portfolioModel.listAssets
          .indexWhere((element) => element.idCoin == transactionModel.idCoin);
        if(indexAsset != -1) {
          portfolioModel.listAssets[indexAsset].listTransactions.add(transactionModel);
        } else {
          /// Если монеты нет в портфолио
          final asset = Asset(idCoin: transactionModel.idCoin, listTransactions: [transactionModel]);
          portfolioModel.listAssets.add(asset);
        }
      }
      await portfolioLocalRepository.setPortfolio(portfolioName, portfolioModel);
    }
  }

  Future<void> editTransaction(String namePortfolio, Transaction oldTransactionModel, int indexOldTransaction) async {
    final Transaction newTransactionModel = Transaction(
      idCoin: oldTransactionModel.idCoin,
      typeOfTransaction: oldTransactionModel.typeOfTransaction,
      dateTime: _dateTime.dateTimeFormatToString(),
      note: _note,
      amount: _amount,
      price: _price,
      cost: _cost
    );
    final Portfolio? portfolioModel = await portfolioLocalRepository.getPortfolioByName(namePortfolio);
    if(portfolioModel != null) {
      final int indexAsset = portfolioModel.listAssets
        .indexWhere((element) => element.idCoin == newTransactionModel.idCoin);
      portfolioModel.listAssets[indexAsset].listTransactions.removeAt(indexOldTransaction);
      portfolioModel.listAssets[indexAsset].listTransactions.add(newTransactionModel);
      await portfolioLocalRepository.setPortfolio(namePortfolio, portfolioModel);
    }
  }

  bool _isBuyOrSell()
    => transactionType == TransactionType.buy || transactionType == TransactionType.sell;
}