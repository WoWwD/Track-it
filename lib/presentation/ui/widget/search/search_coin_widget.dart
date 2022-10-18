import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:track_it/presentation/ui/screen/add_transaction_screen.dart';
import 'package:track_it/presentation/ui/widget/search_coin_card_widget.dart';
import 'package:track_it/presentation/ui/widget/text_field_transaction_widget.dart';
import 'package:track_it/service/di/di.dart' as di;

class SearchCoinWidget extends StatelessWidget {
  const SearchCoinWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.getIt<SearchCubit>()..init(),
      child: BlocBuilder<SearchCubit, SearchState>(
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              children: [
                TextFieldTransaction(
                  labelText: 'Поиск',
                  onChanged: (String value) => context.read<SearchCubit>().searchCoinByName(value)
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
                            skeleton: const SearchCoinCard().buildSkeleton(context),
                            child: state is SearchCompleted? _content(state): const SizedBox()
                          )
                        )
                    ],
                  ),
                )
              ],
            ),
          );
        }
      ),
    );
  }

  Widget _nothingFound() {
    return const Text('Ничего не найдено');
  }

  Widget _firstLaunch() {
    return const Text('Введите название монеты');
  }

  Widget _content(SearchCompleted state) {
    return ListView.builder(
      itemCount: state.listCoins.length,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      itemBuilder: (context, index) {
        return SearchCoinCard(
          imageUrl: state.listCoins[index].large,
          name: state.listCoins[index].name,
          symbol: state.listCoins[index].symbol,
          onTap: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddTransactionScreen(
                idCoin: state.listCoins[index].id
              )
            )
          ),
        );
      }
    );
  }
}