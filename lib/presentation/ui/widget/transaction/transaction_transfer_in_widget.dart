import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/provider/transaction_provider/transaction_transfer_in_model.dart';
import 'package:track_it/presentation/ui/widget/transaction/date_picker_transaction_widget.dart';
import 'package:track_it/presentation/ui/widget/transaction/text_field/text_field_transaction_amount_widget.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_general_widget.dart';
import 'package:track_it/service/extension/string_extension.dart';

class TransactionTransferIn extends StatelessWidget {
  const TransactionTransferIn({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionTransferInModel>(
      builder: (context, model, child) {
        return TransactionGeneralWidget(
          children: [
            const SizedBox(height: 24),
            TextFieldTransactionAmount(
              onChanged: (value) {
                if (value.isNotEmpty) {
                  model.setAmount(double.parse(value));
                }
              },
              initialValue: model.amount == 0.0? '': model.amount.toString(),
            ),
            const SizedBox(height: 24),
            DatePickerTransaction(
              initialDate: model.dateTime,
              onSaved: (value) => model.setDateTime(value?.toDateTime() ?? model.dateTime),
            ),
            const SizedBox(height: 24),
            const Text('Примечание'),
          ],
        );
      }
    );
  }
}
