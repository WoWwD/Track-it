extension StringExtension on String {
  String toValidForSearch() => replaceAll(' ', '').trimLeft().toLowerCase();
}