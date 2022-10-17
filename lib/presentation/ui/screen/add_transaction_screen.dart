import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/presentation/ui/widget/add_transaction/transaction_tab_bar_widget.dart';
import 'package:track_it/presentation/ui/widget/briefly_info_coin_widget.dart';
import 'package:track_it/presentation/ui/widget/loader_widget.dart';
import '../../cubit/transaction_cubit/transaction_cubit.dart';
import 'package:track_it/service/di/di.dart' as di;

class AddTransactionScreen extends StatelessWidget {
  final String idCoin;

  const AddTransactionScreen({Key? key, required this.idCoin}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<TransactionCubit>()..init(idCoin),
      child: BlocBuilder<TransactionCubit, TransactionState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: state is TransactionStart
              ? BrieflyInfoCoin(
                  name: state.coinModel.name,
                  symbol: state.coinModel.symbol,
                  imageUrl: state.coinModel.imageCoin.large
                )
              : const Loader()
            ),
            body: TransactionTabBar(idCoin: idCoin)
          );
        },
      ),
    );
  }
}
