import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';

abstract class PortfolioLocalAction {
  Future<void> addTransaction(String namePortfolio, Transaction transactionModel);
  Future<bool> portfolioStorageIsEmpty();
  Future<void> createPortfolio(Portfolio portfolio);
  Future<Portfolio> getPortfolio(String namePortfolio);
}