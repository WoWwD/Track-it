import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import '../../../data/repository/local_repository/portfolio_local_repository.dart';
import '../../../data/repository/remote_repository/coin_remote_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioLocalRepository portfolioLocalRepository;
  final CoinRemoteRepository coinRemoteRepository;

  PortfolioCubit({
    required this.portfolioLocalRepository,
    required this.coinRemoteRepository
  }) : super(PortfolioInitial());

  Future<void> getPortolio(String namePortfolio) async {
    emit(PortfolioLoading());
    if (await portfolioLocalRepository.portfolioStorageIsEmpty(namePortfolio)) {
      await portfolioLocalRepository.createPortfolio(namePortfolio);
    }
    final Portfolio portfolio = await portfolioLocalRepository.getPortfolio(namePortfolio);
    if(portfolio.listAssets.isEmpty) {
      emit(PortfolioFirstLaunch());
    }
    else {
      final List<String> ids = [];
      for(int i = 0; i < portfolio.listAssets.length; i++) {
        ids.add(portfolio.listAssets[i].idCoin);
      }
      final List<MarketCoin> listCoins = await coinRemoteRepository.getListCoinsByIds(ids);
      emit(PortfolioCoins(portfolio, listCoins));
    }
  }

  void getListTransactionsById(Portfolio portfolio, String idCoin) {
    emit(PortfolioLoading());
    final List<Transaction> listTransactions = [];
    for(int i = 0; i < portfolio.listAssets.length; i++) {
      if (portfolio.listAssets[i].idCoin == idCoin) {
        listTransactions.addAll(portfolio.listAssets[i].listTransactions);
        break;
      }
    }
    emit(PortfolioTransactions(portfolio, idCoin, listTransactions));
  }

  Future<void> deleteTransactionByIndex(PortfolioTransactions state, int index) async {
    emit(PortfolioLoading());
    if(state.listTransactions.length == 1) {
      state.listTransactions.removeAt(index);
      await portfolioLocalRepository.deleteAssetById(state.portfolio.name, state.idCoin);
    }
    else{
      await portfolioLocalRepository.deleteTransactionByIndex(state.portfolio.name, state.idCoin, index);
    }
    emit(PortfolioTransactions(state.portfolio, state.idCoin, state.listTransactions));
  }
}