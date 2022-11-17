import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FlutterBaseSvgIcon extends StatelessWidget {
  final String iconName;
  final double? width;
  final double? height;
  final Color? color;

  const FlutterBaseSvgIcon({
    super.key,
    required this.iconName,
    this.width = 24,
    this.height = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      'assets/icons/$iconName.svg',
      semanticsLabel: 'icon_$iconName',
      width: width,
      height: height,
      color: color,
      fit: BoxFit.cover,
    );
  }
}
