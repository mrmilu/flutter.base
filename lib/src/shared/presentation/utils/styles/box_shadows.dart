import 'package:flutter/cupertino.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';

class BoxShadows {
  static final List<BoxShadow> bs1 = [
    BoxShadow(
      color: FlutterBaseColors.specificBasicBlack.withOpacity(0.12),
      blurRadius: 12,
      offset: const Offset(2, 2),
    ),
  ];
}
