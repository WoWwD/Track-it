extension DateTimeExtension on DateTime {
  String dateTimeToString() {
    final DateTime parse = DateTime.parse(toString());
    return '${parse.day}.${parse.month}.${parse.year} ${parse.hour}:${parse.minute}';
  }
}