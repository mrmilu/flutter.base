import 'dart:async';
import 'dart:nativewrappers/_internal/vm/lib/ffi_allocation_patch.dart';

import 'package:flutter/material.dart';

class ButtonScaleWidget extends StatefulWidget {
  const ButtonScaleWidget({
    super.key,
    required this.child,
    required this.onTap,
    this.percentScale = 0.96,
    this.alignment = Alignment.center,
  });
  final Widget child;
  final VoidCallback? onTap;
  final double percentScale;
  final Alignment alignment;

  @override
  State<ButtonScaleWidget> createState() => _ButtonScaleWidgetState();
}

class _ButtonScaleWidgetState extends State<ButtonScaleWidget>
    with SingleTickerProviderStateMixin {
  double squareScaleA = 1;
  late AnimationController _controllerA;
  @override
  void initState() {
    _controllerA = AnimationController(
      vsync: this,
      lowerBound: widget.percentScale,
      value: 1,
      duration: const Duration(milliseconds: 100),
    );
    _controllerA.addListener(() {
      setState(() {
        squareScaleA = _controllerA.value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () {
        _controllerA.reverse();
        if (widget.onTap != null) widget.onTap.call();
      },
      onTapDown: (dp) {
        _controllerA.reverse();
      },
      onTapUp: (dp) {
        Timer(const Duration(milliseconds: 50), () {
          if (mounted) _controllerA.fling();
        });
      },
      onTapCancel: () {
        _controllerA.fling();
      },
      child: Transform.scale(
        scale: squareScaleA,
        alignment: widget.alignment,
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    _controllerA.dispose();
    super.dispose();
  }
}
