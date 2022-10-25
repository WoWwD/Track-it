import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/ui/screen/info_asset_screen.dart';
import 'package:track_it/presentation/ui/widget/button/portfolio_floating_button.dart';
import 'package:track_it/presentation/ui/widget/card/card_coin_widget.dart';
import 'package:track_it/service/constant/app_constants_size.dart';
import 'package:track_it/service/di/di.dart' as di;
import 'package:track_it/theme/app_styles.dart';
import '../../../service/constant/app_constants.dart';
import '../widget/first_launch_widget.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: const PortfolioFloatingButton(),
      appBar: AppBar(title: const Text('Портфолио')),
      body: BlocProvider(
        create: (_) => di.getIt<PortfolioCubit>()..firstLaunch(AppConstants.MAIN_PORTFOLIO),
        child: Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH),
            child: Column(
              children: [
                BlocBuilder<PortfolioCubit, PortfolioState>(
                  builder: (context, state) {
                    if(state is PortfolioReceived || state is PortfolioLoading) {
                      return Expanded(
                        child: Skeleton(
                          isLoading: state is PortfolioLoading,
                          skeleton: const CardCoin().buildSkeleton(context),
                          child: state is PortfolioReceived? _content(state): const SizedBox()
                        )
                      );
                    }
                    if(state is PortfolioFirstLaunch) return const Center(child: FirstLaunchWidget());
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _content(PortfolioReceived state) {
    return ListView.builder(
      itemCount: state.listCoins.length,
      padding: AppStyles.paddingListView,
      itemBuilder: (context, index) {
        return CardCoin(
          imageUrl: state.listCoins[index].image,
          name: state.listCoins[index].name,
          symbol: state.listCoins[index].symbol,
          price: state.listCoins[index].currentPrice,
          onTap: () {
            final List<Transaction> listTransaction =
              context.read<PortfolioCubit>().getListTransactionsById(state, state.listCoins[index].id);
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InfoAssetScreen(
                  marketCoinModel: state.listCoins[index],
                  listTransactions: listTransaction
                )
              )
            );
          }
        );
      }
    );
  }
}