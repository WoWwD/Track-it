import 'package:track_it/data/model/coin_model.dart';

abstract class CoinRemoteAction {
  Future<Coin> getCoinById(String id);
  Future<List<Coin>> getListCoinsByIds(List<String> ids, {String currency = 'usd'});
}