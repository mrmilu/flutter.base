import 'package:flutter/cupertino.dart';

extension ScreenWidthPercentage on MediaQueryData {
  widthPercentage(double percentage) {
    return size.width * (percentage / 100);
  }
}

extension ScreenHeightPercentage on MediaQueryData {
  heightPercentage(double percentage) {
    return size.height * (percentage / 100);
  }
}