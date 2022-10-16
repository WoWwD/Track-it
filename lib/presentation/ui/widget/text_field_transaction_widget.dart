import 'package:flutter/material.dart';

class TextFieldTransaction extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? labelText;

  const TextFieldTransaction({Key? key, this.labelText, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText
      ),
      onChanged: onChanged
    );
  }
}
