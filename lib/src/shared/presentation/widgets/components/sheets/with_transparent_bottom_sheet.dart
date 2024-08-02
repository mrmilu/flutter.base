import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/theme.dart';

class WithTransparentBottomSheet extends StatelessWidget {
  final Widget child;

  const WithTransparentBottomSheet({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context)
          .copyWith(bottomSheetTheme: transparentBottomSheetTheme),
      child: child,
    );
  }
}
