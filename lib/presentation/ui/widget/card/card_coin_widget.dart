import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/service/extension/double_extension.dart';
import '../../../../theme/app_styles.dart';

class CardCoin extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String symbol;
  final double price;
  final VoidCallback? onTap;
  static const double _iconCoinSize = 36;

  const CardCoin({
    Key? key,
    this.imageUrl = '',
    this.name = '',
    this.symbol = '',
    this.price = 0.0,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
      leading: SizedBox(width: _iconCoinSize, height: _iconCoinSize, child: Image.network(imageUrl)),
      title: Text(name),
      subtitle: Text(symbol.toUpperCase(), style: const TextStyle(fontSize: 10)),
      trailing: Text('\$${price.noZero()}'),
      onTap: onTap,
    );
  }

  Widget buildSkeleton(BuildContext context) {
    return SkeletonListView(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      item: SkeletonListTile(
        contentSpacing: 16,
        leadingStyle: const SkeletonAvatarStyle(width: _iconCoinSize + 4, height: _iconCoinSize + 4),
        titleStyle: const SkeletonLineStyle(randomLength: true),
        subtitleStyle: const SkeletonLineStyle(randomLength: true, height: 14),
        hasSubtitle: true,
      ),
    );
  }
}
