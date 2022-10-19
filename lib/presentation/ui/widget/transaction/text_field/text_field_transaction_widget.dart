import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldTransaction extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? initialValue;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validator;

  const TextFieldTransaction({
    Key? key,
    this.labelText,
    this.onChanged,
    this.initialValue,
    this.textInputType,
    this.validator
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      keyboardType: textInputType,
      initialValue: initialValue,
      inputFormatters: [
        FilteringTextInputFormatter.deny(RegExp(r'[,]'))
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText
      ),
      onChanged: onChanged
    );
  }
}
