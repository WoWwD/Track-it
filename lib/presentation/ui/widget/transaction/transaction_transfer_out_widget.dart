import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/provider/transaction_provider/transaction_transfer_out_model.dart';
import 'package:track_it/presentation/ui/widget/transaction/text_field/text_field_transaction_amount_widget.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_general_widget.dart';
import 'text_field/text_field_transaction_widget.dart';

class TransactionTransferOut extends StatelessWidget {
  const TransactionTransferOut({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionTransferOutModel>(
      builder: (context, model, child) {
        return TransactionGeneralWidget(
          children: [
            const SizedBox(height: 24),
            TextFieldTransactionAmount(
              onChanged: (value) => model.setAmount(double.parse(value)),
              initialValue: model.amount.toString(),
            ),
            const SizedBox(height: 24),
            const TextFieldTransaction(labelText: 'Дата'),
            const SizedBox(height: 24),
            const Text('Примечание'),
          ]
        );
      }
    );
  }
}