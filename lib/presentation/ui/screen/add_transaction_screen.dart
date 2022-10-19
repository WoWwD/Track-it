import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/provider/transaction_provider/transaction_sell_model.dart';
import 'package:track_it/presentation/provider/transaction_provider/transaction_transfer_in_model.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_sell_widget.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_transfer_in_widget.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_transfer_out_widget.dart';
import '../../../service/constant/app_constants_size.dart';
import '../../provider/transaction_provider/transaction_buy_model.dart';
import '../../provider/transaction_provider/transaction_transfer_out_model.dart';
import '../widget/button/add_transaction_button_widget.dart';
import '../widget/transaction/transaction_buy_widget.dart';

class AddTransactionScreen extends StatefulWidget {
  final String name;
  final String symbol;
  final String imageUrl;
  final String idCoin;

  const AddTransactionScreen({
    Key? key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.idCoin,
  }) : super(key: key);

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> with TickerProviderStateMixin {
  static const _tabLength = 4;
  late TabController _tabController;
  static const _colorTabText = Colors.black;
  final List<Widget> _tabs = const [
    Tab(child: Text('Покупка', style: TextStyle(color: _colorTabText))),
    Tab(child: Text('Продажа', style: TextStyle(color: _colorTabText))),
    Tab(child: Text('Ввод', style: TextStyle(color: _colorTabText))),
    Tab(child: Text('Вывод', style: TextStyle(color: _colorTabText))),
  ];
  final _formKey = GlobalKey<FormState>();

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
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider<TransactionBuyModel>(create: (_) => TransactionBuyModel()),
          ChangeNotifierProvider<TransactionSellModel>(create: (_) => TransactionSellModel()),
          ChangeNotifierProvider<TransactionTransferInModel>(create: (_) => TransactionTransferInModel()),
          ChangeNotifierProvider<TransactionTransferOutModel>(create: (_) => TransactionTransferOutModel()),
        ],
        child: DefaultTabController(
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
                    tabs: _tabs,
                  ),
                  Form(
                    key: _formKey,
                    child: Expanded(
                      child: TabBarView(
                          controller: _tabController,
                          children: const [
                            TransactionBuy(),
                            TransactionSell(),
                            TransactionTransferIn(),
                            TransactionTransferOut()
                          ]
                      ),
                    ),
                  ),
                  AddTransactionButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        switch (_tabController.index) {
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
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      )
    );
  }
}