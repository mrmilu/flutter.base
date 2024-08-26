import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/mid_text.dart';

class CustomEmptyWidget extends StatelessWidget {
  const CustomEmptyWidget({
    super.key,
    this.height,
    this.title,
    this.imageUrl,
    this.showImage = true,
  });
  final double? height;
  final String? title;
  final String? imageUrl;
  final bool showImage;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (showImage)
            Center(
              child: Image.asset(
                imageUrl ?? 'assets/images/splash.png',
                height: 40,
              ),
            ),
          const SizedBox(height: 8),
          MidText.l(
            title ?? LocaleKeys.states_noContent.tr(),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
