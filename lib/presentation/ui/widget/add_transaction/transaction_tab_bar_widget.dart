import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/buy_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/sell_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/transfer_in_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/transfer_out_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/button/add_transaction_button_widget.dart';
import 'package:track_it/service/constant/app_constants_size.dart';

class TransactionTabBar extends StatefulWidget {
  final String idCoin;

  const TransactionTabBar({Key? key, required this.idCoin}) : super(key: key);

  @override
  State<TransactionTabBar> createState() => _TransactionTabBarState();
}

class _TransactionTabBarState extends State<TransactionTabBar> with SingleTickerProviderStateMixin {
  static const _tabLength = 4;
  late TabController _tabController;
  static const _colorTabText = Colors.black;
  final List<Widget> _tabs = const [
    Tab(child: Text('Покупка', style: TextStyle(color: _colorTabText))),
    Tab(child: Text('Продажа', style: TextStyle(color: _colorTabText))),
    Tab(child: Text('Ввод', style: TextStyle(color: _colorTabText))),
    Tab(child: Text('Вывод', style: TextStyle(color: _colorTabText))),
  ];
  final List<Widget> _tabBarChildren = const [
    Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16), child: BuyTransaction()),
    Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16), child: SellTransaction()),
    Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16), child: TransferInTransaction()),
    Padding(padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16), child: TransferOutTransaction())
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
    return DefaultTabController(
      length: _tabLength,
      child: Center(
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH),
          child: Column(
            children: [
              TabBar(
                padding: EdgeInsets.zero,
                labelPadding: EdgeInsets.zero,
                controller: _tabController,
                tabs: _tabs
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: _tabBarChildren
                ),
              ),
              AddTransactionButton(
                onPressed: () {
                  switch(_tabController.index){
                    case 0:
                      print('купил');
                      break;
                    case 1:
                      print('продал');
                      break;
                    case 2:
                      print('ти');
                      break;
                    case 3:
                      print('то');
                      break;
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}