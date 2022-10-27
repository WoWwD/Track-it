import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:track_it/presentation/ui/widget/transaction/transaction_general_widget.dart';
import '../../../provider/transaction_provider/transaction_sell_model.dart';
import '../text_field/text_field_transaction_note_widget.dart';
import '../text_field/text_field_transaction_widget.dart';
import 'date_picker_transaction_widget.dart';
import 'package:track_it/service/extension/string_extension.dart';

class TransactionSell extends StatefulWidget {
  const TransactionSell({Key? key}) : super(key: key);

  @override
  State<TransactionSell> createState() => _TransactionSellState();
}

class _TransactionSellState extends State<TransactionSell> {
  @override
  Widget build(BuildContext context) {
    return Consumer<TransactionSellModel>(
      builder: (context, model, child) {
        final TextEditingController textEditingController
          = TextEditingController(text: model.price * model.amount == 0.0? '': '\$${(model.price * model.amount)}');

        return TransactionGeneralWidget(
          textFieldAmount: TextFieldTransaction(
            textInputType: TextInputType.number,
            labelText: 'Количество',
            onChanged: (value) {
              if (value.isNotEmpty) {
                model.setAmount(double.parse(value));
              }
            },
            initialValue: model.amount == 0.0? '': model.amount.toString(),
          ),
          textFieldPrice: TextFieldTransaction(
            labelText: 'Цена',
            onChanged: (value) {
              if (value.isNotEmpty) {
                model.setPrice(double.parse(value));
              }
            },
            initialValue: model.price == 0.0? '': model.price.toString(),
          ),
          textFieldCost: TextFieldTransaction(
            readOnly: true,
            textInputType: TextInputType.number,
            labelText: 'Общая стоимость',
            controller: textEditingController,
          ),
          textFieldDatePicker: DatePickerTransaction(
            initialDate: model.dateTime,
            onSaved: (value) => model.setDateTime(value?.toDateTime() ?? model.dateTime),
          ),
          textFieldNote: TextFieldTransactionNote(
            initialValue: model.note,
            onChanged: (value) {
              if (value.isNotEmpty) {
                model.setNote(value);
              }
            },
          )
        );
      },
    );
  }

  void setCost(TextEditingController tec, TransactionSellModel model) {
    setState(() {
      if(model.price * model.amount == 0.0) {
        tec.text = '';
      }
      else {
        model.setCost(model.price * model.amount);
        tec.text = '\$${(model.price * model.amount)}';
      }
    });
  }
}