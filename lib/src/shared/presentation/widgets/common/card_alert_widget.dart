import 'package:flutter/material.dart';

import '../../utils/styles/colors.dart';
import '../components/buttons/custom_elevated_button.dart';
import '../components/buttons/custom_outlined_button.dart';
import '../text/text_body.dart';
import '../text/text_title.dart';

class CardAlertWidget extends StatelessWidget {
  const CardAlertWidget({
    super.key,
    required this.title,
    required this.description,
    this.buttonText,
    this.isButtonIsDisabled,
    this.onTap,
    this.backgroundColor = AppColors.primaryNaranja,
    this.border,
    this.extraContent,
    this.isElevatedButton = true,
  });
  final String title;
  final String? description;
  final String? buttonText;
  final bool? isButtonIsDisabled;
  final VoidCallback? onTap;
  final Color backgroundColor;
  final BoxBorder? border;
  final Widget? extraContent;
  final bool isElevatedButton;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: backgroundColor,
        border: border,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SizedBox(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextTitle.two(
                title,
              ),
              if (description != null) ...[
                const SizedBox(height: 16),
                TextBody.one(
                  description!,
                ),
              ],
              if (extraContent != null) ...[
                const SizedBox(height: 16),
                extraContent!,
              ],
              if (buttonText != null && onTap != null) ...[
                const SizedBox(height: 20),
                isElevatedButton
                    ? CustomElevatedButton.inverse(
                        onPressed: onTap!,
                        isDisabled: isButtonIsDisabled ?? false,
                        label: buttonText!,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      )
                    : CustomOutlinedButton.primary(
                        onPressed: onTap!,
                        // isDisabled: isButtonIsDisabled ?? false,
                        label: buttonText!,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                      ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  factory CardAlertWidget.withBorder({
    required String title,
    String? description,
    String? buttonText,
    bool? isButtonIsDisabled,
    VoidCallback? onTap,
    Color backgroundColor = AppColors.primaryNaranja,
    Color? bordeColor,
    Widget? extraContent,
    bool? isElevatedButton,
  }) {
    return CardAlertWidget(
      title: title,
      description: description,
      buttonText: buttonText,
      isButtonIsDisabled: isButtonIsDisabled,
      onTap: onTap,
      backgroundColor: backgroundColor,
      border: Border.all(color: bordeColor ?? AppColors.specificBasicGrey),
      extraContent: extraContent,
      isElevatedButton: isElevatedButton ?? true,
    );
  }
}
