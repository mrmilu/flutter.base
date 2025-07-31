import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../shared/presentation/utils/extensions/color_extension.dart';
import '../../../shared/presentation/utils/styles/colors.dart';
import '../../../shared/presentation/utils/styles/text_styles.dart';
import '../../../shared/presentation/widgets/common/image_asset_widget.dart';
import '../../../shared/presentation/widgets/common/image_network_widget.dart';

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    this.iconUrl,
    required this.title,
    this.subtitle,
    required this.onTap,
    this.isProfileImage = false,
    this.showButton = true,
    this.showIcon = false,
    this.isActive = true,
    this.isLoading = false,
    this.padding = EdgeInsets.zero,
  });
  final String? iconUrl;
  final String title;
  final String? subtitle;
  final VoidCallback onTap;
  final bool isProfileImage;
  final bool showButton;
  final bool showIcon;
  final bool isActive;
  final bool isLoading;
  final EdgeInsets padding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: showButton && isActive ? onTap : null,
      highlightColor: Colors.transparent,
      child: Padding(
        padding: padding,
        child: Row(
          children: [
            if (showIcon)
              Container(
                width: isProfileImage ? 80 : 30,
                margin: const EdgeInsets.only(right: 24.0),
                child: isProfileImage
                    ? Container(
                        height: 80,
                        width: 80,
                        clipBehavior: Clip.antiAlias,
                        decoration: const BoxDecoration(
                          color: AppColors.secondary,
                          shape: BoxShape.circle,
                        ),
                        child: ImageNetworkWidget(
                          imageUrl: iconUrl,
                        ),
                      )
                    : SvgPicture.asset(
                        iconUrl!,
                        height: 30,
                        width: 30,
                        colorFilter: isActive
                            ? const ColorFilter.mode(
                                AppColors.secondary,
                                BlendMode.srcATop,
                              )
                            : ColorFilter.mode(
                                AppColors.onBackground.wOpacity(0.3),
                                BlendMode.srcATop,
                              ),
                      ),
              ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.body1.copyWith(
                      color: isActive
                          ? Colors.black
                          : AppColors.onBackground.wOpacity(0.3),
                    ),
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: isProfileImage ? 12 : 4),
                    Text(
                      subtitle!,
                      style: AppTextStyles.caption1.copyWith(
                        color: isActive
                            ? AppColors.specificBasicGrey
                            : AppColors.onBackground.wOpacity(0.3),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            if (showButton)
              Center(
                child: isLoading
                    ? const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: CircularProgressIndicator(),
                      )
                    : Padding(
                        padding: const EdgeInsets.only(left: 2.0),
                        child: ImageAssetWidget(
                          path: 'assets/icons/arrow_ios_right.svg',
                          width: 24,
                          height: 24,
                          color: isActive
                              ? AppColors.specificBasicBlack
                              : AppColors.onBackground.wOpacity(0.3),
                        ),
                      ),
              ),
          ],
        ),
      ),
    );
  }
}
