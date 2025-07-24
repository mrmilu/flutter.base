import 'package:flutter/material.dart';

extension ColorX on Color {
  Color wOpacity(double opacity) {
    return withAlpha((opacity * 255).toInt());
  }

  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = false, bool withAlpha = false}) =>
      '${leadingHashSign ? '#' : ''}'
      '${withAlpha ? a.toInt().toRadixString(16).padLeft(2, '0') : ''}'
      '${r.toInt().toRadixString(16).padLeft(2, '0')}'
      '${g.toInt().toRadixString(16).padLeft(2, '0')}'
      '${b.toInt().toRadixString(16).padLeft(2, '0')}';

  Color darken([int percent = 10]) {
    assert(
      1 <= percent && percent <= 100,
      'Amount should be greater than 1 and lower than 100',
    );
    var f = 1 - percent / 100;
    return Color.fromARGB(
      a.toInt(),
      (r.toInt() * f).round(),
      (g.toInt() * f).round(),
      (b.toInt() * f).round(),
    );
  }
}
