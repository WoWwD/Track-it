part of 'transaction_cubit.dart';

@immutable
abstract class TransactionState {}

class TransactionInitial extends TransactionState {}
class TransactionLoading extends TransactionState {}
class TransactionCompleted extends TransactionState {
  final Transaction transactionModel;

  TransactionCompleted(this.transactionModel);
}