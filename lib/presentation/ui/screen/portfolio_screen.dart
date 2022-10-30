import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/ui/screen/info_asset_screens/info_asset_screen.dart';
import 'package:track_it/presentation/ui/widget/button/portfolio_floating_button.dart';
import 'package:track_it/presentation/ui/widget/card/card_coin_widget.dart';
import 'package:track_it/presentation/ui/widget/custom_list_view_widget.dart';
import 'package:track_it/presentation/ui/widget/skeletons/list_view_skeleton_widget.dart';
import 'package:track_it/service/di.dart' as di;
import '../../../service/constant/app_constants.dart';
import '../../../service/constant/app_styles.dart';

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.getIt<PortfolioCubit>()..getPortfolio(AppConstants.mainPortfolioStorage),
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(title: const Text('Портфель')),
            floatingActionButton: PortfolioFloatingButton(
              refreshState: () => context.read<PortfolioCubit>().getPortfolio(AppConstants.mainPortfolioStorage),
              portfolioName: state is PortfolioInit? state.portfolio.name: '',
            ),
            body: Center(
              child: state is PortfolioFirstLaunch
                ? _firstLaunch()
                : Container(
                    constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
                    child: Skeleton(
                      isLoading: state is PortfolioLoading,
                      skeleton: const ListViewSkeleton(),
                      child: state is PortfolioInit? _content(state) : const SizedBox()
                    )
                  ),
            )
          );
        },
      ),
    );
  }
  Widget _firstLaunch() => const Text('Добавьте первый актив в ваш портфель');

  Widget _content(PortfolioInit state) {
    return CustomListView(
      itemCount: state.listCoins.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              CardCoin(
                imageUrl: state.listCoins[index].image,
                name: state.listCoins[index].name,
                symbol: state.listCoins[index].symbol,
                price: state.listCoins[index].currentPrice,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return InfoAssetScreen(
                          idCoin: state.listCoins[index].id,
                          marketCoinModel: state.listCoins[index],
                          portfolioName: state.portfolio.name,
                        );
                      }
                    )
                  ).then((value) => context.read<PortfolioCubit>().getPortfolio(AppConstants.mainPortfolioStorage));
                }
              ),
            ],
          );
        }
    );
  }
}