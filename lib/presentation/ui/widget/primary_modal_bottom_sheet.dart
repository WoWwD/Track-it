import 'package:flutter/material.dart';
import '../../../service/constant/app_styles.dart';
import 'button/icon_button_widget.dart';

Future<void> showPrimaryModalBottomSheet({
    required BuildContext context,
    required Widget content,
    bool? isScrollControlled,
    String? title,
    double? maxHeight,
  }) async {
   showModalBottomSheet<void>(
    isScrollControlled: isScrollControlled ?? false,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.borderRadiusApp))
    ),
    constraints: BoxConstraints(maxWidth: AppStyles.maxWidth, maxHeight: maxHeight ?? 600),
    context: context,
    builder: (BuildContext context) {
      return Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              width: 30,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey,
                borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)
              ),
            )
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18, right: 18, top: 18, bottom: 9),
            child: Row(
              children: [
                Text(title ?? ''),
                const Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  child: IconButtonV2(onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close)),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          Expanded(child: content)
        ],
      );
    }
  );
}
