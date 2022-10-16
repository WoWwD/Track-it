part of 'search_cubit.dart';

@immutable
abstract class SearchState {}

class SearchInitial extends SearchState {}
class SearchProcess extends SearchState {}
class SearchCompleted extends SearchState {
  final List<SearchCoin> listCoins;

  SearchCompleted(this.listCoins);
}
