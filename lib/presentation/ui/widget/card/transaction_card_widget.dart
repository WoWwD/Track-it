import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/extension/double_extension.dart';
import 'package:track_it/service/helpers.dart';
import '../../../../service/constant/app_styles.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transactionModel;
  final Function(BuildContext) onPressedDelete;

  const TransactionCard({
    Key? key,
    required this.transactionModel,
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
            onPressed: onPressedDelete,
            backgroundColor: const Color(0xFFFE4A49),
            foregroundColor: Colors.white,
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
            Text('Количество: ${transactionModel.amount.noZero()}'),
            const SizedBox(height: 2),
            Text('Цена: \$${transactionModel.price.noZero()}')
          ],
        ),
        subtitle: Text(
          'Дата и время: ${transactionModel.dateTime}',
          style: const TextStyle(fontSize: 12)
        ),
        trailing: Text(Helpers.getTypeTransactionFromModel(transactionModel.typeOfTransaction)),
      ),
    );
  }
}