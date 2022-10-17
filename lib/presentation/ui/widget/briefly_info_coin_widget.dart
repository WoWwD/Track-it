import 'package:flutter/widgets.dart';

import 'cached_image_widget.dart';

class BrieflyInfoCoin extends StatelessWidget {
  final String name;
  final String symbol;
  final String imageUrl;

  const BrieflyInfoCoin({
    Key? key,
    required this.name,
    required this.symbol,
    required this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      //TODO: Проблема с длинным названием
      children: [
        CachedImage(imageUrl: imageUrl, typeCachedImage: TypeCachedImage.medium36),
        const SizedBox(width: 16),
        Text(name),
        const SizedBox(width: 6),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              symbol,
              style: const TextStyle(fontSize: 10, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16)
          ],
        )
      ],
    );
  }
}
