import 'package:flutter/material.dart';
import '../../../../service/constant/app_styles.dart';
import '../bottom_sheet_content/search_coin_widget.dart';

class PortfolioFloatingButton extends StatelessWidget {
  final Function refreshState;
  final String portfolioName;

  const PortfolioFloatingButton({
    Key? key,
    required this.refreshState,
    required this.portfolioName
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        showModalBottomSheet<void>(
          isScrollControlled: true,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(AppStyles.borderRadiusApp))
          ),
          constraints: const BoxConstraints(maxWidth: AppStyles.maxWidth, maxHeight: 600),
          context: context,
          builder: (BuildContext context) => SearchCoinWidget(refreshState: refreshState, portfolioName: portfolioName)
        );
      },
    );
  }
}
