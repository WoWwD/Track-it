import 'package:flutter/widgets.dart';
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
                  labelText: 'Найти',
                  onChanged: (String value) => context.read<SearchCubit>().searchCoinByName(value)
                ),
                const SizedBox(height: 24),
                if (state is SearchCompleted) ...[
                  Expanded(
                    child: ListView.separated(
                      itemCount: state.listCoins.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 16),
                      itemBuilder: (context, index) {
                        return SearchCoinCard(
                          searchCoinModel: SearchCoin(
                            id: '',
                            name: '',
                            apiSymbol: '',
                            symbol: '',
                            marketCapRank: index,
                            thumb: '',
                            large: '',
                          )
                        );
                      }
                    ),
                  ),
                ],
                if (state is SearchProcess) const Loader()
              ],
            ),
          );
        }
      ),
    );
  }
}