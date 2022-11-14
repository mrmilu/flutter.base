import 'package:flutter/material.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_base/ui/styles/text_style.dart';

const transparentBottomSheetTheme =
    BottomSheetThemeData(backgroundColor: Colors.transparent);

final moggieThemeData = ThemeData(
  dividerColor: MoggieColors.specificBorderLow,
  splashFactory: NoSplash.splashFactory,
  highlightColor: MoggieColors.specificSurfaceMid,
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: MoggieColors.specificBackgroundBase,
    toolbarHeight: 56,
    foregroundColor: MoggieColors.specificContentHigh,
  ),
  scaffoldBackgroundColor: MoggieColors.specificBackgroundBase,
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: MoggieColors.specificSurfaceLow,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(32),
        topLeft: Radius.circular(32),
      ),
    ),
  ),
  textTheme: const TextTheme().apply(
      bodyColor: MoggieColors.specificContentHigh,
      displayColor: MoggieColors.specificContentHigh),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: MoggieTextStyles.smallM
        .copyWith(color: MoggieColors.specificContentLow),
    floatingLabelStyle: MoggieTextStyles.smallS,
    helperStyle: MoggieTextStyles.smallS
        .copyWith(color: MoggieColors.specificContentLow),
    errorStyle: MoggieTextStyles.smallS
        .copyWith(color: MoggieColors.specificSemanticDanger),
    contentPadding: const EdgeInsets.symmetric(vertical: Spacing.sp12),
    enabledBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: MoggieColors.specificBorderLow),
    ),
    disabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(
        color: MoggieColors.specificBorderLow.withOpacity(0.25),
      ),
    ),
    errorBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: MoggieColors.specificSemanticDanger),
    ),
    focusedBorder: const UnderlineInputBorder(
      borderSide: BorderSide(color: MoggieColors.specificSemanticPrimary),
    ),
  ),
);
