import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/service/di.dart' as di;
import '../../../../service/constant/app_constants_size.dart';
import '../../../../theme/app_styles.dart';
import '../../../cubit/portfolio_cubit/portfolio_cubit.dart';
import '../../widget/card/transaction_card_widget.dart';

class TransactionsAssetScreen extends StatelessWidget {
  final String portfolioName;
  final String idCoin;

  const TransactionsAssetScreen({
    Key? key,
    required this.portfolioName,
    required this.idCoin
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.getIt<PortfolioCubit>()..emitToPortfolioTransactionsState(portfolioName, idCoin),
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          if(state is PortfolioTransactions) {
            return Center(
              child: Container(
                constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH),
                child: ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  padding: AppStyles.mainPadding,
                  itemCount: state.listTransactions.length,
                  itemBuilder: (context, index) {
                    return TransactionCard(
                      transactionModel: state.listTransactions[index],
                      onPressedDelete: (BuildContext context) =>
                        context.read<PortfolioCubit>()
                          .deleteTransactionByIndex(state.listTransactions.length, portfolioName, idCoin, index)
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
}
