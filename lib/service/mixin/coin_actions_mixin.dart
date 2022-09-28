import 'package:track_it/data/model/coin_model.dart';

mixin CoinActions {
  Future<Coin> getCoinById(String id);
  Future<List<Coin>> getOnlyCoinsPrice(List<String> ids, {String currency = 'usd'});
}