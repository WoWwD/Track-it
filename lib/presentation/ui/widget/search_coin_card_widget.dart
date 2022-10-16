import 'package:flutter/material.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import 'package:track_it/presentation/ui/widget/cached_image_widget.dart';

class SearchCoinCard extends StatelessWidget {
  final SearchCoin searchCoinModel;

  const SearchCoinCard({Key? key, required this.searchCoinModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 14),
        child: Row(
          children: [
            CachedImage(imageUrl: searchCoinModel.thumb),
            const SizedBox(width: 16),
            Text(searchCoinModel.name)
          ],
        )
      ),
    );
  }
}
