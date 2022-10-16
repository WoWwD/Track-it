import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import '../../../data/model/coin/coin_model.dart';
import '../../../data/repository/remote_repository/coin_remote_repository.dart';

part 'coin_state.dart';

class CoinCubit extends Cubit<CoinState> {
  final CoinRemoteRepository coinRepository;

  CoinCubit({
    required this.coinRepository
  }) : super(CoinInitial());

  Future<void> getListCoinsByIds(List<String> ids) async {
    emit(CoinLoading());
    final res = await coinRepository.getListCoinsByIds(ids);
    emit(ListCoinsLoaded(res));
  }
}
