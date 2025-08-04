import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../presentation/utils/styles/colors.dart';

class SystemUIHelper {
  static void setLightStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
        systemNavigationBarColor: AppColors.specificBasicWhite,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );
  }

  static void setDarkStatusBar() {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
        systemNavigationBarColor: AppColors.specificBasicSemiBlack,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  static void setSystemUIForTheme(bool isDarkMode) {
    if (isDarkMode) {
      setDarkStatusBar();
    } else {
      setLightStatusBar();
    }
  }
}
