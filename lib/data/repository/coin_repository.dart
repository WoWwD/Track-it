import 'package:track_it/data/model/coin_model.dart';
import 'package:track_it/service/interface/coin_action_interface.dart';
import '../remote_data/api/coin_api.dart';

class CoinRepository implements CoinAction {
  final CoinApi coinApi;

  CoinRepository(this.coinApi);

  @override
  Future<Coin> getCoinById(String id) async => await coinApi.getCoinById(id);

  @override
  Future<List<Coin>> getOnlyCoinsPrice(List<String> ids, {String currency = 'usd'}) async
    => await coinApi.getOnlyCoinsPrice(ids);
}