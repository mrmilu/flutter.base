import 'package:flutter/material.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/paddings.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';

const transparentBottomSheetTheme =
    BottomSheetThemeData(backgroundColor: Colors.transparent);

final appThemeData = ThemeData(
  dividerColor: FlutterBaseColors.specificBorderLow,
  splashFactory: NoSplash.splashFactory,
  highlightColor: FlutterBaseColors.specificSurfaceMid,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: FlutterBaseColors.specificBackgroundBase,
    toolbarHeight: 56,
    foregroundColor: FlutterBaseColors.specificContentHigh,
  ),
  scaffoldBackgroundColor: FlutterBaseColors.specificBackgroundBase,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: FlutterBaseColors.specificSurfaceLow,
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
    contentPadding: Paddings.v12,
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
