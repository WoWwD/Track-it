import 'package:flutter/widgets.dart';
import 'package:skeletons/skeletons.dart';
import '../../../../service/constants/app_styles.dart';

class ItemSkeleton extends StatelessWidget {
  final double height;
  final double width;

  const ItemSkeleton({
    Key? key,
    required this.height,
    required this.width
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SkeletonAvatar(
      style: SkeletonAvatarStyle(
        borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp),
        height: height,
        width: width
      ),
    );
  }
}