import 'package:flutter/material.dart';

import '../../../utils/styles/colors.dart';
import '../../text/text_body.dart';

class CustomTagWidget extends StatelessWidget {
  const CustomTagWidget({
    super.key,
    required this.label,
    this.textColor,
    this.backgroundColor,
  });
  final String label;
  final Color? textColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      constraints: const BoxConstraints(
        minWidth: 88,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(4),
      ),
      child: TextBody.two(
        label,
        color: textColor,
        textAlign: TextAlign.center,
      ),
    );
  }

  factory CustomTagWidget.light({required String label, Color? textColor}) {
    return CustomTagWidget(
      label: label,
      textColor: textColor ?? Colors.black,
      backgroundColor: AppColors.background,
    );
  }

  factory CustomTagWidget.dark({required String label}) {
    return CustomTagWidget(
      label: label,
      textColor: Colors.white,
      backgroundColor: AppColors.onBackground,
    );
  }

  factory CustomTagWidget.orange({required String label}) {
    return CustomTagWidget(
      label: label,
      textColor: Colors.black,
      backgroundColor: AppColors.primaryNaranja,
    );
  }

  factory CustomTagWidget.yellow({required String label}) {
    return CustomTagWidget(
      label: label,
      textColor: Colors.black,
      backgroundColor: AppColors.primaryAmarillo,
    );
  }

  factory CustomTagWidget.warning({required String label}) {
    return CustomTagWidget(
      label: label,
      textColor: AppColors.specificSemanticWarning,
      backgroundColor: AppColors.background,
    );
  }

  factory CustomTagWidget.success({required String label}) {
    return CustomTagWidget(
      label: label,
      textColor: AppColors.specificSemanticSuccess,
      backgroundColor: AppColors.background,
    );
  }

  factory CustomTagWidget.error({required String label}) {
    return CustomTagWidget(
      label: label,
      textColor: AppColors.specificSemanticError,
      backgroundColor: AppColors.background,
    );
  }
}
