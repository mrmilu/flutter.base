import 'package:flutter/material.dart';

import '../colors/colors_base.dart';
import '../texts/app_text_styles.dart';

const transparentBottomSheetTheme = BottomSheetThemeData(
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
);

final darkColorScheme = ColorScheme.dark(
  brightness: Brightness.dark,
  primary: AppColors.dark.primary,
  onPrimary: AppColors.dark.specificBasicWhite,
  secondary: AppColors.dark.secondary,
  onSecondary: AppColors.dark.specificBasicWhite,
  onError: AppColors.dark.specificBasicWhite,
  surface: AppColors.dark.specificBasicSemiBlack,
  onSurface: AppColors.dark.specificBasicWhite,
);

final appThemeDataDark = ThemeData(
  colorScheme: darkColorScheme,
  textTheme: appTextStylesDark,
  dividerColor: AppColors.dark.specificBorderLow,
  splashFactory: NoSplash.splashFactory,
  highlightColor: const Color(0xffF9ECE1),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.dark.background,
    toolbarHeight: 56,
    surfaceTintColor: Colors.transparent,
    foregroundColor: AppColors.dark.specificBasicWhite,
    iconTheme: IconThemeData(
      color: AppColors.dark.specificBasicWhite,
    ),
  ),
  scaffoldBackgroundColor: AppColors.dark.background,
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: AppColors.dark.background,
    surfaceTintColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
  ),

  inputDecorationTheme: const InputDecorationTheme(),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(
        AppColors.dark.specificBasicWhite,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      textStyle: WidgetStateProperty.all(appTextStylesDark.headlineSmall),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(AppColors.dark.primary),
      foregroundColor: WidgetStateProperty.all(
        AppColors.dark.specificBasicWhite,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      textStyle: WidgetStateProperty.all(appTextStylesDark.headlineSmall),
    ),
  ),
  iconTheme: IconThemeData(
    color: AppColors.dark.specificBasicWhite,
  ),
  primaryIconTheme: IconThemeData(
    color: AppColors.dark.specificBasicWhite,
  ),
);
