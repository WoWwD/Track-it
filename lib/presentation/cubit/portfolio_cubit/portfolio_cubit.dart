import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin_model.dart';
import 'package:track_it/data/repository/remote_repository/coin_remote_repository.dart';
import '../../../data/repository/local_repository/portfolio_local_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final CoinRemoteRepository coinRepository;
  final PortfolioLocalRepository portfolioLocalRepository;

  PortfolioCubit({
    required this.coinRepository,
    required this.portfolioLocalRepository
  }) : super(PortfolioInitial());

  Future<void> firstLaunch() async {
    emit(PortfolioLoading());
    final List<String> list = ['bitcoin,reef,cardano'];
    final res = await coinRepository.getListCoins(list);
    emit(PortfolioLoaded(res));
  }
}
