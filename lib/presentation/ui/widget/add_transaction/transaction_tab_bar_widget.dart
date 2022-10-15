import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/buy_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/sell_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/transfer_in_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/transfer_out_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/button/add_transaction_button_widget.dart';

class TransactionTabBar extends StatefulWidget {
  const TransactionTabBar({Key? key}) : super(key: key);

  @override
  State<TransactionTabBar> createState() => _TransactionTabBarState();
}

class _TransactionTabBarState extends State<TransactionTabBar> with SingleTickerProviderStateMixin {
  static const _tabLength = 4;
  late TabController _tabController;
  static const _colorTabText = Colors.black;

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
      child: Padding(
        padding: const EdgeInsets.only(bottom: 16),
        child: Column(
          children: [
            TabBar(
              padding: EdgeInsets.zero,
              labelPadding: EdgeInsets.zero,
              controller: _tabController,
              tabs: const [
                Tab(child: Text('Покупка', style: TextStyle(color: _colorTabText))),
                Tab(child: Text('Продажа', style: TextStyle(color: _colorTabText))),
                Tab(child: Text('Ввод', style: TextStyle(color: _colorTabText))),
                Tab(child: Text('Вывод', style: TextStyle(color: _colorTabText))),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: const [
                  Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: BuyTransaction()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: SellTransaction()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: TransferInTransaction()),
                  Padding(padding: EdgeInsets.symmetric(horizontal: 24), child: TransferOutTransaction())
                ],
              ),
            ),
            const AddTransactionButton()
          ],
        ),
      ),
    );
  }
}