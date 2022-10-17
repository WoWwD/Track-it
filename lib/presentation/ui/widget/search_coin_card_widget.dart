import 'package:flutter/material.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import 'package:track_it/presentation/ui/widget/briefly_info_coin_widget.dart';

class SearchCoinCard extends StatelessWidget {
  final SearchCoin searchCoinModel;
  final VoidCallback? onTap;

  const SearchCoinCard({
    Key? key,
    required this.searchCoinModel,
    this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Row(
          children: [
            BrieflyInfoCoin(imageUrl: searchCoinModel.large, name: searchCoinModel.name, symbol: searchCoinModel.symbol),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        )
      ),
    );
  }
}
