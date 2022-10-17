import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/text_field_transaction_widget.dart';

class BuyTransaction extends StatelessWidget {
  const BuyTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 24),
        TextFieldTransaction(labelText: 'Количество'),
        SizedBox(height: 24),
        TextFieldTransaction(labelText: 'Цена'),
        SizedBox(height: 24),
        TextFieldTransaction(labelText: 'Дата'),
        SizedBox(height: 24),
        Text('Примечание'),
      ],
    );
  }
}
