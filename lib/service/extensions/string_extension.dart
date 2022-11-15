extension StringExtension on String {
  String noSpace() => replaceAll(' ', '').trimLeft().toLowerCase();
  bool isMaxLength() => length > 10;
  bool isMaxLengthText() => length > 100;
  bool isMinLength() => length < 3;
  DateTime toDateTime() => DateTime.parse(this);
}