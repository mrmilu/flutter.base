import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';

final mediaQueryFromView = ui.PlatformDispatcher.instance.implicitView != null
    ? MediaQueryData.fromView(ui.PlatformDispatcher.instance.implicitView!)
    : null;

final deviceBottomSafeArea = mediaQueryFromView?.padding.bottom ?? 0;
final deviceTopSafeArea = mediaQueryFromView?.padding.top ?? 0;
final deviceWidth = mediaQueryFromView?.size.width ?? 0;
final deviceHeight = mediaQueryFromView?.size.height ?? 0;

bool isSmallScreen(heightElement) {
  if ((deviceHeight / heightElement) < 2.5) {
    return true;
  }
  return false;
}
