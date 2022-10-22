class MarketCoin {
  final String id;
  final String symbol;
  final String name;
  final String image;
  final double currentPrice;
  final double marketCap;
  final int marketCapRank;
  final double high24h;
  final double low24h;
  final double priceChangePercentage24h;
  final double marketCapChangePercentage24h;
  final double ath;
  final double athChangePercentage;
  final String athDate;
  final double atl;
  final double atlChangePercentage;
  final String atlDate;

  MarketCoin({
    required this.id,
    required this.symbol,
    required this.name,
    required this.image,
    required this.currentPrice,
    required this.marketCap,
    required this.marketCapRank,
    required this.high24h,
    required this.low24h,
    required this.priceChangePercentage24h,
    required this.marketCapChangePercentage24h,
    required this.ath,
    required this.athChangePercentage,
    required this.athDate,
    required this.atl,
    required this.atlChangePercentage,
    required this.atlDate
  });

  factory MarketCoin.fromJson(Map<String, dynamic> json) {
    return MarketCoin(
      id: json['id'],
      symbol: json['symbol'],
      name: json['name'],
      image: json['image'],
      currentPrice: json['current_price'],
      marketCap: json['market_cap'].toDouble(),
      marketCapRank: json['market_cap_rank'] ?? 0,
      high24h: json['high_24h'],
      low24h: json['low_24h'],
      priceChangePercentage24h: json['price_change_percentage_24h'],
      marketCapChangePercentage24h: json['market_cap_change_percentage_24h'],
      ath: json['ath'].toDouble(),
      athChangePercentage: json['ath_change_percentage'],
      athDate: json['ath_date'],
      atl: json['atl'],
      atlChangePercentage: json['atl_change_percentage'],
      atlDate: json['atl_date']
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic> {};
    data['id'] = id;
    data['symbol'] = symbol;
    data['name'] = name;
    data['image'] = image;
    data['current_price'] = currentPrice;
    data['market_cap'] = marketCap;
    data['market_cap_rank'] = marketCapRank;
    data['high_24h'] = high24h;
    data['low_24h'] = low24h;
    data['price_change_percentage_24h'] = priceChangePercentage24h;
    data['market_cap_change_percentage_24h'] = marketCapChangePercentage24h;
    data['ath'] = ath;
    data['ath_change_percentage'] = athChangePercentage;
    data['ath_date'] = athDate;
    data['atl'] = atl;
    data['atl_change_percentage'] = atlChangePercentage;
    data['atl_date'] = atlDate;
    return data;
  }
}