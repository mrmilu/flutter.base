import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_base/ui/utils/media_query.dart';

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

extension MediaQueryPaddings on MediaQueryData {
  EdgeInsets get textFieldScrollPadding =>
      EdgeInsets.all(viewInsets.bottom + Spacing.sp20);
  EdgeInsets get bottomSafeAreaPadding =>
      EdgeInsets.only(bottom: deviceBottomSafeArea);
}
