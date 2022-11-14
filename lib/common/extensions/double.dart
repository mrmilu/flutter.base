import 'dart:math';

extension Ex on double {
  double toPrecision(int places) {
    num mod = pow(10.0, places);
    return ((this * mod).round().toDouble() / mod);
  }
}