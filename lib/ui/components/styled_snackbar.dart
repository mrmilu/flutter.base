import 'package:flutter/material.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:get_it/get_it.dart';

enum SnackBarStyle { info, warning, error }

SnackBar styledSnackBar(
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
    margin: const EdgeInsets.only(
      left: 30,
      right: 30,
      bottom: 45,
    ),
    behavior: SnackBarBehavior.floating,
    backgroundColor: bgColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
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
