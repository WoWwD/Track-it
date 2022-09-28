import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/repository/coin_repository.dart';

part 'portfolio_state.dart';

class PortfolioCubit extends Cubit<PortfolioState> {
  final CoinRepository coinRepository;

  PortfolioCubit({
    required this.coinRepository
  }) : super(PortfolioInitial());
}
