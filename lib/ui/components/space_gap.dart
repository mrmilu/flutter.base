import 'package:flutter/material.dart';

enum GapType { horizontal, vertical }

class SpaceGap extends StatelessWidget {
  final GapType type;
  final double? size;

  const SpaceGap({
    super.key,
    required this.type,
    this.size,
  });

  @override
  Widget build(BuildContext context) {
    if (type == GapType.horizontal) {
      return Divider(
        color: Colors.transparent,
        height: size,
      );
    } else if (type == GapType.vertical) {
      return VerticalDivider(
        color: Colors.transparent,
        width: size,
      );
    }
    return Container();
  }

  factory SpaceGap.horizontal({double? size}) {
    return SpaceGap(
      type: GapType.horizontal,
      size: size,
    );
  }

  factory SpaceGap.vertical({double? size}) {
    return SpaceGap(
      type: GapType.vertical,
      size: size,
    );
  }
}
