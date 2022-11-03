import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:track_it/presentation/ui/widget/add_transaction_tab_bar_widget.dart';
import 'package:track_it/presentation/ui/widget/card/search_coin_card_widget.dart';
import 'package:track_it/presentation/ui/widget/custom_list_view_widget.dart';
import 'package:track_it/service/di.dart' as di;

import '../../widget/skeletons/list_view_skeleton_widget.dart';
import '../../widget/text_field/primary_text_field.dart';

class SearchCoinScreen extends StatelessWidget {
  final String portfolioName;
  final Function refreshPortfolioScreen;

  const SearchCoinScreen({
    Key? key,
    required this.portfolioName,
    required this.refreshPortfolioScreen
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<SearchCubit>()..init(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: PrimaryTextField(
                  labelText: 'Поиск',
                  onChanged: (String value) => context.read<SearchCubit>().searchCoinByName(value)
                ),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (state is FirstLaunch) _firstLaunch(),
                    if (state is NothingFound) _nothingFound(),
                    if (state is SearchProcess || state is SearchCompleted)
                      Expanded(
                        child: Skeleton(
                          isLoading: state is SearchProcess,
                          skeleton: const ListViewSkeleton(),
                          child: state is SearchCompleted? _content(state): const SizedBox()
                        )
                      )
                  ],
                ),
              )
            ],
          );
        }
      ),
    );
  }

  Widget _nothingFound() => const Text('Ничего не найдено');
  Widget _firstLaunch() => const Text('Введите название монеты');

  Widget _content(SearchCompleted state) {
    return CustomListView(
      itemCount: state.listCoins.length,
        itemBuilder: (context, index) {
          return SearchCoinCard(
            imageUrl: state.listCoins[index].large,
            name: state.listCoins[index].name,
            symbol: state.listCoins[index].symbol,
            onTap: _onTapCard(context, state, index)
          );
        }
    );
  }

  void Function() _onTapCard(BuildContext context, SearchCompleted state, int index) {
    return () => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return AddTransactionTabBar(
            refreshPortfolioScreen: refreshPortfolioScreen,
            name: state.listCoins[index].name,
            symbol: state.listCoins[index].symbol,
            imageUrl: state.listCoins[index].large,
            idCoin: state.listCoins[index].id,
            portfolioName: portfolioName,
          );
        }
      )
    );
  }
}