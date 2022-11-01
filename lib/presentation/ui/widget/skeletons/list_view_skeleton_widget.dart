import 'package:flutter/widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/presentation/ui/widget/custom_list_view_widget.dart';
import '../../../../service/constant/app_styles.dart';

class ListViewSkeleton extends StatelessWidget {
  final double height;

  const ListViewSkeleton({
    Key? key,
    this.height = 64
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemCount: 10,
        itemBuilder: (context, index) {
          return SkeletonAvatar(
            style: SkeletonAvatarStyle(
              height: height,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)
            ),
          );
        }
    );
  }
}
