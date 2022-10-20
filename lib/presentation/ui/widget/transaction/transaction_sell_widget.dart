import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/ui/widget/transaction/text_field/text_field_transaction_note_widget.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_general_widget.dart';
import '../../../provider/transaction_provider/transaction_sell_model.dart';
import 'date_picker_transaction_widget.dart';
import 'package:track_it/service/extension/string_extension.dart';
import 'text_field/text_field_transaction_widget.dart';

class TransactionSell extends StatelessWidget {
  const TransactionSell({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionSellModel>(
      builder: (context, model, child) {
        return TransactionGeneralWidget(
          children: [
            const SizedBox(height: 24),
            TextFieldTransaction(
              textInputType: TextInputType.number,
              labelText: 'Количество',
              onChanged: (value) {
                if (value.isNotEmpty) {
                  model.setAmount(double.parse(value));
                }
              },
              initialValue: model.amount == 0.0? '': model.amount.toString(),
            ),
            const SizedBox(height: 24),
            TextFieldTransaction(
              labelText: 'Цена',
              onChanged: (value) {
                if (value.isNotEmpty) {
                  model.setPrice(double.parse(value));
                }
              },
              initialValue: model.price == 0.0? '': model.price.toString(),
            ),
            const SizedBox(height: 24),
            DatePickerTransaction(
              initialDate: model.dateTime,
              onSaved: (value) => model.setDateTime(value?.toDateTime() ?? model.dateTime),
            ),
            const SizedBox(height: 24),
            TextFieldTransactionNote(
              initialValue: model.note,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  model.setNote(value);
                }
              },
            )
          ]
        );
      },
    );
  }
}