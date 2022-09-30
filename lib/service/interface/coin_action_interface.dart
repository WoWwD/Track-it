import 'package:track_it/data/model/coin_model.dart';

abstract class CoinAction {
  Future<Coin> getCoinById(String id);
  Future<List<Coin>> getOnlyCoinsPrice(List<String> ids, {String currency = 'usd'});
}