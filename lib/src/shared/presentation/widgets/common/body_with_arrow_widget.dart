import 'package:flutter/material.dart';

import '../image_asset_widget.dart';
import '../text/text_caption.dart';

class BodyWithArrowWidget extends StatelessWidget {
  const BodyWithArrowWidget({
    super.key,
    required this.title,
    required this.onTap,
    this.padding,
  });
  final String title;
  final VoidCallback onTap;
  final EdgeInsets? padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: padding ?? const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Expanded(
              child: TextCaption.three(title),
            ),
            const SizedBox(width: 16),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: ImageAssetWidget(
                path: 'assets/icons/arrow_ios_right.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
