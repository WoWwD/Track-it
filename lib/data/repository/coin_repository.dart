import 'package:track_it/data/model/coin_model.dart';
import 'package:track_it/service/mixin/coin_actions_mixin.dart';

import '../remote_data/api/coin_api.dart';

class CoinRepository implements CoinActions {
  final CoinApi coinApi;

  CoinRepository({required this.coinApi});

  @override
  Future<Coin> getCoinById(String id) async => await coinApi.getCoinById(id);

  @override
  Future<List<Coin>> getOnlyCoinsPrice(List<String> ids, {String currency = 'usd'}) async
    => await coinApi.getOnlyCoinsPrice(ids);
}