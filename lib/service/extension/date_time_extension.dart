import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String dateTimeToString() => DateFormat('dd.MM.yyyy - HH:mm').format(this);
}