import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';

final deviceBottomSafeArea =
    MediaQueryData.fromWindow(ui.window).padding.bottom;
final deviceTopSafeArea = MediaQueryData.fromWindow(ui.window).padding.top;
final deviceWidth = MediaQueryData.fromWindow(ui.window).size.width;
final deviceHeight = MediaQueryData.fromWindow(ui.window).size.height;
