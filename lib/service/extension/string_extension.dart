extension StringExtension on String {
  String toValidForSearch() => replaceAll(' ', '').trimLeft().toLowerCase();
  bool isMaxLength() => length > 10;
  bool isMinLength() => length < 3;
  DateTime toDateTime() => DateTime.parse(this);
}