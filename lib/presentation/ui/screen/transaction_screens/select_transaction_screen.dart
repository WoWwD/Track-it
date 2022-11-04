import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/screen/transaction_screens/new_transaction_screen.dart';
import 'package:track_it/service/transaction_type_enum.dart';
import '../../../../service/constant/app_styles.dart';

class SelectTransactionScreen extends StatefulWidget {
  final String name;
  final String symbol;
  final String imageUrl;
  final String idCoin;
  final String portfolioName;
  final Function refreshPreviousScreen;

  const SelectTransactionScreen({
    Key? key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.idCoin,
    required this.portfolioName,
    required this.refreshPreviousScreen
  }) : super(key: key);

  @override
  State<SelectTransactionScreen> createState() => _SelectTransactionScreenState();
}

class _SelectTransactionScreenState extends State<SelectTransactionScreen> with TickerProviderStateMixin {
  static const _tabLength = 4;
  late TabController _tabController;
  final List<Widget> _tabsName = const [
    Tab(text: 'Покупка'),
    Tab(text: 'Продажа'),
    Tab(text: 'Ввод'),
    Tab(text: 'Вывод'),
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
          leading: Image.network(widget.imageUrl, width: 36, height: 36),
          title: Text(widget.name),
          subtitle: Text(widget.symbol, style: const TextStyle(fontSize: 10)),
        )
      ),
      body: DefaultTabController(
        length: _tabLength,
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 16),
            constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
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
                      NewTransactionScreen(
                        portfolioName: widget.portfolioName,
                        transactionType: TransactionType.buy,
                        idCoin: widget.idCoin,
                        refreshPreviousScreen: widget.refreshPreviousScreen
                      ),
                      NewTransactionScreen(
                        portfolioName: widget.portfolioName,
                        transactionType: TransactionType.sell,
                        idCoin: widget.idCoin,
                        refreshPreviousScreen: widget.refreshPreviousScreen
                      ),
                      NewTransactionScreen(
                        portfolioName: widget.portfolioName,
                        transactionType: TransactionType.transferIn,
                        idCoin: widget.idCoin,
                        refreshPreviousScreen: widget.refreshPreviousScreen
                      ),
                      NewTransactionScreen(
                        portfolioName: widget.portfolioName,
                        transactionType: TransactionType.transferOut,
                        idCoin: widget.idCoin,
                        refreshPreviousScreen: widget.refreshPreviousScreen
                      ),
                    ]
                  ),
                ),
              ],
            ),
          ),
        ),
      )
    );
  }
}