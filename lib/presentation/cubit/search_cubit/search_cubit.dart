import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import 'package:track_it/service/extension/string_extension.dart';
import '../../../domain/repository/remote_repository/coin_remote_repository.dart';

part 'search_state.dart';

class SearchCubit extends Cubit<SearchState> {
  final CoinRemoteRepository coinRemoteRepository;

  SearchCubit({
    required this.coinRemoteRepository
  }) : super(SearchInitial());

  Future<void> init() async {
    //TODO: проверка на наличие интернета
    emit(FirstLaunch());
  }

  Future<void> searchCoinByName(String name) async {
    final validName = name.noSpace();
    if(validName.isNotEmpty) {
      emit(SearchProcess());
      final ListSearchCoin listSearchCoinModel = await coinRemoteRepository.searchCoinByName(validName);
      if(listSearchCoinModel.searchCoins.isNotEmpty){
        emit(SearchCompleted(listSearchCoinModel.searchCoins));
      }
      else{
        emit(NothingFound());
      }
    }
  }
}