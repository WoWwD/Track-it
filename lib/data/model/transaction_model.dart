class Transaction {
  final String typeOfTransaction;
  final String dateTime;
  final String? note;
  final double amount;
  final double price;
  final double cost;

  Transaction({
    required this.typeOfTransaction,
    required this.dateTime,
    required this.note,
    required this.amount,
    required this.price,
    required this.cost
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      typeOfTransaction: json['typeOfTransaction'],
      dateTime: json['dateTime'],
      note: json['note'],
      amount: json['amount'],
      price: json['price'],
      cost: json['cost']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['typeOfTransaction'] = typeOfTransaction;
    data['dateTime'] = dateTime.toString();
    data['note'] = note;
    data['amount'] = amount;
    data['price'] = price;
    data['cost'] = cost;
    return data;
  }
}