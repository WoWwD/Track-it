extension DoubleExtension on double {
  String myRound([int fractionDigits = 4]) {
    String integerPart = toStringAsFixed(fractionDigits).split('.')[0];
    String fraction = toStringAsFixed(fractionDigits).split('.')[1];

    for (int i = fractionDigits - 1; i + 1 != 0; i--) {
      bool lastIsZero = fraction[i].contains('0');

      if (lastIsZero) {
        fraction = fraction.replaceRange(i, i + 1, '');
      }
      else {
        return '$integerPart.$fraction';
      }
    }
    return fraction != ''? '$integerPart.$fraction': integerPart;
  }
}