import 'package:flutter/material.dart';

import '../text_field_transaction_widget.dart';

class SellTransaction extends StatelessWidget {
  const SellTransaction({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Text('Поиск'),
        TextFieldTransaction(),
        TextFieldTransaction(),
        const Text('Примечание'),
      ],
    );
  }
}
