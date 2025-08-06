import 'package:flutter/material.dart';

import '../colors/colors_base.dart';
import '../texts/text_styles_light.dart';

const transparentBottomSheetTheme = BottomSheetThemeData(
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
);

final lightColorScheme = ColorScheme.light(
  brightness: Brightness.light,
  primary: AppColors.light.primary,
  onPrimary: AppColors.light.specificBasicWhite,
  secondary: AppColors.light.secondary,
  onSecondary: AppColors.light.specificBasicWhite,
  onError: AppColors.light.specificBasicWhite,
  surface: AppColors.light.specificBasicWhite,
  onSurface: AppColors.light.specificContentHigh,
);

final appThemeDataLight = ThemeData(
  colorScheme: lightColorScheme,
  textTheme: appTextStylesLight,
  dividerColor: AppColors.light.specificBorderLow,
  splashFactory: NoSplash.splashFactory,
  highlightColor: const Color(0xffF9ECE1),
  appBarTheme: AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.light.specificBasicWhite,
    toolbarHeight: 56,
    surfaceTintColor: Colors.transparent,
    foregroundColor: AppColors.light.specificContentHigh,
  ),
  scaffoldBackgroundColor: AppColors.light.specificBasicWhite,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xffFFFFFF),
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
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
        AppColors.light.specificContentHigh,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      textStyle: WidgetStateProperty.all(appTextStylesLight.titleSmall),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(AppColors.light.primary),
      foregroundColor: WidgetStateProperty.all(
        AppColors.light.specificContentHigh,
      ),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      textStyle: WidgetStateProperty.all(appTextStylesLight.titleSmall),
    ),
  ),
);
