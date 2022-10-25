extension DoubleExtension on double {
  String noZero() => toString().replaceAll(RegExp(r'([.]*0)(?!.*\d)'), '');
}