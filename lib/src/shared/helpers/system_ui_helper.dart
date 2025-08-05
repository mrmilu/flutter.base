import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../presentation/utils/styles/colors/colors_context.dart';

class SystemUIHelper {
  static void setLightStatusBar(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: context.colors.specificBasicWhite,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static void setDarkStatusBar(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: context.colors.specificBasicSemiBlack,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  static void setSystemUIForTheme(bool isDarkMode, BuildContext context) {
    if (isDarkMode) {
      setDarkStatusBar(context);
    } else {
      setLightStatusBar(context);
    }
  }
}
