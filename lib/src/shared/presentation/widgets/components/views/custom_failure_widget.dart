import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/mid_text.dart';

class CustomFailureWidget extends StatelessWidget {
  const CustomFailureWidget({
    super.key,
    this.height,
    this.title,
    this.imageUrl,
    this.onTap,
  });
  final double? height;
  final String? title;
  final String? imageUrl;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 200,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          MidText.l(
            title ?? LocaleKeys.states_error.tr(),
            textAlign: TextAlign.center,
          ),
          if (onTap != null)
            Center(
              child: TextButton(
                onPressed: onTap,
                child: MidText.m(
                  LocaleKeys.states_tryAgain.tr(),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
