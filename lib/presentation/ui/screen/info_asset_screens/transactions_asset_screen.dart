import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/presentation/provider/transaction_model.dart';
import 'package:track_it/presentation/ui/screen/add_transaction_screen.dart';
import 'package:track_it/service/constant/app_styles.dart';
import 'package:track_it/service/di.dart' as di;
import 'package:track_it/service/helpers.dart';
import '../../../cubit/portfolio_cubit/portfolio_cubit.dart';
import '../../widget/card/transaction_card_widget.dart';

class TransactionsAssetScreen extends StatelessWidget {
  final String portfolioName;
  final MarketCoin marketCoinModel;

  const TransactionsAssetScreen({
    Key? key,
    required this.portfolioName,
    required this.marketCoinModel
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.getIt<PortfolioCubit>()..emitToPortfolioTransactionsState(portfolioName, marketCoinModel.id),
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          if(state is PortfolioTransactions) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  padding: AppStyles.mainPadding,
                  itemCount: state.listTransactions.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      transactionModel: state.listTransactions[index],
                      marketCoinModel: marketCoinModel,
                      onPressedEdit: _editTransaction(context, state, index),
                      onPressedDelete: (context) =>
                        context.read<PortfolioCubit>()
                          .deleteTransactionByIndex(state.listTransactions.length, portfolioName, index, marketCoinModel.id)
                          .then((value) => state.listTransactions.length == 1? Navigator.pop(context): null),
                    );
                  },
                ),
              ),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }

  Function(BuildContext) _editTransaction(BuildContext contextCubit, PortfolioTransactions state, int index) {
    return (context) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return ChangeNotifierProvider<TransactionModel>(
            create: (_) => di.getIt()..initForEditing(state.listTransactions[index]),
            builder: (context, child) {
              final model = Provider.of<TransactionModel>(context);
              return AddTransactionScreen(
                portfolioName: portfolioName,
                model: model,
                transactionType: Helpers.getEnumTypeTransaction(state.listTransactions[index].typeOfTransaction),
                isEdit: true,
                indexTransaction: index,
                oldTransactionModel: state.listTransactions[index],
              );
            },
          );
        }
      )
    ).then((value) => contextCubit.read<PortfolioCubit>().emitToPortfolioTransactionsState(portfolioName, marketCoinModel.id));
  }
}