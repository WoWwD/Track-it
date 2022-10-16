import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/coin_model.dart';
import 'package:track_it/data/model/transaction_model.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  TransactionCubit() : super(TransactionInitial());

  Future<void> addTransactionTypeBuy(
    Coin coin,
    TypeOfTransaction typeOfTransaction,
    DateTime dateTime,
    String? note,
    double amount,
    double price
  ) async {
    final Transaction newTransaction = Transaction(
      typeOfTransaction: TypeOfTransaction.buy,
      coin: coin,
      dateTime: dateTime,
      note: note,
      amount: amount,
      price: price
    );
    emit(TransactionCompleted(newTransaction));
  }
}