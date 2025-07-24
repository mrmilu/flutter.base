import 'package:flutter/material.dart';

import '../../utils/styles/colors.dart';
import '../text/text_body.dart';

class CustomSelectSimpleBorderWidget extends StatelessWidget {
  const CustomSelectSimpleBorderWidget({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
    this.isDisabled = false,
  });
  final String title;
  final bool isSelected;
  final VoidCallback onTap;
  final bool isDisabled;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: isDisabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(80),
          border: Border.all(
            width: 1,
            color: isSelected
                ? AppColors.specificBasicBlack
                : AppColors.specificBasicGrey,
          ),
        ),
        child: TextBody.two(title),
      ),
    );
  }
}
