import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:track_it/service/error/input_error.dart';
import 'package:track_it/service/extension/string_extension.dart';

class TextFieldTransaction extends StatelessWidget {
  final ValueChanged<String>? onChanged;
  final String? labelText;
  final String? initialValue;
  final TextInputType? textInputType;
  final GestureTapCallback? onTap;
  final bool readOnly;
  final Widget? suffixIcon;
  final TextEditingController? controller;

  const TextFieldTransaction({
    Key? key,
    this.labelText,
    this.onChanged,
    this.initialValue,
    this.textInputType = TextInputType.number,
    this.onTap,
    this.readOnly = false,
    this.suffixIcon,
    this.controller
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      onTap: onTap,
      keyboardType: textInputType,
      initialValue: initialValue,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp('[0-9.]'))
      ],
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        labelText: labelText,
        suffixIcon: suffixIcon
      ),
      onChanged: onChanged,
      validator: (value) {
        if (value.toString().isEmpty) {
          return InputError.empty;
        }
        if (value.toString().isMaxLength()){
          return InputError.maxLength;
        }
        return null;
      },
    );
  }
}
