import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/portfolio_model.dart';
import '../../../data/repository/local_repository/portfolio_local_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final PortfolioLocalRepository portfolioLocalRepository;

  PortfolioCubit({
    required this.portfolioLocalRepository
  }) : super(PortfolioInitial());

  Future<void> addPortfolio(Portfolio portfolio) async {
    emit(PortfolioLoading());
    await portfolioLocalRepository.addPortfolio(portfolio);
    emit(PortfolioCreated());
  }

  Future<void> deletePortfolio(String name) async {
    emit(PortfolioLoading());
    await portfolioLocalRepository.deletePortfolio(name);
    emit(PortfolioDeleted());
  }

  Future<void> getPortfolio(String name) async {
    emit(PortfolioLoading());
    final res = await portfolioLocalRepository.getPortfolio(name);
    emit(PortfolioReceived(res));
  }

  Future<bool> portfolioStorageIsEmpty() async => await portfolioLocalRepository.portfolioStorageIsEmpty();
}