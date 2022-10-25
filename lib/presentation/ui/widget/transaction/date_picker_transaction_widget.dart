import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:track_it/service/extension/date_time_extension.dart';

class DatePickerTransaction extends StatelessWidget {
  final DateTime initialDate;
  final FormFieldSetter<String>? onSaved;

  const DatePickerTransaction({
    Key? key,
    required this.initialDate,
    required this.onSaved
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DateTimePicker(
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: 'Дата'
      ),
      type: DateTimePickerType.dateTime,
      dateMask: 'dd.MM.yyyy - HH:mm',
      initialValue: initialDate.dateTimeToString(),
      firstDate: DateTime(2008, 08, 01),
      lastDate: initialDate,
      onChanged: onSaved,
    );
  }
}