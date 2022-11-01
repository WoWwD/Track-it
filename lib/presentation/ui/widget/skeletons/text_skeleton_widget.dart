import 'package:flutter/widgets.dart';
import 'package:skeletons/skeletons.dart';
import '../../../../service/constant/app_styles.dart';

class TextSkeleton extends StatelessWidget {
  final double fontSize;

  const TextSkeleton({Key? key, required this.fontSize}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonLine(
      style: SkeletonLineStyle(
        borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp),
        randomLength: true,
        maxLength: 200,
        height: fontSize
      ),
    );
  }
}
