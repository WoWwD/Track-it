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

  Future<void> addTransaction(String portfolioName, String idCoin, TransactionType transactionType) async {
    final Transaction transactionModel = Transaction(
      idCoin: idCoin,
      typeOfTransaction: Helpers.getTypeTransactionToModel(transactionType),
      dateTime: _dateTime.dateTimeFormatToString(),
      note: _note,
      amount: _amount,
      price: _isBuyOrSell(transactionType)? _price: 0.0,
      cost: _isBuyOrSell(transactionType)? _cost: 0.0,
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

  Future<void> editTransaction(String namePortfolio, int indexTransaction, Transaction oldTransactionModel) async {
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
      final int indexAsset = portfolioModel.listAssets.indexWhere((element) => element.idCoin == newTransactionModel.idCoin);
      portfolioModel.listAssets[indexAsset].listTransactions.removeAt(indexTransaction);
      portfolioModel.listAssets[indexAsset].listTransactions.add(newTransactionModel);
      await portfolioLocalRepository.setPortfolio(namePortfolio, portfolioModel);
    }
  }

  bool _isBuyOrSell(TransactionType transactionType)
    => transactionType == TransactionType.buy || transactionType == TransactionType.sell;
}