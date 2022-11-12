import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:track_it/data/model/coin/market_coin_model.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/constant/app_constants.dart';
import 'package:track_it/service/extension/double_extension.dart';
import 'package:track_it/service/helpers.dart';
import '../../../../service/constant/app_styles.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transactionModel;
  final MarketCoin marketCoinModel;
  final Function(BuildContext) onPressedEdit;
  final Function(BuildContext) onPressedDelete;

  const TransactionCard({
    Key? key,
    required this.transactionModel,
    required this.marketCoinModel,
    required this.onPressedEdit,
    required this.onPressedDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        dragDismissible: false,
        motion: const DrawerMotion(),
        children: [
          SlidableAction(
            onPressed: onPressedEdit,
            backgroundColor: Colors.blueAccent,
            icon: Icons.edit,
            label: 'Изменить',
          ),
          SlidableAction(
            onPressed: onPressedDelete,
            backgroundColor: Colors.redAccent,
            icon: Icons.delete,
            label: 'Удалить',
          ),
        ],
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _isBuyOrSell()? const SizedBox(): const Text(' '),
            Text(
              '${Helpers.typeTransactionFromModel(transactionModel.typeOfTransaction)} '
              '${transactionModel.amount.myRound()} ${marketCoinModel.symbol.toUpperCase()}'
            ),
            _isBuyOrSell()? Text('Цена: \$${transactionModel.price.myRound()}'): const SizedBox(),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(
              'Дата и время: ${transactionModel.dateTime}',
              style: const TextStyle(fontSize: 12)
            ),
          ],
        ),
        trailing: _isBuyOrSell()? Text('Стоимость: \$${transactionModel.cost.myRound()}'): const SizedBox(),
      ),
    );
  }

  bool _isBuyOrSell()
  => transactionModel.typeOfTransaction == AppConstants.buyTypeTransaction ||
     transactionModel.typeOfTransaction == AppConstants.sellTypeTransaction;
}