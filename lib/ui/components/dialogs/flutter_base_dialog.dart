import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/icon_button_tertiary.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/views/column_scroll_view.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/insets.dart';
import 'package:flutter_base/ui/styles/spacing.dart';
import 'package:flutter_base/ui/utils/media_query.dart';

typedef FlutterBaseDialogBuilder = Widget Function(
  BuildContext context,
  FlutterBaseDialogDelegate dialogDelegate,
);

class FlutterBaseDialogDismissOption {
  final bool doNotCallOnClose;

  const FlutterBaseDialogDismissOption({
    required this.doNotCallOnClose,
  });
}

class FlutterBaseDialog extends StatelessWidget {
  final FlutterBaseDialogBuilder builder;
  final bool scrollable;
  final double scrollHeight;
  final String title;
  final Widget dialogContent;
  final Widget? footer;
  final VoidCallback? onClose;
  final bool noCloseButton;

  const FlutterBaseDialog({
    super.key,
    required this.builder,
    this.title = '',
    required this.dialogContent,
    this.footer,
    this.scrollable = false,
    this.scrollHeight = 480,
    this.onClose,
    this.noCloseButton = false,
  });

  @override
  Widget build(BuildContext context) {
    return builder(
      context,
      FlutterBaseDialogDelegate._(
        () {
          showModalBottomSheet(
            context: context,
            barrierColor: FlutterBaseColors.specificBackgroundOverlay1,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                      top: _hasHeader ? Spacing.sp32 : Spacing.sp8,
                      bottom: deviceBottomSafeArea + Spacing.sp16,
                    ) +
                    Insets.h16,
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_hasHeader)
                        Row(
                          mainAxisAlignment: title.isNotEmpty
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.end,
                          children: [
                            if (title.isNotEmpty)
                              Expanded(child: HighText.s(title)),
                            if (!noCloseButton)
                              SizedBox(
                                width: 24,
                                child: IconButtonTertiary(
                                  icon: Icons.close,
                                  foregroundColor:
                                      FlutterBaseColors.specificContentLow,
                                  onPressed: () {
                                    onClose?.call();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              ),
                          ],
                        ),
                      BoxSpacer.v12(),
                      scrollable
                          ? SizedBox(
                              height: scrollHeight,
                              child:
                                  ColumnScrollView(children: [dialogContent]),
                            )
                          : dialogContent,
                      if (footer != null) ...[
                        BoxSpacer.v24(),
                        footer ?? const SizedBox.shrink(),
                      ],
                    ],
                  ),
                ),
              );
            },
          ).then((value) {
            if (value is FlutterBaseDialogDismissOption) {
              if (!value.doNotCallOnClose) {
                onClose?.call();
              }
            } else {
              onClose?.call();
            }
          });
        },
      ),
    );
  }

  bool get _hasHeader => title.isNotEmpty || !noCloseButton;
}

class FlutterBaseDialogDelegate {
  final VoidCallback _showDialogCallback;

  FlutterBaseDialogDelegate._(this._showDialogCallback);

  void showDialog() {
    _showDialogCallback();
  }
}
