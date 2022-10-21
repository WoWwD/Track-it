class Transaction {
  final String typeOfTransaction;
  final String dateTime;
  final String? note;
  final double amount;
  final double price;

  Transaction({
    required this.typeOfTransaction,
    required this.dateTime,
    required this.note,
    required this.amount,
    required this.price
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      typeOfTransaction: json['typeOfTransaction'],
      dateTime: json['dateTime'],
      note: json['note'],
      amount: json['amount'],
      price: json['price']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeOfTransaction'] = typeOfTransaction;
    data['dateTime'] = dateTime.toString();
    data['note'] = note;
    data['amount'] = amount;
    data['price'] = price;
    return data;
  }
}