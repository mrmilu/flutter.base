import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CircularProgress extends StatelessWidget {
  final double radius;
  final bool androidProgressInsideStack;
  final Brightness? cupertinoBrightness;
  final Color _indicatorColor = Colors.black87;

  const CircularProgress({
    super.key,
    this.radius = 15,
    this.androidProgressInsideStack = true,
    this.cupertinoBrightness,
  });

  @override
  Widget build(BuildContext context) {
    var themeData = ThemeData(
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: cupertinoBrightness ?? Theme.of(context).brightness,
      ),
    );
    themeData = themeData.copyWith(
      colorScheme: themeData.colorScheme.copyWith(secondary: _indicatorColor),
    );

    return Theme(data: themeData, child: _getPlatformIndicator);
  }

  Widget get _getPlatformIndicator {
    if (Platform.isIOS) {
      return CupertinoActivityIndicator(radius: radius);
    } else {
      if (androidProgressInsideStack == false) {
        return SizedBox(
          height: radius * 2,
          width: radius * 2,
          child: Center(
            child: CircularProgressIndicator(color: _indicatorColor),
          ),
        );
      }
      return Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            height: radius * 2,
            width: radius * 2,
            child: Center(
              child: CircularProgressIndicator(color: _indicatorColor),
            ),
          ),
        ],
      );
    }
  }
}
