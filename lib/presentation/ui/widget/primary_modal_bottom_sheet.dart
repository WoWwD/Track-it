import 'package:flutter/material.dart';
import '../../../service/constant/app_styles.dart';
import 'button/icon_button_widget.dart';

Future<void> showPrimaryModalBottomSheet(BuildContext context, Widget content, [double maxHeight = 600]) async {
   showModalBottomSheet<void>(
    isScrollControlled: true,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.borderRadiusApp))
    ),
    constraints: BoxConstraints(maxWidth: AppStyles.maxWidth, maxHeight: maxHeight),
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Container(
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.only(right: 18, top: 18, bottom: 9),
            child: IconButtonV2(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
          ),
          Expanded(child: content)
        ],
      );
    }
  );
}