import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/application/ui_provider.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/loaders/circular_progress.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GlobalCircularProgress {
  static OverlayEntry build() {
    return OverlayEntry(
      builder: (context) => _GlobalProgressWidget(
        fullHeight: MediaQuery.of(context).size.height,
        fullWidth: MediaQuery.of(context).size.width,
      ),
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

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() => _opacity = 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<bool>(hideOverlayProvider, (prevState, nextState) {
      if (nextState) {
        setState(() => _opacity = 0);
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
          color: FlutterBaseColors.specificSemanticPrimary.withAlpha(210),
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
