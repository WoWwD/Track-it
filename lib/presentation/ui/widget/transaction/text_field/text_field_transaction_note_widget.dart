import 'package:flutter/material.dart';
import 'package:track_it/service/extension/string_extension.dart';
import '../../../../../service/error/input_error.dart';

class TextFieldTransactionNote extends StatelessWidget {
  final String initialValue;
  final ValueChanged<String>? onChanged;

  const TextFieldTransactionNote({
    Key? key,
    required this.initialValue,
    required this.onChanged
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: TextInputType.multiline,
      initialValue: initialValue,
      maxLines: 3,
      maxLength: 100,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Примечание (не обязательно)',
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.isEmpty || value.noSpace().isEmpty) {
          return InputError.empty;
        }
        if (value.noSpace().isMaxLengthText()){
          return InputError.maxLength;
        }
        return null;
      },
    );
  }
}
