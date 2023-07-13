import 'package:track_it/data/model/coin/coin_model.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import '../../data/model/coin/market_coin_model.dart';

abstract class CoinRemoteAction {
  Future<Coin> getCoinById(String id);
  Future<List<MarketCoin>> getListCoinsByIds(List<String> ids);
  Future<ListSearchCoin> searchCoinByName(String name);
}