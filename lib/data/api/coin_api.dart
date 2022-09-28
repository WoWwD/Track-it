import 'package:dio/dio.dart';
import 'package:track_it/data/api/base_api.dart';
import 'package:track_it/data/model/coin_model.dart';
import 'package:track_it/service/exception/api_exception.dart';
import 'package:track_it/service/mixin/coin_actions_mixin.dart';

class CoinApi extends BaseApi implements CoinActions {
  final Dio dio;

  CoinApi({required this.dio});

  @override
  Future<Coin> getCoinById(String id) async {
    Response response = await dio.get('${super.baseUrl}/coins/$id');
    if (response.statusCode == 200) {
      return Coin.fromJson(response.data);
    }
    else {
      throw ApiException(errorMessage: response.data.toString(), errorCode: response.statusCode ?? 0);
    }
  }

  @override
  Future<List<Coin>> getOnlyCoinsPrice(List<String> ids, {String currency = 'usd'}) async {
    //TODO: доделать
    List<Coin> listCoins = [];
    Response response = await dio.get('${super.baseUrl}/simple/price?ids=bitcoin%2Ccardano&vs_currencies=$currency');
    if (response.statusCode == 200) {
      for (var coin in response.data) {
        listCoins.add(Coin.fromJson(coin));
      }
      return listCoins;
    }
    else {
      throw ApiException(errorMessage: response.data.toString(), errorCode: response.statusCode ?? 0);
    }
  }
}