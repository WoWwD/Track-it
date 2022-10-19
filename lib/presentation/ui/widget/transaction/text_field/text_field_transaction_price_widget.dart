import 'package:flutter/widgets.dart';
import 'text_field_transaction_widget.dart';

class TextFieldTransactionPrice extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String initialValue;

  const TextFieldTransactionPrice({
    Key? key,
    required this.onChanged,
    required this.initialValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldTransaction(
      textInputType: TextInputType.number,
      labelText: 'Цена',
      onChanged: onChanged,
      initialValue: initialValue,
    );
  }
}