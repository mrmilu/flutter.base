import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_base/ui/components/buttons/icon_button_tertiary.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/spacing.dart';

class FlutterBaseAppBar extends AppBar {
  FlutterBaseAppBar({
    super.key,
    super.automaticallyImplyLeading = false,
    super.leadingWidth = 40,
    super.backgroundColor,
    Widget? leading,
    bool showLeading = true,
    String? customPopRoute,
    VoidCallback? customPopAction,
    Widget? trailing,
  }) : super(
          leading: showLeading
              ? leading ??
                  MoggieAppBarLeading(
                      customPopRoute: customPopRoute,
                      customPopAction: customPopAction)
              : null,
          actions: [
            if (trailing != null)
              Padding(
                padding: const EdgeInsets.only(right: Spacing.sp16),
                child: trailing,
              )
          ],
        );

  factory FlutterBaseAppBar.dialog({String? customPopRoute}) {
    return FlutterBaseAppBar(
      showLeading: false,
      trailing: Builder(builder: (context) {
        return Transform.translate(
          offset: const Offset(8, 0),
          child: IconButtonTertiary(
            icon: Icons.close,
            foregroundColor: MoggieColors.specificContentLow,
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
      }),
    );
  }
}

class MoggieAppBarLeading extends StatelessWidget {
  final String? customPopRoute;
  final VoidCallback? customPopAction;

  const MoggieAppBarLeading({
    super.key,
    this.customPopRoute,
    this.customPopAction,
  });

  @override
  Widget build(BuildContext context) {
    if (!GoRouter.of(context).canPop() &&
        customPopRoute == null &&
        customPopAction == null) {
      return Container();
    }
    return Padding(
      padding: const EdgeInsets.only(left: Spacing.sp16),
      child: IconButtonTertiary(
        icon: Icons.arrow_back_ios,
        foregroundColor: MoggieColors.specificContentLow,
        onPressed: () {
          if (customPopAction != null) {
            customPopAction!();
          } else if (customPopRoute != null) {
            GoRouter.of(context).go(customPopRoute!);
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
