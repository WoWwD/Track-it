abstract class TransactionAction {
  void setAmount(double amount);
  void setPrice(double price);
  void setDateTime(DateTime dateTime);
  void setNote(String note);
  Future<void> addTransaction(String namePortfolio, String idCoin);
}