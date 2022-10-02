import 'package:track_it/data/model/coin_model.dart';
import 'package:track_it/service/interface/coin_remote_action_interface.dart';
import '../../remote_data/coin_remote_data.dart';

class CoinRemoteRepository implements CoinRemoteAction {
  final CoinRemoteData coinRemoteData;

  CoinRemoteRepository(this.coinRemoteData);

  @override
  Future<Coin> getCoinById(String id) async => await coinRemoteData.getCoinById(id);

  @override
  Future<List<Coin>> getOnlyCoinsPrice(List<String> ids, {String currency = 'usd'}) async
    => await coinRemoteData.getOnlyCoinsPrice(ids);
}