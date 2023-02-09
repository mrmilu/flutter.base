import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/styles/colors.dart';

class BoxShadows {
  static List<BoxShadow> bs1 = [
    BoxShadow(
      color: FlutterBaseColors.specificBasicBlack.withOpacity(0.12),
      blurRadius: 20,
      offset: const Offset(2, 2),
    ),
  ];
}
