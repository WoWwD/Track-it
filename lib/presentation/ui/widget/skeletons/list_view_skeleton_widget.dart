import 'package:flutter/widgets.dart';
import 'package:skeletons/skeletons.dart';
import 'package:track_it/presentation/ui/widget/custom_list_view_widget.dart';
import '../../../../theme/app_styles.dart';

class ListViewSkeleton extends StatelessWidget {
  const ListViewSkeleton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomListView(
      itemCount: 10,
        itemBuilder: (context, index) {
          return SkeletonAvatar(
            style: SkeletonAvatarStyle(
              height: 64,
              padding: EdgeInsets.zero,
              borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)
            ),
          );
        }
    );
  }
}
