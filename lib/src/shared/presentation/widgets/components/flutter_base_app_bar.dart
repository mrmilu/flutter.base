import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/icon_button_tertiary.dart';
import 'package:go_router/go_router.dart';

class FlutterBaseAppBar extends AppBar {
  FlutterBaseAppBar({
    super.key,
    super.automaticallyImplyLeading = false,
    super.leadingWidth = 40,
    super.backgroundColor,
    super.title,
    Widget? leading,
    bool showLeading = true,
    String customPopRoute = '',
    VoidCallback? customPopAction,
    Widget? trailing,
  }) : super(
          leading: showLeading
              ? leading ??
                  FlutterBaseAppBarLeading(
                    customPopRoute: customPopRoute,
                    customPopAction: customPopAction,
                  )
              : null,
          actions: [
            if (trailing != null)
              Padding(
                padding: Insets.or16,
                child: trailing,
              ),
          ],
        );

  factory FlutterBaseAppBar.dialog({String? customPopRoute}) {
    return FlutterBaseAppBar(
      showLeading: false,
      trailing: Builder(
        builder: (context) {
          return Transform.translate(
            offset: const Offset(8, 0),
            child: IconButtonTertiary(
              icon: Icons.close,
              foregroundColor: FlutterBaseColors.specificContentLow,
              fixedSize: const Size.fromWidth(24),
              onPressed: () {
                if (Navigator.of(context).canPop()) {
                  Navigator.of(context).pop();
                } else if (customPopRoute != null) {
                  GoRouter.of(context).go(customPopRoute);
                }
              },
            ),
          );
        },
      ),
    );
  }
}

class FlutterBaseAppBarLeading extends StatelessWidget {
  final String customPopRoute;
  final VoidCallback? customPopAction;

  const FlutterBaseAppBarLeading({
    super.key,
    this.customPopRoute = '',
    this.customPopAction,
  });

  @override
  Widget build(BuildContext context) {
    if (!GoRouter.of(context).canPop() &&
        customPopRoute.isEmpty &&
        customPopAction == null) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: Insets.ol16,
      child: IconButtonTertiary(
        icon: Icons.arrow_back_ios,
        foregroundColor: FlutterBaseColors.specificContentLow,
        onPressed: () {
          if (customPopAction != null) {
            customPopAction?.call();
          } else if (customPopRoute.isNotEmpty) {
            GoRouter.of(context).go(customPopRoute);
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
