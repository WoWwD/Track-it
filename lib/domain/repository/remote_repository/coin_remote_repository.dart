import 'package:track_it/data/model/coin/coin_model.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import 'package:track_it/service/interface/coin_remote_action_interface.dart';
import '../../../data/model/coin/market_coin_model.dart';
import '../../../data/remote_data/coin_remote_data.dart';

class CoinRemoteRepository implements CoinRemoteAction {
  final CoinRemoteData coinRemoteData;

  CoinRemoteRepository(this.coinRemoteData);

  @override
  Future<Coin> getCoinById(String id) async => await coinRemoteData.getCoinById(id);

  @override
  Future<List<MarketCoin>> getListCoinsByIds(List<String> ids) async =>
    await coinRemoteData.getListCoinsByIds(ids);

  @override
  Future<ListSearchCoin> searchCoinByName(String name) async => await coinRemoteData.searchCoinByName(name);
}