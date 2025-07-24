import 'package:flutter/material.dart';

import '../image_asset_widget.dart';
import '../text/text_title.dart';

class TitleWithArrowWidget extends StatelessWidget {
  const TitleWithArrowWidget({
    super.key,
    required this.title,
    required this.onTap,
  });
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextTitle.two(title),
        ),
        const SizedBox(width: 16),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: ImageAssetWidget(
              path: 'assets/icons/arrow_right.svg',
            ),
          ),
        ),
      ],
    );
  }
}
