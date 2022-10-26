import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/presentation/ui/widget/card/transaction_card_widget.dart';
import 'package:track_it/service/constant/app_constants_size.dart';
import '../../../data/model/portfolio_model.dart';
import '../../../theme/app_styles.dart';
import 'package:track_it/service/di/di.dart' as di;
import '../../cubit/portfolio_cubit/portfolio_cubit.dart';

class InfoAssetScreen extends StatelessWidget {
  final Portfolio portfolioModel;
  final MarketCoin marketCoinModel;

  const InfoAssetScreen({
    Key? key,
    required this.marketCoinModel,
    required this.portfolioModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.getIt<PortfolioCubit>()..getListTransactionsById(portfolioModel, marketCoinModel.id),
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: ListTile(
                leading: Image.network(marketCoinModel.image, width: 36, height: 36),
                title: Text('${marketCoinModel.name} #${marketCoinModel.marketCapRank}'),
                subtitle: Text(marketCoinModel.symbol.toUpperCase(), style: const TextStyle(fontSize: 10)),
              ),
            ),
            body: BlocBuilder<PortfolioCubit, PortfolioState>(
              builder: (context, state) {
                if(state is PortfolioTransactions) {
                  return Center(
                    child: Container(
                      padding: AppStyles.paddingScreen,
                      constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH),
                      child: Column(
                        children: [
                          const Text('Список транзакций:'),
                          const SizedBox(height: 24),
                          Expanded(
                            child: ListView.separated(
                              separatorBuilder: (context, index) => const SizedBox(height: 16),
                              padding: AppStyles.paddingListView,
                              itemCount: state.listTransactions.length,
                              itemBuilder: (context, index) {
                                return TransactionCard(
                                  transactionModel: state.listTransactions[index],
                                  onPressedDelete: (BuildContext context) =>
                                    context.read<PortfolioCubit>().deleteTransactionByIndex(state, index),
                                  onPressedEdit: (BuildContext context) => print('отредактировал'),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
                return const SizedBox();
              },
            )
          );
        },
      ),
    );
  }
}
