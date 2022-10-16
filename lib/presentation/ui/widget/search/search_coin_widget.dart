import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import 'package:track_it/presentation/cubit/search_cubit/search_cubit.dart';
import 'package:track_it/presentation/ui/widget/loader_widget.dart';
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
                      if (state is SearchCompleted) _searchCompleted(state),
                      if (state is SearchProcess) _searchProcess(),
                      if (state is NothingFound) _nothingFound()
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

  Widget _searchProcess() {
    return const Loader();
  }

  Widget _firstLaunch() {
    return const Text('Введите название монеты');
  }

  Widget _searchCompleted(SearchCompleted state) {
    return Expanded(
      child: ListView.separated(
        itemCount: state.listCoins.length,
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
        separatorBuilder: (context, index) => const Divider(height: 4),
        itemBuilder: (context, index) {
          return SearchCoinCard(
            searchCoinModel: SearchCoin(
              id: state.listCoins[index].id,
              name: state.listCoins[index].name,
              symbol: state.listCoins[index].symbol,
              large: state.listCoins[index].large,
            ),
            onTap: () => print('test'),
          );
        }
      ),
    );
  }
}