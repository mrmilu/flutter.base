import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/ioc/locator.dart';
import 'package:flutter_base/src/shared/presentation/pages/full_screen_image_page.dart';
import 'package:flutter_base/src/shared/presentation/utils/extensions/string_extension.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/border_radius.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_svg/svg.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String? imageUrl;
  final String? imageFullScreenUrl;
  final BoxFit boxFit;
  final double height, width;
  final bool allowFullscreen;
  final int? cacheWidth, cacheHeight;

  const ImageNetworkWidget({
    super.key,
    required this.imageUrl,
    this.imageFullScreenUrl,
    this.boxFit = BoxFit.cover,
    this.height = 300,
    this.width = 300,
    this.allowFullscreen = false,
    this.cacheWidth,
    this.cacheHeight,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null) {
      return SvgPicture.asset(
        'assets/icons/empty_profile_photo.svg', // TODO: Pending add empty profile photo
        height: height,
        width: width,
      );
    }

    if (imageUrl!.isEmpty || imageUrl!.contains('http') == false) {
      return SvgPicture.asset(
        'assets/icons/empty_profile_photo.svg', // TODO: Pending add empty profile photo
        height: height,
        width: width,
      );
    }
    if (imageUrl!.isSvg()) {
      return SvgPicture.network(
        imageUrl!,
        fit: boxFit,
        height: height,
        width: width,
      );
    }

    final placeholder = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: FlutterBaseColors.specificContentLow.withOpacity(.20),
        borderRadius: CircularBorderRadius.br16,
      ),
    );

    final widget = CachedNetworkImage(
      imageUrl: imageUrl!,
      width: width,
      height: height,
      fit: boxFit,
      maxWidthDiskCache: cacheWidth,
      maxHeightDiskCache: cacheHeight,
      cacheManager: getIt<BaseCacheManager>(),
      cacheKey: key.toString(),
      placeholder: (context, _) => Center(child: placeholder),
      errorWidget: (ctx, _, __) => placeholder,
    );

    if (!allowFullscreen) {
      return widget;
    }

    return GestureDetector(
      onTap: () {
        if (allowFullscreen && imageFullScreenUrl != null) {
          Navigator.push(
            context,
            PageRouteBuilder<void>(
              pageBuilder: (context, animation1, animation2) {
                return ScaleTransition(
                  scale: animation1,
                  child: FullscreenImagePage(
                    imageUrl: imageFullScreenUrl!,
                  ),
                );
              },
            ),
          );
        }
      },
      child: widget,
    );
  }
}
