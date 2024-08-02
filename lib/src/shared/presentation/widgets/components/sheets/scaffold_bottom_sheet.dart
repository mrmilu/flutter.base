import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/shared/presentation/utils/extensions/media_query.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';

class ScaffoldBottomSheet extends StatelessWidget {
  final Widget child;
  final Color backgroundColor;

  const ScaffoldBottomSheet({
    super.key,
    required this.child,
    this.backgroundColor = FlutterBaseColors.specificBackgroundBase,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        width: double.infinity,
        color: backgroundColor,
        child: Padding(
          padding: MediaQuery.of(context).bottomSafeAreaPadding + Insets.a16,
          child: child,
        ),
      ),
    );
  }
}
