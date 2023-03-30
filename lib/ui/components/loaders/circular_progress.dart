import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mrmilu/flutter_mrmilu.dart';

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
    ThemeData themeData = ThemeData(
      cupertinoOverrideTheme: CupertinoThemeData(
        brightness: cupertinoBrightness ?? Theme.of(context).brightness,
      ),
    );
    themeData = themeData.copyWith(
      colorScheme: themeData.colorScheme.copyWith(secondary: _indicatorColor),
    );

    return Theme(
      data: themeData,
      child: _getPlatformIndicator,
    );
  }

  Widget get _getPlatformIndicator {
    if (PlatformUtils.isIOS) {
      return CupertinoActivityIndicator(radius: radius);
    } else {
      if (!androidProgressInsideStack) {
        return SizedBox.square(
          dimension: radius * 2,
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
          )
        ],
      );
    }
  }
}
