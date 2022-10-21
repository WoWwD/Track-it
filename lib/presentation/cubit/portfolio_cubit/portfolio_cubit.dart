import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import '../../../data/model/coin/coin_model.dart';
import '../../../data/repository/local_repository/portfolio_local_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioLocalRepository portfolioLocalRepository;

  PortfolioCubit({
    required this.portfolioLocalRepository
  }) : super(PortfolioInitial());

  Future<void> firstLaunch() async {
    if (await portfolioLocalRepository.portfolioStorageIsEmpty()) {
      final Portfolio portfolio = Portfolio(name: AppConstants.MAIN_PORTFOLIO, listAssets: []);
      await portfolioLocalRepository.createPortfolio(portfolio);
    }
  }

  Future<void> addTransaction(String namePortfolio, Coin coinModel, Transaction transactionModel) async
    => await portfolioLocalRepository.addTransaction(namePortfolio, coinModel, transactionModel);
}