import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/loaders/circular_progress.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalCircularProgress {
  static OverlayEntry build(BuildContext context) {
    return OverlayEntry(
      builder: (context) {
        double fullHeight = MediaQuery.of(context).size.height;
        double fullWidth = MediaQuery.of(context).size.width;
        return _GlobalProgressWidget(
          fullHeight: fullHeight,
          fullWidth: fullWidth,
        );
      },
    );
  }
}

class _GlobalProgressWidget extends ConsumerStatefulWidget {
  const _GlobalProgressWidget({
    required this.fullHeight,
    required this.fullWidth,
  });

  final double fullHeight;
  final double fullWidth;

  @override
  __GlobalProgressWidgetState createState() => __GlobalProgressWidgetState();
}

class __GlobalProgressWidgetState extends ConsumerState<_GlobalProgressWidget> {
  double _opacity = 0;
  bool _opened = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_opacity == 0 && _opened == false) {
      Future.delayed(Duration.zero, () {
        setState(() {
          _opacity = 1;
          _opened = true;
        });
      });
    }
    ref.listen<bool>(hideOverlayProvider, (prevState, nextState) {
      if (nextState) {
        setState(() {
          _opacity = 0;
        });
      }
    });

    return Positioned(
      left: 0,
      top: 0,
      height: widget.fullHeight,
      width: widget.fullWidth,
      child: AnimatedOpacity(
        opacity: _opacity,
        duration: const Duration(milliseconds: 250),
        child: Container(
          height: widget.fullHeight,
          width: widget.fullWidth,
          color: MoggieColors.specificSemanticPrimary.withAlpha(210),
          child: const Center(
            child: CircularProgress(
              cupertinoBrightness: Brightness.dark,
            ),
          ),
        ),
      ),
    );
  }
}
