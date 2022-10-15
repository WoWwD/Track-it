enum TypeOfTransaction {
  buy, sell, transferIn, transferOut
}

class Transaction {
  final DateTime dateTime;
  final String note;
  final TypeOfTransaction typeOfTransaction;

  Transaction({
    required this.dateTime,
    required this.note,
    required this.typeOfTransaction
  });
}