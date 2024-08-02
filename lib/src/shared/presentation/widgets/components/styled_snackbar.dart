import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/border_radius.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:get_it/get_it.dart';

enum SnackBarStyle { info, warning, error }

class StyledSnackBar {
  static SnackBar styledSnackBar(
    BuildContext context,
    String message, {
    SnackBarStyle style = SnackBarStyle.info,
  }) {
    late Color bgColor;
    late Color labelColor;

    switch (style) {
      case SnackBarStyle.info:
        bgColor = FlutterBaseColors.specificSemanticPrimary;
        labelColor = FlutterBaseColors.specificBasicWhite;
        break;
      case SnackBarStyle.warning:
        bgColor = FlutterBaseColors.specificSemanticWarning;
        labelColor = FlutterBaseColors.specificBasicWhite;
        break;
      case SnackBarStyle.error:
        bgColor = FlutterBaseColors.specificSemanticDanger;
        labelColor = FlutterBaseColors.specificBasicWhite;
        break;
      default:
        bgColor = FlutterBaseColors.specificSemanticPrimary;
        labelColor = FlutterBaseColors.specificBasicWhite;
    }

    return SnackBar(
      margin: Insets.h24 + Insets.ob48,
      behavior: SnackBarBehavior.floating,
      backgroundColor: bgColor,
      shape: RoundedRectangleBorder(borderRadius: CircularBorderRadius.br24),
      content: Text(
        message,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: labelColor,
              fontWeight: FontWeight.bold,
            ),
      ),
      action: SnackBarAction(
        label: 'Dismiss',
        disabledTextColor: Colors.white,
        textColor: labelColor,
        onPressed: () {
          GetIt.I
              .get<GlobalKey<ScaffoldMessengerState>>()
              .currentState
              ?.hideCurrentSnackBar();
        },
      ),
    );
  }
}
