import 'package:flutter/material.dart';

import '../utils/assets/app_assets_icons.dart';
import 'common/image_asset_widget.dart';
import 'components/text/rm_text.dart';

class WrapperBottomSheetWithButton extends StatelessWidget {
  const WrapperBottomSheetWithButton({
    super.key,
    required this.title,
    required this.child,
    this.hasScroll = true,
  });
  final String title;
  final Widget child;
  final bool hasScroll;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 8),
          Row(
            children: [
              const SizedBox(width: 50),
              Expanded(
                child: RMText.titleLarge(
                  title,
                  textAlign: TextAlign.center,
                ),
              ),
              InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Padding(
                  padding: EdgeInsets.all(12.0),
                  child: ImageAssetWidget(
                    path: AppAssetsIcons.close,
                    height: 20,
                    width: 20,
                  ),
                ),
              ),
              const SizedBox(width: 6),
            ],
          ),
          const SizedBox(width: 12),
          hasScroll ? Expanded(child: child) : child,
        ],
      ),
    );
  }
}
