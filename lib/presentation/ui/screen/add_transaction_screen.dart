import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/ui/widget/transaction_widget.dart';
import 'package:track_it/service/transaction_type_enum.dart';
import '../../../service/constant/app_constants.dart';
import '../../../service/constant/app_styles.dart';
import '../../provider/transaction_model.dart';
import 'package:track_it/service/di.dart' as di;
import '../widget/button/add_transaction_button_widget.dart';

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
        create: (_) => TransactionModel(portfolioLocalRepository: di.getIt()),
        builder: (contextBuy, child) {
          return ChangeNotifierProvider<TransactionModel>(
            create: (_) => TransactionModel(portfolioLocalRepository: di.getIt()),
            builder: (contextSell, child) {
              return ChangeNotifierProvider<TransactionModel>(
                create: (_) => TransactionModel(portfolioLocalRepository: di.getIt()),
                builder: (contextTransferIn, child) {
                  return ChangeNotifierProvider<TransactionModel>(
                    create: (_) => TransactionModel(portfolioLocalRepository: di.getIt()),
                    builder: (contextTransferOut, child) {
                      modelBuy = Provider.of<TransactionModel>(contextBuy);
                      modelSell = Provider.of<TransactionModel>(contextSell);
                      modelTransferIn = Provider.of<TransactionModel>(contextTransferIn);
                      modelTransferOut = Provider.of<TransactionModel>(contextTransferOut);

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
                                    child: TabBarView(
                                        controller: _tabController,
                                        children: [
                                          TransactionWidget(model: modelBuy, transactionType: TransactionType.buy),
                                          TransactionWidget(model: modelSell, transactionType: TransactionType.sell),
                                          TransactionWidget(model: modelTransferIn, transactionType: TransactionType.transferIn),
                                          TransactionWidget(model: modelTransferOut, transactionType: TransactionType.transferOut),
                                        ]
                                    ),
                                  ),
                                ),
                                AddTransactionButton(
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()) {
                                      _getModel()!.addTransaction(
                                        AppConstants.mainPortfolioStorage,
                                        widget.idCoin,
                                        _getTypeTransaction()!
                                      );
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