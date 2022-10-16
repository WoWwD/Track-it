class ListSearchCoin {
  final List<SearchCoin> searchCoins;

  ListSearchCoin({
    required this.searchCoins
  });

  factory ListSearchCoin.fromJson(Map<String, dynamic> json) {
    final List<SearchCoin> searchCoins = [];
    json['coins'].forEach((v) {
      searchCoins.add(SearchCoin.fromJson(v));
    });
    return ListSearchCoin(
      searchCoins: searchCoins
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['coins'] = searchCoins.map((v) => v.toJson()).toList();
    return data;
  }
}

class SearchCoin {
  final String id;
  final String name;
  final String apiSymbol;
  final String symbol;
  final int marketCapRank;
  final String thumb;
  final String large;

  SearchCoin({
    required this.id,
    required this.name,
    required this.apiSymbol,
    required this.symbol,
    required this.marketCapRank,
    required this.thumb,
    required this.large,
  });

  factory SearchCoin.fromJson(Map<String, dynamic> json) {
    return SearchCoin(
      id: json['id'],
      name: json['name'],
      apiSymbol: json['apiSymbol'],
      symbol: json['symbol'],
      marketCapRank: json['marketCapRank'],
      thumb: json['thumb'],
      large: json['large'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['name'] = name;
    data['apiSymbol'] = apiSymbol;
    data['symbol'] = symbol;
    data['marketCapRank'] = marketCapRank;
    data['thumb'] = thumb;
    data['large'] = large;
    return data;
  }
}