import 'package:flutter/material.dart';
import '../../../../service/constant/app_constants_size.dart';
import '../search/search_coin_widget.dart';
import 'icon_button_widget.dart';

class PortfolioFloatingButton extends StatelessWidget {
  const PortfolioFloatingButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(16.0))),
          constraints: const BoxConstraints(maxWidth: AppConstantsSize.MAX_WIDTH, maxHeight: AppConstantsSize.MAX_HEIGHT),
          context: context,
          builder: (BuildContext context) {
            return Column(
              children: [
                Container(
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.only(right: 18, top: 18, bottom: 9),
                  child: IconButtonV2(
                    onPressed: () => Navigator.pop(context), icon: const Icon(Icons.close),
                  ),
                ),
                const Expanded(child: SearchCoinWidget())
              ],
            );
          },
        );
      },
    );
  }
}
