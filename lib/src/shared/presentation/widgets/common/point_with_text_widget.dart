import 'package:flutter/material.dart';

import '../text/text_body.dart';

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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: pointSize,
          width: pointSize,
          margin: const EdgeInsets.only(top: 8),
          decoration: const BoxDecoration(
            color: Colors.black,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child:
              child ??
              TextBody.two(
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
