import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../providers/global_loader/global_loader_cubit.dart';
import 'common/circular_progress.dart';

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

class _GlobalProgressWidget extends StatefulWidget {
  const _GlobalProgressWidget({
    required this.fullHeight,
    required this.fullWidth,
  });

  final double fullHeight;
  final double fullWidth;

  @override
  __GlobalProgressWidgetState createState() => __GlobalProgressWidgetState();
}

class __GlobalProgressWidgetState extends State<_GlobalProgressWidget> {
  double _opacity = 0;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _opacity = 1;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<GlobalLoaderCubit, GlobalLoaderState>(
      listener: (context, state) {
        if (state.hideLoaderOverlayEntry) {
          setState(() {
            _opacity = 0;
          });
        }
      },
      child: Positioned(
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
            color: Colors.grey.withAlpha((0.5 * 255).toInt()),
            child: const Center(
              child: CircularProgress(
                cupertinoBrightness: Brightness.light,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
