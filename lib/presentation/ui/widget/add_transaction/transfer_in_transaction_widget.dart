import 'package:flutter/material.dart';

import '../text_field_transaction_widget.dart';

class TransferInTransaction extends StatelessWidget {
  const TransferInTransaction({Key? key}) : super(key: key);

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
