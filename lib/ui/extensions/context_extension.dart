import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/view_models/screen_size.dart';

extension ContextExtension on BuildContext {
  ScreenSize get screenSize {
    final double deviceWidth = MediaQuery.of(this).size.shortestSide;
    if (deviceWidth > 900) return ScreenSize.extraLarge;
    if (deviceWidth > 600) return ScreenSize.large;
    if (deviceWidth > 300) return ScreenSize.normal;
    return ScreenSize.small;
  }

  bool get isLargeOrBigger =>
      screenSize == ScreenSize.large || screenSize == ScreenSize.extraLarge;
}
