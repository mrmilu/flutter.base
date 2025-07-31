import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

const transparentBottomSheetTheme = BottomSheetThemeData(
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
);

final lightColorScheme = const ColorScheme.light(
  brightness: Brightness.light,
  primary: AppColors.primary,
  onPrimary: AppColors.specificBasicWhite,
  secondary: AppColors.secondary,
  onSecondary: AppColors.specificBasicWhite,
  onError: AppColors.specificBasicWhite,
  surface: AppColors.specificBasicWhite,
  onSurface: AppColors.specificContentHigh,
);

final appThemeDataLight = ThemeData(
  colorScheme: lightColorScheme, // Add color scheme for light theme
  dividerColor: AppColors.specificBorderLow,
  splashFactory: NoSplash.splashFactory,
  highlightColor: const Color(0xffF9ECE1),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.specificBasicWhite,
    toolbarHeight: 56,
    surfaceTintColor: Colors.transparent,
    foregroundColor: AppColors.specificContentHigh,
  ),
  scaffoldBackgroundColor: AppColors.specificBasicWhite,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: Color(0xffFFFFFF),
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
  ),
  textTheme: appTextStyles,
  inputDecorationTheme: const InputDecorationTheme(),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(AppColors.specificContentHigh),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      textStyle: WidgetStateProperty.all(AppTextStyles.title4),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(AppColors.primary),
      foregroundColor: WidgetStateProperty.all(AppColors.specificContentHigh),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      textStyle: WidgetStateProperty.all(AppTextStyles.title4),
    ),
  ),
);

final darkColorScheme = const ColorScheme.dark(
  brightness: Brightness.dark,
  primary: AppColors.primary,
  onPrimary:
      AppColors.specificBasicWhite, // Changed to white for better contrast
  secondary: AppColors.secondary,
  onSecondary: AppColors.specificBasicWhite, // Changed to white
  onError: AppColors.specificBasicWhite, // Changed to white
  surface:
      AppColors.specificBasicSemiBlack, // Surface should be dark in dark mode
  onSurface: AppColors.specificBasicWhite, // Text on background should be white
);

final appThemeDataDark = ThemeData(
  colorScheme: darkColorScheme, // Use the dark color scheme
  dividerColor: AppColors.specificBorderLow,
  splashFactory: NoSplash.splashFactory,
  highlightColor: const Color(0xffF9ECE1),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.specificBasicSemiBlack,
    toolbarHeight: 56,
    surfaceTintColor: Colors.transparent,
    foregroundColor: AppColors.specificBasicWhite, // Changed to white
    iconTheme: IconThemeData(
      color: AppColors.specificBasicWhite, // Explicit icon color for AppBar
    ),
  ),
  scaffoldBackgroundColor: AppColors.specificBasicSemiBlack,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor:
        AppColors.specificBasicSemiBlack, // Dark background for dark mode
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
  ),
  textTheme: appTextStyles,
  inputDecorationTheme: const InputDecorationTheme(),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: WidgetStateProperty.all(Colors.transparent),
      foregroundColor: WidgetStateProperty.all(AppColors.specificBasicWhite),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      textStyle: WidgetStateProperty.all(AppTextStyles.title4),
    ),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: WidgetStateProperty.all(0),
      backgroundColor: WidgetStateProperty.all(AppColors.primary),
      foregroundColor: WidgetStateProperty.all(AppColors.specificBasicWhite),
      padding: WidgetStateProperty.all(
        const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      ),
      shape: WidgetStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(100),
        ),
      ),
      textStyle: WidgetStateProperty.all(AppTextStyles.title4),
    ),
  ),
  iconTheme: const IconThemeData(
    color: AppColors.specificBasicWhite,
  ),
  primaryIconTheme: const IconThemeData(
    color: AppColors.specificBasicWhite,
  ),
);
