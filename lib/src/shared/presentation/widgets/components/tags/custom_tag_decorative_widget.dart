import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../text/text_body.dart';

class CustomTagDecorativeWidget extends StatelessWidget {
  const CustomTagDecorativeWidget({super.key, required this.label});
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: const BoxDecoration(
            color: AppColors.primaryAzulSuave,
            shape: BoxShape.circle,
          ),
          alignment: Alignment.center,
          child: Container(
            height: 8,
            width: 8,
            decoration: const BoxDecoration(
              color: AppColors.tertiary,
              shape: BoxShape.circle,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Flexible(
          child: TextBody.two(
            label,
            color: AppColors.tertiary,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
