import 'package:flutter/material.dart';
import 'package:track_it/presentation/cubit/portfolio_cubit/portfolio_cubit.dart';
import 'package:track_it/service/extensions/double_extension.dart';
import '../../../../service/constants/app_styles.dart';

class PortfolioStatistics extends StatelessWidget {
  final double containerHeight;
  final double containerWidth;
  final PortfolioReceived state;

  const PortfolioStatistics({
    Key? key,
    this.containerHeight = 180,
    this.containerWidth = 360,
    required this.state
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double getAmountInvestment = state.getAmountInvestment();
    final double getCurrentCostPortfolio = state.getCurrentCostPortfolio();

    return Container(
      height: containerHeight,
      width: containerWidth,
      padding: AppStyles.mainPadding,
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(state.portfolioModel.name, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 24),
          Text('Инвестиции: \$${getAmountInvestment.myRound(2)}'),
          const SizedBox(height: 12),
          Text('Текущая стоимость: \$${getCurrentCostPortfolio.myRound(2)}'),
          const SizedBox(height: 12),
          Text('Прибыль: \$${(getCurrentCostPortfolio - getAmountInvestment).myRound(2)}')
        ],
      ),
    );
  }
}