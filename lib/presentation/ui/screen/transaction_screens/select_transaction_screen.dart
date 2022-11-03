import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/ui/screen/transaction_screens/new_transaction_screen.dart';
import 'package:track_it/service/transaction_type_enum.dart';
import '../../../../service/constant/app_styles.dart';
import '../../../provider/transaction_model.dart';
import 'package:track_it/service/di.dart' as di;
import '../../widget/button/primary_button_widget.dart';

class AddTransactionTabBar extends StatefulWidget {
  final String name;
  final String symbol;
  final String imageUrl;
  final String idCoin;
  final String portfolioName;
  final Function refreshPortfolioScreen;

  const AddTransactionTabBar({
    Key? key,
    required this.name,
    required this.symbol,
    required this.imageUrl,
    required this.idCoin,
    required this.portfolioName,
    required this.refreshPortfolioScreen
  }) : super(key: key);

  @override
  State<AddTransactionTabBar> createState() => _AddTransactionTabBarState();
}

class _AddTransactionTabBarState extends State<AddTransactionTabBar> with TickerProviderStateMixin {
  static const _tabLength = 4;
  late TabController _tabController;
  final List<Widget> _tabsName = const [
    Tab(text: 'Покупка'),
    Tab(text: 'Продажа'),
    Tab(text: 'Ввод'),
    Tab(text: 'Вывод'),
  ];
  final _formKey = GlobalKey<FormState>();
  late TransactionModel modelBuy;
  late TransactionModel modelSell;
  late TransactionModel modelTransferIn;
  late TransactionModel modelTransferOut;

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
      body: ChangeNotifierProvider<TransactionModel>(
        create: (_) => di.getIt(),
        builder: (contextBuy, child) {
          return ChangeNotifierProvider<TransactionModel>(
            create: (_) => di.getIt(),
            builder: (contextSell, child) {
              return ChangeNotifierProvider<TransactionModel>(
                create: (_) => di.getIt(),
                builder: (contextTransferIn, child) {
                  return ChangeNotifierProvider<TransactionModel>(
                    create: (_) => di.getIt(),
                    builder: (contextTransferOut, child) {
                      modelBuy = Provider.of<TransactionModel>(contextBuy);
                      modelSell = Provider.of<TransactionModel>(contextSell);
                      modelTransferIn = Provider.of<TransactionModel>(contextTransferIn);
                      modelTransferOut = Provider.of<TransactionModel>(contextTransferOut);

                      return DefaultTabController(
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
                                  child: Form(
                                    key: _formKey,
                                    child: TabBarView(
                                      controller: _tabController,
                                      children: [
                                        AddTransactionScreen(model: modelBuy, transactionType: TransactionType.buy),
                                        AddTransactionScreen(model: modelSell, transactionType: TransactionType.sell),
                                        AddTransactionScreen(model: modelTransferIn, transactionType: TransactionType.transferIn),
                                        AddTransactionScreen(model: modelTransferOut, transactionType: TransactionType.transferOut),
                                      ]
                                    ),
                                  ),
                                ),
                                PrimaryButton(
                                  text: 'Добавить',
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()) {
                                      _getModel()!.addTransaction(
                                        widget.portfolioName,
                                        widget.idCoin,
                                        _getTypeTransaction()!
                                      ).then((value) => widget.refreshPortfolioScreen());
                                      Navigator.pop(context);
                                    }
                                  }
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              );
            },
          );
        },
      )
    );
  }

  TransactionModel? _getModel() {
    switch (_tabController.index) {
      case 0: return modelBuy;
      case 1: return modelSell;
      case 2: return modelTransferIn;
      case 3: return modelTransferOut;
    }
    return null;
  }

  TransactionType? _getTypeTransaction() {
    switch (_tabController.index) {
      case 0: return TransactionType.buy;
      case 1: return TransactionType.sell;
      case 2: return TransactionType.transferIn;
      case 3: return TransactionType.transferOut;
    }
    return null;
  }
}