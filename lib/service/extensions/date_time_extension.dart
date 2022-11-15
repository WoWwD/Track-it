// ignore_for_file: depend_on_referenced_packages
import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String dateTimeFormatToString() => DateFormat('dd.MM.yyyy - HH:mm').format(this);
}