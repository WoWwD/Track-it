abstract class TransactionAction {
  void setAmount(double amount);
  void setPrice(double price);
  void setCost(double cost);
  void setDateTime(DateTime dateTime);
  void setNote(String note);
  Future<void> addTransaction(String namePortfolio, String idCoin);
}