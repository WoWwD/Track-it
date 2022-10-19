import 'package:flutter/widgets.dart';
import 'package:track_it/service/error/input_error.dart';
import 'package:track_it/service/extension/string_extension.dart';
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
      validator: (value) {
        if (!value.toString().isNumber()){
          return InputError.invalidFormat;
        }
        if (!value.toString().isMaxLength()){
          return InputError.maxLength;
        }
        if (!value.toString().isMinLength()){
          return InputError.minLength;
        }
        return null;
      },
    );
  }
}