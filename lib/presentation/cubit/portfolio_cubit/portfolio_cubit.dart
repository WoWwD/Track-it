import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import '../../../data/repository/local_repository/portfolio_local_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioLocalRepository portfolioLocalRepository;

  PortfolioCubit({
    required this.portfolioLocalRepository
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
      emit(PortfolioReceived(portfolio));
    }
  }

  Future<void> addTransaction(String namePortfolio, String idCoin, Transaction transactionModel) async
  => await portfolioLocalRepository.addTransaction(namePortfolio, idCoin, transactionModel);

  Future<void> getPortfolio(String namePortfolio) async
    => await portfolioLocalRepository.getPortfolio(namePortfolio);
}