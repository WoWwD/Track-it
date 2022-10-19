import 'package:flutter/widgets.dart';
import 'package:track_it/presentation/ui/widget/transaction/text_field/text_field_transaction_widget.dart';
import 'package:track_it/service/extension/string_extension.dart';
import '../../../../../service/error/input_error.dart';

class TextFieldTransactionAmount extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String initialValue;

  const TextFieldTransactionAmount({
    Key? key,
    required this.onChanged,
    required this.initialValue
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldTransaction(
      textInputType: TextInputType.number,
      labelText: 'Количество',
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
