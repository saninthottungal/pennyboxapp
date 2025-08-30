extension DoubleExtension on double {
  String removeZeroDecimal() {
    return this % 1 == 0 ? toStringAsFixed(0) : toString();
  }
}
