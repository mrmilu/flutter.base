import 'package:flutter/material.dart';

import '../components/text/rm_text.dart';

class PointWithTextWidget extends StatelessWidget {
  const PointWithTextWidget({
    super.key,
    required this.title,
    this.child,
    this.pointSize = 6,
  });
  final String title;
  final Widget? child;
  final double? pointSize;

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isDark = brightness == Brightness.dark;
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: pointSize,
          width: pointSize,
          margin: const EdgeInsets.only(top: 8),
          decoration: BoxDecoration(
            color: isDark ? Colors.white : Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child:
              child ??
              RMText.bodyMedium(
                title,
                height: 1.5,
              ),
        ),
      ],
    );
  }

  factory PointWithTextWidget.especial({required Widget child}) {
    return PointWithTextWidget(
      title: '',
      child: child,
    );
  }
}
