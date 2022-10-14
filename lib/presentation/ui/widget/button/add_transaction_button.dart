import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:track_it/theme/colors/app_colors_light_theme.dart';
import '../../../../service/constant/app_constants_size.dart';

import '../add_transaction_widget.dart';

class AddTransactionButton extends StatelessWidget {
  const AddTransactionButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
          backgroundColor: AppColorsLightTheme.COLOR_BOTTOM_SHEET_LIGHT,
          constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH),
          context: context,
          builder: (BuildContext context) {
            return const AddTransactionWidget();
          },
        );
      },
    );
  }
}
