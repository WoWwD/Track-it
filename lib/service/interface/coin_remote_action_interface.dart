import 'package:track_it/data/model/coin/coin_model.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';

abstract class CoinRemoteAction {
  Future<Coin> getCoinById(String id);
  Future<List<Coin>> getListCoinsByIds(List<String> ids, {String currency = 'usd'});
  Future<List<SearchCoin>> searchCoinByName(String name);
}