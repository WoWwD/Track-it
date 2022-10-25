import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryTextField extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  final String? initialValue;
  final TextInputType? textInputType;
  final FormFieldValidator<String>? validator;

  const PrimaryTextField({
    Key? key,
    this.labelText,
    this.onChanged,
    this.inputFormatters,
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
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText
      ),
      onChanged: onChanged
    );
  }
}
