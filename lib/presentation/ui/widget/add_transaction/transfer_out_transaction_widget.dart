import 'package:flutter/material.dart';
import 'package:track_it/presentation/ui/widget/text_field_transaction_widget.dart';

class TransferOutTransaction extends StatelessWidget {
  const TransferOutTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Поиск'),
        TextFieldTransaction(),
        const Text('Примечание'),
      ],
    );
  }
}
