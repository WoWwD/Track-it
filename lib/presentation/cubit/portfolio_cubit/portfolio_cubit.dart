import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
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

  Future<void> firstLaunch(String namePortfolio) async {
    emit(PortfolioLoading());
    if (await portfolioLocalRepository.portfolioStorageIsEmpty()) {
      final Portfolio portfolio = Portfolio(name: AppConstants.MAIN_PORTFOLIO, listAssets: []);
      await portfolioLocalRepository.createPortfolio(portfolio);
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
      emit(PortfolioReceived(portfolio, listCoins));
    }
  }

  Future<void> getPortfolio(String namePortfolio) async
    => await portfolioLocalRepository.getPortfolio(namePortfolio);

  List<Transaction> getListTransactionsById(PortfolioReceived state, String idCoin) {
    final List<Transaction> listTransactions = [];
    for(int i = 0; i < state.portfolio.listAssets.length; i++) {
      if (state.portfolio.listAssets[i].idCoin == idCoin) {
        listTransactions.addAll(state.portfolio.listAssets[i].listTransactions);
        break;
      }
    }
    return listTransactions;
  }
}