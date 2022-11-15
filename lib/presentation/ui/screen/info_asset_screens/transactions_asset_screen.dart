import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/presentation/ui/screen/transaction_screens/new_transaction_screen.dart';
import 'package:track_it/service/constants/app_styles.dart';
import 'package:track_it/service/di.dart' as di;
import 'package:track_it/service/helpers.dart';
import '../../../cubit/transaction_cubit/transaction_cubit.dart';
import '../../widget/card/transaction_card_widget.dart';

class TransactionsAssetScreen extends StatelessWidget {
  final String portfolioName;
  final MarketCoin marketCoinModel;
  final Function refreshPreviousScreen;

  const TransactionsAssetScreen({
    Key? key,
    required this.portfolioName,
    required this.marketCoinModel,
    required this.refreshPreviousScreen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionCubit>(
      create: (_) => di.getIt<TransactionCubit>()..getTransactions(portfolioName, marketCoinModel.id),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          if (state is TransactionsReceived) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  padding: AppStyles.mainPadding,
                  itemCount: state.listTransactions.length,
                  itemBuilder: (_, index) {
                    return TransactionCard(
                      transactionModel: state.listTransactions[index],
                      marketCoinModel: marketCoinModel,
                      onPressedEdit: (_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) {
                              return NewTransactionScreen(
                                portfolioName: portfolioName,
                                isEdit: true,
                                oldTransactionModel: state.listTransactions[index],
                                indexOldTransaction: index,
                                transactionType: Helpers.getEnumTypeTransaction(state.listTransactions[index].typeOfTransaction),
                                idCoin: marketCoinModel.id,
                                refreshPreviousScreen: () => context.read<TransactionCubit>()
                                  .getTransactions(portfolioName, marketCoinModel.id)
                                  .then((value) => refreshPreviousScreen())
                              );
                            }
                          )
                        );
                      },
                      onPressedDelete: (_) => context.read<TransactionCubit>()
                        .deleteTransactionByIndex(state.listTransactions.length, portfolioName, index, marketCoinModel.id)
                        .then((value) {
                            refreshPreviousScreen();
                            if (state.listTransactions.length == 1) {
                              Navigator.pop(context);
                            }
                          }
                        )
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
}