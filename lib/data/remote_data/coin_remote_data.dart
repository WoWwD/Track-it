import 'package:dio/dio.dart';
import 'package:track_it/data/model/coin/coin_model.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import 'package:track_it/service/exception/api_exception.dart';
import 'package:track_it/service/helpers.dart';
import 'package:track_it/service/interface/coin_remote_action_interface.dart';
import '../model/coin/market_coin_model.dart';
import 'api/base_api.dart';

class CoinRemoteData extends BaseApi implements CoinRemoteAction {
  final Dio dio;
  final String currency = 'usd';

  CoinRemoteData(this.dio);

  @override
  Future<Coin> getCoinById(String id) async {
    final Response response = await dio.get('${super.baseUrl}/coins/$id');
    if (response.statusCode == 200) {
      return Coin.fromJson(response.data);
    }
    else {
      throw ApiException(response.data.toString(), response.statusCode ?? 0);
    }
  }

  @override
  Future<List<MarketCoin>> getListCoinsByIds(List<String> ids) async {
    final String idsFromList = Helpers.createStringFromItemsList(ids);
    final List<MarketCoin> listCoins = [];
    final Response response =
      await dio.get('${super.baseUrl}/coins/markets?vs_currency=$currency&ids=$idsFromList&order=market_cap_desc&per_page=100&page=1&sparkline=false');
    if (response.statusCode == 200) {
      for (var item in response.data) {
        listCoins.add(MarketCoin.fromJson(item));
      }
      return listCoins;
    }
    else {
      throw ApiException(response.data.toString(), response.statusCode ?? 0);
    }
  }

  @override
  Future<ListSearchCoin> searchCoinByName(String name) async {
    final Response response =  await dio.get('${super.baseUrl}/search?query=$name');
    if (response.statusCode == 200) {
      return ListSearchCoin.fromJson(response.data);
    }
    else {
      throw ApiException(response.data.toString(), response.statusCode ?? 0);
    }
  }
}