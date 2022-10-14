enum TypeOfTransaction {
  buy, sell, transferIn, transferOut
}

class Transaction {
  final DateTime dateTime;
  final String description;
  final TypeOfTransaction typeOfTransaction;

  Transaction({
    required this.dateTime,
    required this.description,
    required this.typeOfTransaction
  });
}