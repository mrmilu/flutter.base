import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/presentation/utils/extensions/string_extension.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ImageAssetWidget extends StatelessWidget {
  final String path;
  final double? width;
  final double? height;

  final Color? color;
  final BlendMode colorBlendMode;
  final BoxFit fit;
  const ImageAssetWidget({
    super.key,
    required this.path,
    this.width,
    this.height,
    this.color,
    this.colorBlendMode = BlendMode.srcIn,
    this.fit = BoxFit.cover,
  });

  @override
  Widget build(BuildContext context) {
    if (path.isSvg()) {
      return SvgPicture.asset(
        path,
        width: width,
        height: height,
        fit: fit,
        colorFilter:
            color != null ? ColorFilter.mode(color!, colorBlendMode) : null,
      );
    } else {
      return Image.asset(
        path,
        width: width,
        height: height,
        color: color,
        fit: fit,
        colorBlendMode: colorBlendMode,
      );
    }
  }
}
