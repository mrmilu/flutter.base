import 'dart:ui' show window;

import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/spacing.dart';

extension ScreenWidthPercentage on MediaQueryData {
  double widthPercentage(double percentage) {
    return size.width * (percentage / 100);
  }
}

extension ScreenHeightPercentage on MediaQueryData {
  double heightPercentage(double percentage) {
    return size.height * (percentage / 100);
  }
}

extension Sizes on MediaQueryData {
  double get deviceBottomSafeArea =>
      MediaQueryData.fromWindow(window).padding.bottom;
  double get deviceTopSafeArea => MediaQueryData.fromWindow(window).padding.top;
  double get deviceWidth => MediaQueryData.fromWindow(window).size.width;
  double get deviceHeight => MediaQueryData.fromWindow(window).size.height;
}

extension MediaQueryPaddings on MediaQueryData {
  EdgeInsets get textFieldScrollPadding =>
      EdgeInsets.all(viewInsets.bottom + Spacing.sp20);
  EdgeInsets get bottomSafeAreaPadding =>
      EdgeInsets.only(bottom: deviceBottomSafeArea);
}
