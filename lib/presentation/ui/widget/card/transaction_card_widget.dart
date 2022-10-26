import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/extension/date_time_extension.dart';
import 'package:track_it/service/extension/double_extension.dart';
import '../../../../theme/app_styles.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transactionModel;
  final Function(BuildContext) onPressedDelete;
  final Function(BuildContext) onPressedEdit;

  const TransactionCard({
    Key? key,
    required this.transactionModel,
    required this.onPressedDelete,
    required this.onPressedEdit
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
            backgroundColor: const Color(0xFF49B0FE),
            foregroundColor: Colors.white,
            icon: Icons.edit,
            label: 'Изменить',
          ),
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
            const SizedBox(height: 4),
            Text('Цена: \$${transactionModel.price.noZero()}')
          ],
        ),
        subtitle: Text(
          'Дата и время: ${DateTime.parse(transactionModel.dateTime).dateTimeToString()}',
          style: const TextStyle(fontSize: 10)
        ),
        trailing: Text(transactionModel.typeOfTransaction),
      ),
    );
  }
}