import 'package:flutter/material.dart';
import 'package:track_it/data/model/coin/search_coin_model.dart';
import 'package:track_it/presentation/ui/widget/cached_image_widget.dart';

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
            CachedImage(imageUrl: searchCoinModel.large, typeCachedImage: TypeCachedImage.medium36),
            const SizedBox(width: 16),
            Row(
              //TODO: Проблема с длинным названием
              children: [
                Text(searchCoinModel.name),
                const SizedBox(width: 6),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      searchCoinModel.symbol,
                      style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
                    ),
                    const SizedBox(height: 16)
                  ],
                )
              ],
            ),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios, size: 18),
          ],
        )
      ),
    );
  }
}
