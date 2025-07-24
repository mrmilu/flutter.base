import 'package:flutter/material.dart';

import '../button_scale_widget.dart';
import '../components/buttons/custom_elevated_button.dart';
import '../text/text_body.dart';
import '../text/text_title.dart';

class CardPromotionalWidget extends StatelessWidget {
  const CardPromotionalWidget({
    super.key,
    required this.title,
    required this.description,
    required this.buttonText,
    required this.onTap,
    required this.backgroundColor,
  });
  final String title;
  final String description;
  final String buttonText;
  final VoidCallback onTap;
  final Color backgroundColor;

  @override
  Widget build(BuildContext context) {
    return ButtonScaleWidget(
      onTap: onTap,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: backgroundColor,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SizedBox(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              spacing: 16,
              children: [
                TextTitle.two(
                  title,
                  textAlign: TextAlign.center,
                ),
                TextBody.one(description, textAlign: TextAlign.center),
                CustomElevatedButton.inverse(
                  onPressed: onTap,
                  label: buttonText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
