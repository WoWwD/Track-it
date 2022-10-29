import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import '../../../data/model/asset_model.dart';
import '../../../domain/repository/local_repository/portfolio_local_repository.dart';
import '../../../domain/repository/remote_repository/coin_remote_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioLocalRepository portfolioLocalRepository;
  final CoinRemoteRepository coinRemoteRepository;

  PortfolioCubit({
    required this.portfolioLocalRepository,
    required this.coinRemoteRepository
  }) : super(PortfolioInitial());

  Future<void> getPortfolio(String namePortfolio) async {
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
      emit(PortfolioInit(portfolio, listCoins));
    }
  }

  Future<void> emitToPortfolioTransactionsState(String portfolioName, String idCoin) async {
    emit(PortfolioLoading());
    final Portfolio portfolio = await portfolioLocalRepository.getPortfolio(portfolioName);
    final Asset assetModel = portfolio.listAssets.firstWhere((element) => element.idCoin == idCoin);
    emit(PortfolioTransactions(assetModel.listTransactions));
  }

  List<Transaction> getListTransactionsById(Portfolio portfolio, String idCoin) {
    final List<Transaction> listTransactions = [];
    for(int i = 0; i < portfolio.listAssets.length; i++) {
      if (portfolio.listAssets[i].idCoin == idCoin) {
        listTransactions.addAll(portfolio.listAssets[i].listTransactions);
        break;
      }
    }
    return listTransactions;
  }

  Future<void> deleteTransactionByIndex(int listTransactionsLength, String portfolioName, String idCoin, int index) async {
    emit(PortfolioLoading());
    if(listTransactionsLength == 1) {
      await portfolioLocalRepository.deleteAssetById(portfolioName, idCoin);
    }
    else{
      await portfolioLocalRepository.deleteTransactionByIndex(portfolioName, idCoin, index);
      emitToPortfolioTransactionsState(portfolioName, idCoin);
    }
  }
}