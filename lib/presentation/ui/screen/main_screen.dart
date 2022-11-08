import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/presentation/ui/screen/info_asset_screens/info_asset_screen.dart';
import 'package:track_it/presentation/ui/widget/button/icon_button_widget.dart';
import 'package:track_it/presentation/ui/widget/card/card_coin_widget.dart';
import 'package:track_it/presentation/ui/widget/custom_list_view_widget.dart';
import 'package:track_it/presentation/ui/widget/main_screen_widgets/portfolio_statistics_widget.dart';
import 'package:track_it/presentation/ui/widget/primary_modal_bottom_sheet.dart';
import 'package:track_it/presentation/ui/widget/skeletons/item_skeleton_widget.dart';
import 'package:track_it/presentation/ui/widget/skeletons/list_view_skeleton_widget.dart';
import '../../../data/model/coin/market_coin_model.dart';
import '../../../service/constant/app_styles.dart';
import 'bottom_sheet_screens/create_portfolio_screen.dart';
import 'bottom_sheet_screens/list_portfolio_screen.dart';
import 'bottom_sheet_screens/search_coin_screen.dart';
import 'package:track_it/service/di.dart' as di;

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PortfolioCubit>(
      create: (_) => di.getIt()..getPortfolio(),
      child: BlocBuilder<PortfolioCubit, PortfolioState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: _titleAppbar(context),
              actions: [_refreshButton(context)],
            ),
            floatingActionButton: _floatingActionButton(context, state),
            body: Center(
              child: Container(
                padding: const EdgeInsets.only(top: 16),
                constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth),
                child: _getContent(state, context)
              ),
            )
          );
        },
      ),
    );
  }
  Widget _firstAsset() => const Text('Добавьте первый актив в ваш портфель');
  Widget _firstPortfolio() => const Text('Создайте ваш первый портфель');

  Widget _refreshButton(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.only(right: 24),
      child: IconButtonV2(
        onPressed: () => _refreshMainScreen(context),
        icon: const Icon(Icons.refresh)
      ),
    );
  }

  Widget _titleAppbar(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp),
      onTap: () => showPrimaryModalBottomSheet(
        context: context,
        content: ListPortfolioScreen(refreshMainScreen: () => _refreshMainScreen(context)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: const [
            Padding(padding: EdgeInsets.only(bottom: 6.0), child: Text('Список портфелей')),
            SizedBox(width: 4),
            Icon(Icons.arrow_forward_ios, size: 18)
          ],
        ),
      ),
    );
  }

  Widget? _floatingActionButton(BuildContext context, PortfolioState state) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () => showPrimaryModalBottomSheet(
        context: context,
        title: state is PortfolioNotCreated? 'Создание портфеля': 'Добавление актива',
        content: state is PortfolioNotCreated
          ? CreatePortfolioScreen(refreshState: () => _refreshMainScreen(context))
          : SearchCoinScreen(
              portfolioName: state is PortfolioReceived? state.portfolioModel.name: '',
              refreshPortfolioScreen: () => _refreshMainScreen(context),
            ),
        maxHeight: state is PortfolioNotCreated? 150: null,
      )
    );
  }

  Widget _mainScreenSkeleton(double containerHeight, containerWidth) {
    return Column(
      children: [
        ItemSkeleton(height: containerHeight, width: containerWidth),
        const SizedBox(height: 24),
        const Expanded(child: ListViewSkeleton())
      ],
    );
  }

  Widget _getContent(PortfolioState state, BuildContext context) {
    const double containerHeight = 180;
    const double containerWidth = 360;

    if(state is PortfolioNotCreated) return _firstPortfolio();

    return Skeleton(
      isLoading: state is PortfolioLoading,
      skeleton: _mainScreenSkeleton(containerHeight, containerWidth),
      child: state is PortfolioReceived
        ? state.listCoins.isNotEmpty
          ? Column(
            children: [
              PortfolioStatistics(state: state),
              const SizedBox(height: 24),
              Expanded(child: _getCoins(state.listCoins, state.portfolioModel.name, context)),
            ],
          )
          : _firstAsset()
        : const SizedBox()
    );
  }

  Widget _getCoins(List<MarketCoin> listCoins, String portfolioName, BuildContext context) {
    return CustomListView(
      itemCount: listCoins.length,
        itemBuilder: (context, index) {
          return CardCoin(
            imageUrl: listCoins[index].image,
            name: listCoins[index].name,
            symbol: listCoins[index].symbol,
            price: listCoins[index].currentPrice,
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) {
                    return InfoAssetScreen(
                      refreshMainScreen: () => _refreshMainScreen(context),
                      idCoin: listCoins[index].id,
                      marketCoinModel: listCoins[index],
                      portfolioName: portfolioName,
                    );
                  }
                )
              );
            }
          );
        }
    );
  }

  void _refreshMainScreen(BuildContext context) => context.read<PortfolioCubit>().getPortfolio();
}