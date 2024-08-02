import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';

class WithCustomColorBottomSheet extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const WithCustomColorBottomSheet({
    super.key,
    required this.child,
    this.backgroundColor = FlutterBaseColors.specificBackgroundBase,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        bottomSheetTheme: Theme.of(context).bottomSheetTheme.copyWith(
              backgroundColor: backgroundColor,
            ),
      ),
      child: child,
    );
  }
}
