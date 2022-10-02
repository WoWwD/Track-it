import 'package:dio/dio.dart';
import 'package:track_it/data/model/coin_model.dart';
import 'package:track_it/service/exception/api_exception.dart';
import 'package:track_it/service/interface/coin_remote_action_interface.dart';
import 'api/base_api.dart';

class CoinRemoteData extends BaseApi implements CoinRemoteAction {
  final Dio dio;

  CoinRemoteData(this.dio);

  @override
  Future<Coin> getCoinById(String id) async {
    Response response = await dio.get('${super.baseUrl}/coins/$id');
    if (response.statusCode == 200) {
      return Coin.fromJson(response.data);
    }
    else {
      throw ApiException(response.data.toString(), response.statusCode ?? 0);
    }
  }

  @override
  Future<List<Coin>> getOnlyCoinsPrice(List<String> ids, {String currency = 'usd'}) async {
    //TODO: доделать
    List<Coin> listCoins = [];
    Response response = await dio.get('${super.baseUrl}/simple/price?ids=bitcoin%2Ccardano&vs_currencies=$currency');
    if (response.statusCode == 200) {
      return listCoins;
    }
    else {
      throw ApiException(response.data.toString(), response.statusCode ?? 0);
    }
  }
}