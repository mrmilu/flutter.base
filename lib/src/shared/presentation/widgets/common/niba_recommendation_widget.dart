import 'package:flutter/material.dart';

import '../image_asset_widget.dart';
import '../text/text_caption.dart';

class NibaRecommendationWidget extends StatelessWidget {
  const NibaRecommendationWidget({
    super.key,
    required this.title,
    this.content,
  });
  final String title;
  final Widget? content;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // const NibaLoadingWidget(size: 24),
        const ImageAssetWidget(
          path: 'assets/icons/main_ente.png',
          height: 28,
        ),
        const SizedBox(width: 8),
        content != null
            ? content!
            : Flexible(child: TextCaption.one(title, height: 1.5)),
      ],
    );
  }
}
