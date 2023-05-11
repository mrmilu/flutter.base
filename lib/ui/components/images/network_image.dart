import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_base/core/app/ioc/locator.dart';
import 'package:flutter_base/ui/styles/border_radius.dart';
import 'package:flutter_base/ui/styles/colors.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class FlutterBaseNetworkImage extends StatelessWidget {
  final String url;
  final double? width;
  final double? height;
  final BoxFit? fit;

  /// The target image's cache key. If not specified get the url.
  ///
  /// In some contexts the same image may have a different url when requested
  /// from different sites. If so, use this parameter to have a unique key for
  /// each image.
  final String? cacheKey;

  /// Will resize the image and store the resized image in the disk cache.
  ///
  /// If the image is too big it will not be cached, so this property helps us
  /// to compress the image if the width is greater than the specified value.
  final int? maxWidthDiskCache;

  /// Will resize the image and store the resized image in the disk cache.
  ///
  /// If the image is too big it will not be cached, so this property helps
  /// us to compress the image if the height is greater than the specified value.
  final int? maxHeightDiskCache;

  const FlutterBaseNetworkImage(
    this.url, {
    super.key,
    this.width,
    this.height,
    this.fit,
    this.cacheKey,
    this.maxWidthDiskCache,
    this.maxHeightDiskCache,
  });

  @override
  Widget build(BuildContext context) {
    final placeholder = Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: FlutterBaseColors.specificContentLow.withOpacity(.20),
        borderRadius: CircularBorderRadius.br16,
      ),
    );

    return CachedNetworkImage(
      imageUrl: url,
      fit: fit,
      width: width,
      height: height,
      maxWidthDiskCache: maxWidthDiskCache,
      maxHeightDiskCache: maxHeightDiskCache,
      cacheManager: getIt<BaseCacheManager>(),
      cacheKey: cacheKey,
      placeholder: (context, _) => Center(child: placeholder),
      errorWidget: (ctx, _, __) => placeholder,
    );
  }
}
