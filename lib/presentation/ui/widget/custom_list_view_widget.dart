import 'package:flutter/widgets.dart';
import '../../../service/constant/app_styles.dart';

class CustomListView extends StatelessWidget {
  final int itemCount;
  final IndexedWidgetBuilder itemBuilder;

  const CustomListView({
    Key? key,
    required this.itemCount,
    required this.itemBuilder
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemCount: itemCount,
      padding: AppStyles.mainPadding,
      itemBuilder: itemBuilder
    );
  }
}
