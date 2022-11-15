import 'package:flutter/widgets.dart';
import '../../../service/constants/app_styles.dart';

class CustomListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;
  final ScrollPhysics? physics;

  const CustomListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder,
    this.physics
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: physics ?? const AlwaysScrollableScrollPhysics(),
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: itemCount,
      padding: AppStyles.mainPadding,
      itemBuilder: itemBuilder
    );
  }
}