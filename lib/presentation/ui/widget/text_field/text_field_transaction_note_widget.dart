import 'package:flutter/material.dart';
import 'package:track_it/service/extensions/string_extension.dart';
import '../../../../service/input_error.dart';

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
        labelText: 'Заметки',
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value!.noSpace().isMaxLengthText()){
          return InputError.maxLength;
        }
        return null;
      },
    );
  }
}