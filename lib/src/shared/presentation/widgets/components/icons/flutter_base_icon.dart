import 'package:flutter/widgets.dart';

class FlutterBaseIcon extends StatelessWidget {
  final IconData? icon;
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
