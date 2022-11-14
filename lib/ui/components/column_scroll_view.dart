import 'package:flutter/widgets.dart';

class ColumnScrollView extends StatelessWidget {
  final List<Widget> children;
  final CrossAxisAlignment crossAxisAlignment;
  final ScrollController? controller;
  final MainAxisAlignment mainAxisAlignment;
  final EdgeInsets padding;
  final bool disableKeyboardPadding;

  const ColumnScrollView({
    super.key,
    required this.children,
    this.crossAxisAlignment = CrossAxisAlignment.center,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.padding = const EdgeInsets.all(0),
    this.disableKeyboardPadding = false,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final double keyboardHeight = MediaQuery.of(context).viewInsets.bottom;
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints viewportConstraints) {
        return SingleChildScrollView(
          controller: controller,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: viewportConstraints.maxHeight,
            ),
            child: IntrinsicHeight(
              child: Padding(
                padding: EdgeInsets.only(
                    top: padding.top,
                    left: padding.left,
                    right: padding.right,
                    bottom: (disableKeyboardPadding ? 0 : keyboardHeight) +
                        padding.bottom),
                child: Column(
                  crossAxisAlignment: crossAxisAlignment,
                  mainAxisAlignment: mainAxisAlignment,
                  children: children,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
