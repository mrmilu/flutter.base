import 'package:flutter/cupertino.dart';

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
