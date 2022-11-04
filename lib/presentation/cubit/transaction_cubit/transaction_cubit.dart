import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/model/asset_model.dart';
import '../../../data/model/portfolio_model.dart';
import '../../../data/model/transaction_model.dart';
import '../../../domain/repository/local_repository/portfolio_local_repository.dart';

part 'transaction_state.dart';

class TransactionCubit extends Cubit<TransactionState> {
  final PortfolioLocalRepository portfolioLocalRepository;

  TransactionCubit({
    required this.portfolioLocalRepository,
  }) : super(TransactionInitial());

  Future<void> getTransactions(String portfolioName, String idCoin) async {
    emit(TransactionLoading());
    final Portfolio? portfolio = await portfolioLocalRepository.getPortfolioByName(portfolioName);
    final Asset assetModel = portfolio!.listAssets.firstWhere((element) => element.idCoin == idCoin);
    emit(TransactionsReceived(assetModel.listTransactions));
  }

  Future<void> deleteTransactionByIndex(
    int listTransactionsLength,
    String portfolioName,
    int indexTransaction,
    String idCoin
  ) async {
    emit(TransactionLoading());
    final Portfolio? portfolioModel = await portfolioLocalRepository.getPortfolioByName(portfolioName);
    if(portfolioModel != null) {
      if(listTransactionsLength == 1) {
        final Asset assetModel = portfolioModel.listAssets.firstWhere((element) => element.idCoin == idCoin);
        portfolioModel.listAssets.remove(assetModel);
        await portfolioLocalRepository.setPortfolio(portfolioName, portfolioModel);
      }
      else{
        final int indexAsset = portfolioModel.listAssets.indexWhere((element) => element.idCoin == idCoin);
        portfolioModel.listAssets[indexAsset].listTransactions.removeAt(indexTransaction);
        await portfolioLocalRepository.setPortfolio(portfolioName, portfolioModel);
        emit(TransactionsReceived(portfolioModel.listAssets[indexAsset].listTransactions));
      }
    }
  }
}
