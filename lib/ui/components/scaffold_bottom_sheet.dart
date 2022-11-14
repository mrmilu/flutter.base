import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/spacing.dart';

import 'package:flutter_base/ui/utils/media_query.dart';

class ScaffoldBottomSheet extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const ScaffoldBottomSheet({
    super.key,
    required this.child,
    this.backgroundColor = MoggieColors.specificBackgroundBase,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        color: backgroundColor,
        child: Padding(
          padding: EdgeInsets.only(
            top: Spacing.sp16,
            left: Spacing.sp16,
            bottom: deviceBottomSafeArea + Spacing.sp16,
            right: Spacing.sp16,
          ),
          child: child,
        ),
      ),
    );
  }
}
