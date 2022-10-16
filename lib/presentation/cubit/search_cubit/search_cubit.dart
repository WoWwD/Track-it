import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import 'package:track_it/data/repository/remote_repository/coin_remote_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final CoinRemoteRepository coinRemoteRepository;

  SearchCubit({
    required this.coinRemoteRepository
  }) : super(SearchInitial());

  Future<void> init() async {
    //TODO: проверка на наличие интернета
    if (state is! SearchCompleted){
      emit(SearchCompleted(const []));
    }
  }

  Future<void> searchCoinByName(String name) async {
    emit(SearchProcess());
    final List<SearchCoin> listCoins = await coinRemoteRepository.searchCoinByName(name);
    emit(SearchCompleted(listCoins));
  }
}