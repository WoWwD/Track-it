import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextFieldTransaction extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final List<TextInputFormatter>? inputFormatters;
  const TextFieldTransaction({Key? key, this.labelText, this.onChanged, this.inputFormatters}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      inputFormatters: inputFormatters,
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText
      ),
      onChanged: onChanged
    );
  }
}
