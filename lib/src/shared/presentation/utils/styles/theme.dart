import 'package:flutter/material.dart';

import 'colors.dart';
import 'text_styles.dart';

const transparentBottomSheetTheme = BottomSheetThemeData(
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
);

final appThemeData = ThemeData(
  dividerColor: AppColors.specificBorderLow,
  splashFactory: NoSplash.splashFactory,
  highlightColor: AppColors.specificSurfaceMid,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: AppColors.specificBasicWhite,
    toolbarHeight: 56,
    surfaceTintColor: Colors.transparent,
    foregroundColor: AppColors.specificContentHigh,
  ),
  scaffoldBackgroundColor: AppColors.specificBasicWhite,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: AppColors.specificSurfaceLow,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(24),
      ),
    ),
  ),
  textTheme: const TextTheme().apply(
    bodyColor: AppColors.specificContentHigh,
    displayColor: AppColors.specificContentHigh,
  ),
  inputDecorationTheme: const InputDecorationTheme(
    // hintStyle: TextStyles.body2.copyWith(color: AppColors.specificContentLow),
    // floatingLabelStyle: TextStyles.caption1,
    // helperStyle:
    //     TextStyles.caption1.copyWith(color: AppColors.specificContentLow),
    // errorStyle:
    //     TextStyles.caption1.copyWith(color: AppColors.specificSemanticDanger),
    // contentPadding: const EdgeInsets.symmetric(vertical: 12),
    // enabledBorder: const UnderlineInputBorder(
    //   borderSide: BorderSide(color: AppColors.specificBorderLow),
    // ),
    // disabledBorder: UnderlineInputBorder(
    //   borderSide: BorderSide(
    //     color: AppColors.specificBorderLow.withAlpha((0.25 * 255).toInt()),
    //   ),
    // ),
    // errorBorder: const UnderlineInputBorder(
    //   borderSide: BorderSide(color: AppColors.specificSemanticDanger),
    // ),
    // focusedBorder: const UnderlineInputBorder(
    //   borderSide: BorderSide(color: AppColors.specificSemanticPrimary),
    // ),
  ),
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
      textStyle: WidgetStateProperty.all(TextStyles.title4),
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
      textStyle: WidgetStateProperty.all(TextStyles.title4),
    ),
  ),
);
