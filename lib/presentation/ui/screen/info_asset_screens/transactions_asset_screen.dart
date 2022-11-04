import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/presentation/ui/screen/transaction_screens/new_transaction_screen.dart';
import 'package:track_it/service/constant/app_styles.dart';
import 'package:track_it/service/di.dart' as di;
import '../../../cubit/transaction_cubit/transaction_cubit.dart';
import '../../../provider/transaction_model.dart';
import '../../widget/card/transaction_card_widget.dart';

class TransactionsAssetScreen extends StatelessWidget {
  final String portfolioName;
  final MarketCoin marketCoinModel;
  final Function refreshMainScreen;

  const TransactionsAssetScreen({
    Key? key,
    required this.portfolioName,
    required this.marketCoinModel,
    required this.refreshMainScreen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<TransactionCubit>(
      create: (_) => di.getIt<TransactionCubit>()..getTransactions(portfolioName, marketCoinModel.id),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (contextTransaction, state) {
          if (state is TransactionsReceived) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  padding: AppStyles.mainPadding,
                  itemCount: state.listTransactions.length,
                  itemBuilder: (ctx, index) {
                    return TransactionCard(
                      transactionModel: state.listTransactions[index],
                      marketCoinModel: marketCoinModel,
                      onPressedEdit: (context) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ChangeNotifierProvider<TransactionModel>(
                                create: (_) => TransactionModel(
                                  portfolioLocalRepository: di.getIt()
                                )..initForEditing(state.listTransactions[index]),
                                builder: (context, child) {
                                  final model = Provider.of<TransactionModel>(context);

                                  return NewTransactionScreen(
                                    portfolioName: portfolioName,
                                    model: model,
                                    isEdit: true,
                                    oldTransactionModel: state.listTransactions[index],
                                    indexOldTransaction: index,
                                  );
                                },
                              );
                            }
                          )
                        ).then((value) => _refreshTransactionsScreen(contextTransaction));
                      },
                      onPressedDelete: (_) {
                        ctx.read<TransactionCubit>().deleteTransactionByIndex(
                          state.listTransactions.length,
                          portfolioName,
                          index,
                          marketCoinModel.id
                        ).then((value) {
                          if (state.listTransactions.length == 1) {
                            refreshMainScreen();
                            Navigator.pop(ctx);
                          }
                        });
                      }
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

  void _refreshTransactionsScreen(BuildContext context) =>
    context.read<TransactionCubit>().getTransactions(portfolioName, marketCoinModel.id);
}