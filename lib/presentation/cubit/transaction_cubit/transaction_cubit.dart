import 'dart:core';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/coin_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/data/repository/remote_repository/coin_remote_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final CoinRemoteRepository coinRemoteRepository;

  TransactionCubit({
    required this.coinRemoteRepository
  }) : super(TransactionInitial());

  Future<void> init(String idCoin) async {
    final coinModel = await coinRemoteRepository.getCoinById(idCoin);
    emit(TransactionStart(coinModel));
  }

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