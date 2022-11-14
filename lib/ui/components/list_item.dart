import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/flutter_base_icon.dart';
import 'package:flutter_base/ui/components/text/small_text.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/spacing.dart';

class MoggieListItem extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback? onTap;

  const MoggieListItem({
    super.key,
    required this.text,
    this.icon,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.translucent,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: Spacing.sp16),
        child: Row(
          children: [
            if (icon != null) ...[
              FlutterBaseIcon(
                icon: icon!,
                color: MoggieColors.iconBlack,
              ),
              BoxSpacer.h8(),
            ],
            SmallTextM(text),
          ],
        ),
      ),
    );
  }
}
