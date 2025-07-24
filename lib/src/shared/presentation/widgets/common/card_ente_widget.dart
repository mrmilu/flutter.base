import 'package:flutter/material.dart';

import '../../utils/styles/colors.dart';
import '../button_scale_widget.dart';
import '../components/buttons/custom_outlined_button.dart';
import '../image_asset_widget.dart';
import '../text/text_body.dart';
import '../text/text_title.dart';

class CardEnteWidget extends StatelessWidget {
  const CardEnteWidget({
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
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: backgroundColor,
          border: Border.all(color: AppColors.specificBasicGrey),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            const Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: ImageAssetWidget(
                path: 'assets/images/ente_partial.png',
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                spacing: 16,
                children: [
                  TextTitle.two(
                    title,
                    textAlign: TextAlign.center,
                  ),
                  TextBody.one(description, textAlign: TextAlign.center),
                  CustomOutlinedButton.primary(
                    onPressed: onTap,
                    label: buttonText,
                    backgroundColor: backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    iconWidget: const ImageAssetWidget(
                      path: 'assets/icons/main_ente.png',
                      height: 24,
                    ), //const NibaLoadingWidget(size: 24),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
