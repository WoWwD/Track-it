import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import '../../../data/repository/local_repository/portfolio_local_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioLocalRepository portfolioLocalRepository;
  final String mainPortfolio = 'Main';

  PortfolioCubit({
    required this.portfolioLocalRepository
  }) : super(PortfolioInitial());

  Future<void> firstLaunch() async {
    // if (await portfolioLocalRepository.portfolioStorageIsEmpty()) {
    //   final Portfolio portfolio = Portfolio(name: mainPortfolio, listAssets: []);
    //   portfolioLocalRepository.createPortfolio(portfolio);
    // }
    // final Portfolio portfolio = await portfolioLocalRepository.getPortfolio(mainPortfolio);
    // print(portfolio);
  }

  Future<void> addTransaction(String namePortfolio, Transaction transactionModel) async
    => await portfolioLocalRepository.addTransaction(namePortfolio, transactionModel);
}