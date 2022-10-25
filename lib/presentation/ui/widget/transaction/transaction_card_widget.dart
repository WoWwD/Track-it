import 'package:flutter/material.dart';
import 'package:track_it/data/model/transaction_model.dart';
import 'package:track_it/service/extension/date_time_extension.dart';
import '../../../../theme/app_styles.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transactionModel;

  const TransactionCard({Key? key, required this.transactionModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {},
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppStyles.borderRadiusApp)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Количество: ${transactionModel.amount}'),
          const SizedBox(height: 4),
          Text('Цена: \$${transactionModel.price}')
        ],
      ),
      subtitle: Text(
        'Дата и время: ${DateTime.parse(transactionModel.dateTime).dateTimeToString()}',
        style: const TextStyle(fontSize: 10)
      ),
      trailing: Text(transactionModel.typeOfTransaction),
    );
  }
}
