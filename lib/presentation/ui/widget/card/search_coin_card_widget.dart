import 'package:flutter/material.dart';
import 'package:skeletons/skeletons.dart';

import '../../../../theme/app_styles.dart';

class SearchCoinCard extends StatelessWidget {
  final String imageUrl;
  final String name;
  final String symbol;
  final VoidCallback? onTap;
  static const double _iconCoinSize = 36;
  static const double _iconArrowSize = 18;

  const SearchCoinCard({
    Key? key,
    this.imageUrl = '',
    this.name = '',
    this.symbol = '',
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
      leading: SizedBox(width: _iconCoinSize, height: _iconCoinSize, child: Image.network(imageUrl)),
      title: Text(name),
      subtitle: Text(symbol, style: const TextStyle(fontSize: 10)),
      trailing: const Icon(Icons.arrow_forward_ios, size: _iconArrowSize),
      onTap: onTap,
    );
  }

  Widget buildSkeleton(BuildContext context) {
    return SkeletonListView(
      padding: AppStyles.mainPaddingSkeleton,
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