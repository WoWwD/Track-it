import 'package:flutter/material.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/presentation/ui/screen/info_asset_screens/statistics_asset_screen.dart';
import 'package:track_it/presentation/ui/screen/info_asset_screens/transactions_asset_screen.dart';

class InfoAssetScreen extends StatefulWidget {
  final MarketCoin marketCoinModel;
  final String portfolioName;
  final String idCoin;
  final Function refreshPortfolioScreen;

  const InfoAssetScreen({
    Key? key,
    required this.marketCoinModel,
    required this.portfolioName,
    required this.idCoin,
    required this.refreshPortfolioScreen
  }) : super(key: key);

  @override
  State<InfoAssetScreen> createState() => _InfoAssetScreenState();
}

class _InfoAssetScreenState extends State<InfoAssetScreen> with TickerProviderStateMixin {
  static const _tabLength = 2;
  late TabController _tabController;
  final List<Widget> _tabsName = const [
    Tab(text: 'Список транзакций'),
    Tab(text: 'Статистика по монете'),
  ];

  @override
  void initState() {
    _tabController = TabController(length: _tabLength, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: ListTile(
          leading: Image.network(widget.marketCoinModel.image, width: 36, height: 36),
          title: Text('${widget.marketCoinModel.name} #${widget.marketCoinModel.marketCapRank}'),
          subtitle: Text(widget.marketCoinModel.symbol.toUpperCase(), style: const TextStyle(fontSize: 10)),
        ),
      ),
      body: DefaultTabController(
        length: _tabLength,
        child: Column(
          children: [
            TabBar(
              labelColor: Colors.blue,
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              controller: _tabController,
              tabs: _tabsName,
            ),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  TransactionsAssetScreen(
                    portfolioName: widget.portfolioName,
                    marketCoinModel: widget.marketCoinModel,
                    refreshMainScreen: widget.refreshPortfolioScreen,
                  ),
                  StatisticsAssetScreen(portfolioName: widget.portfolioName, idCoin: widget.idCoin)
                ]
              )
            )
          ],
        ),
      )
    );
  }
}
