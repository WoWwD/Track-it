extension StringExtension on String {
  String toValidForSearch() => replaceAll(' ', '').trimLeft().toLowerCase();
  bool isNumber() => contains(RegExp(r'[0-9]'));
  bool isMaxLength() => length > 10;
  bool isMinLength() => length < 1;
}