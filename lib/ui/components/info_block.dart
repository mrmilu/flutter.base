import 'package:flutter/widgets.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/spacing.dart';

class InfoBlock extends StatelessWidget {
  final Widget child;

  const InfoBlock({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: MoggieColors.specificBeige10,
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(Spacing.sp16),
        child: child,
      ),
    );
  }
}