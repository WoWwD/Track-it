import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/provider/transaction_provider/transaction_sell_model.dart';
import 'package:track_it/presentation/provider/transaction_provider/transaction_transfer_in_model.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_sell_widget.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_transfer_in_widget.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_transfer_out_widget.dart';
import '../../../service/constant/app_constants.dart';
import '../../../service/constant/app_styles.dart';
import '../../provider/transaction_provider/transaction_buy_model.dart';
import '../../provider/transaction_provider/transaction_transfer_out_model.dart';
import '../widget/button/add_transaction_button_widget.dart';
import '../widget/transaction/transaction_buy_widget.dart';
import 'package:track_it/service/di.dart' as di;

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
  final List<Widget> _tabsName = const [
    Tab(text: 'Покупка'),
    Tab(text: 'Продажа'),
    Tab(text: 'Ввод'),
    Tab(text: 'Вывод'),
  ];
  final List<Widget> _tabs = const [
    TransactionBuy(),
    TransactionSell(),
    TransactionTransferIn(),
    TransactionTransferOut()
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
          ChangeNotifierProvider<TransactionBuyModel>(create: (_) => di.getIt()),
          ChangeNotifierProvider<TransactionSellModel>(create: (_) => di.getIt()),
          ChangeNotifierProvider<TransactionTransferInModel>(create: (_) => di.getIt()),
          ChangeNotifierProvider<TransactionTransferOutModel>(create: (_) => di.getIt()),
        ],
        builder: (contextProvider, child) {
          return DefaultTabController(
            length: _tabLength,
            child: Center(
              child: Container(
                padding: AppStyles.mainPadding,
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
                      child: Form(
                        key: _formKey,
                        child: TabBarView(controller: _tabController, children: _tabs),
                      ),
                    ),
                    AddTransactionButton(onPressed: _onPressed(contextProvider))
                  ],
                ),
              ),
            ),
          );
        },
      )
    );
  }

  VoidCallback _onPressed(BuildContext contextProvider) {
    return () {
      if(_formKey.currentState!.validate()) {
        switch (_tabController.index) {
          case 0:
            contextProvider.read<TransactionBuyModel>()
              .addTransaction(AppConstants.mainPortfolioStorage, widget.idCoin);
            Navigator.pop(context);
            break;
          case 1:
            contextProvider.read<TransactionSellModel>()
              .addTransaction(AppConstants.mainPortfolioStorage, widget.idCoin);
            Navigator.pop(context);
            break;
          case 2:
            contextProvider.read<TransactionTransferInModel>()
              .addTransaction(AppConstants.mainPortfolioStorage, widget.idCoin);
            Navigator.pop(context);
            break;
          case 3:
            contextProvider.read<TransactionTransferOutModel>()
              .addTransaction(AppConstants.mainPortfolioStorage, widget.idCoin);
            Navigator.pop(context);
            break;
        }
      }
    };
  }
}