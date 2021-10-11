class Utils {
  static double parseToDouble(dynamic value) {
    if (value is int) {
      return value.toDouble();
    }

    return value as double;
  }
}
