part of 'coin_cubit.dart';

@immutable
abstract class CoinState {}

class CoinInitial extends CoinState {}
class CoinLoading extends CoinState {}
class ListCoinsLoaded extends CoinState {
  final List<Coin> listCoins;

  ListCoinsLoaded(this.listCoins);
}