import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/text_field_transaction_widget.dart';

class BuyTransaction extends StatelessWidget {
  const BuyTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Text('Поиск'),
        TextFieldTransaction(labelText: 'Количество'),
        TextFieldTransaction(labelText: 'Цена'),
        Text('Примечание'),
      ],
    );
  }
}
