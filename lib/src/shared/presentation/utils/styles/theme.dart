import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/text_styles.dart';

const transparentBottomSheetTheme = BottomSheetThemeData(
  backgroundColor: Colors.transparent,
  surfaceTintColor: Colors.transparent,
);

final appThemeData = ThemeData(
  dividerColor: FlutterBaseColors.specificBorderLow,
  splashFactory: NoSplash.splashFactory,
  highlightColor: FlutterBaseColors.specificSurfaceMid,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: FlutterBaseColors.specificBackgroundBase,
    toolbarHeight: 56,
    surfaceTintColor: Colors.transparent,
    foregroundColor: FlutterBaseColors.specificContentHigh,
  ),
  scaffoldBackgroundColor: FlutterBaseColors.specificBackgroundBase,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: FlutterBaseColors.specificSurfaceLow,
    surfaceTintColor: Colors.transparent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.horizontal(
        right: Radius.circular(32),
        left: Radius.circular(32),
      ),
    ),
  ),
  textTheme: const TextTheme().apply(
    bodyColor: FlutterBaseColors.specificContentHigh,
    displayColor: FlutterBaseColors.specificContentHigh,
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle:
        TextStyles.smallM.copyWith(color: FlutterBaseColors.specificContentLow),
    floatingLabelStyle: TextStyles.smallS,
    helperStyle:
        TextStyles.smallS.copyWith(color: FlutterBaseColors.specificContentLow),
    errorStyle: TextStyles.smallS
        .copyWith(color: FlutterBaseColors.specificSemanticDanger),
    contentPadding: Insets.v12,
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: FlutterBaseColors.specificBorderLow),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: FlutterBaseColors.specificBorderLow.withOpacity(0.25),
      ),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: FlutterBaseColors.specificSemanticDanger),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: FlutterBaseColors.specificSemanticPrimary),
    ),
  ),
);
