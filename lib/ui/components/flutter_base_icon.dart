import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgFlutterBaseIcon extends StatelessWidget {
  final String iconName;
  final double? width;
  final double? height;
  final Color? color;

  const SvgFlutterBaseIcon({
    super.key,
    required this.iconName,
    this.width = 24,
    this.height = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      "assets/icons/$iconName.svg",
      semanticsLabel: "icon_$iconName",
      width: width,
      height: height,
      color: color,
      fit: BoxFit.cover,
    );
  }
}

class FlutterBaseIcon extends StatelessWidget {
  final IconData icon;
  final double? size;
  final Color? color;

  const FlutterBaseIcon({
    super.key,
    required this.icon,
    this.size = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Icon(
      icon,
      size: size,
      color: color,
    );
  }
}
