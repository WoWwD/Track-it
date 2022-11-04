part of 'transaction_cubit.dart';

@immutable
abstract class TransactionState {}

class TransactionLoading extends TransactionState {}
class TransactionInitial extends TransactionState {}

class TransactionsReceived extends TransactionState {
  final List<Transaction> listTransactions;

  TransactionsReceived(this.listTransactions);
}