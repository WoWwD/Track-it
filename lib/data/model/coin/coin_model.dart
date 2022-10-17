class Coin {
  final String id;
  final String symbol;
  final String name;
  final ImageCoin imageCoin;
  final MarketDataCoin marketDataCoin;

  Coin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.imageCoin,
    required this.marketDataCoin
  });

  factory Coin.fromJson(Map<String, dynamic> json) {
    return Coin(
        id: json['id'],
        symbol: json['symbol'],
        name: json['name'],
        imageCoin: ImageCoin.fromJson(json['image']),
        marketDataCoin: MarketDataCoin.fromJson(json['market_data'])
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['image'] = imageCoin.toJson();
    data['market_data'] = marketDataCoin.toJson();
    return data;
  }
}

class ImageCoin {
  final String thumb;
  final String small;
  final String large;

  ImageCoin({required this.thumb, required this.small, required this.large});

  factory ImageCoin.fromJson(Map<String, dynamic> json) {
    return ImageCoin(thumb: json['thumb'], small: json['small'], large: json['large']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['thumb'] = thumb;
    data['small'] = small;
    data['large'] = large;
    return data;
  }
}

class MarketDataCoin {
  final CurrentPriceCoin currentPriceCoin;
  final MarketCapCoin marketCapCoin;

  MarketDataCoin({
    required this.currentPriceCoin,
    required this.marketCapCoin,
  });

  factory MarketDataCoin.fromJson(Map<String, dynamic> json) {
    return MarketDataCoin(
      currentPriceCoin: CurrentPriceCoin.fromJson(json['current_price']),
      marketCapCoin: MarketCapCoin.fromJson(json['market_cap']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['current_price'] = currentPriceCoin.toJson();
    data['market_cap'] = marketCapCoin.toJson();
    return data;
  }
}

class CurrentPriceCoin {
  final double usd;

  CurrentPriceCoin({required this.usd});

  factory CurrentPriceCoin.fromJson(Map<String, dynamic> json) {
    return CurrentPriceCoin(usd: json['usd']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usd'] = usd;
    return data;
  }
}

class MarketCapCoin {
  final int usd;

  MarketCapCoin({required this.usd});

  factory MarketCapCoin.fromJson(Map<String, dynamic> json) {
    return MarketCapCoin(usd: json['usd']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['usd'] = usd;
    return data;
  }
}