import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/icon_button_tertiary.dart';
import 'package:flutter_base/ui/components/column_scroll_view.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/styles/colors.dart';
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
  final String? title;
  final Widget dialogContent;
  final Widget? footer;
  final VoidCallback? onClose;
  final bool noCloseButton;

  const FlutterBaseDialog({
    super.key,
    required this.builder,
    this.title,
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
            barrierColor: MoggieColors.specificBackgroundOverlay1,
            isScrollControlled: true,
            builder: (BuildContext context) {
              return Padding(
                padding: EdgeInsets.only(
                  top: _hasHeader ? Spacing.sp32 : Spacing.sp8,
                  left: Spacing.sp16,
                  right: Spacing.sp16,
                  bottom: deviceBottomSafeArea + Spacing.sp16,
                ),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      if (_hasHeader)
                        Row(
                          mainAxisAlignment: title != null
                              ? MainAxisAlignment.spaceBetween
                              : MainAxisAlignment.end,
                          children: [
                            if (title != null)
                              Expanded(child: HighTextS(title!)),
                            if (!noCloseButton)
                              SizedBox(
                                width: 24,
                                child: IconButtonTertiary(
                                  icon: Icons.close,
                                  foregroundColor:
                                      MoggieColors.specificContentLow,
                                  onPressed: () {
                                    onClose?.call();
                                    Navigator.of(context).pop();
                                  },
                                ),
                              )
                          ],
                        ),
                      BoxSpacer.v12(),
                      if (!scrollable) dialogContent,
                      if (scrollable)
                        SizedBox(
                          height: scrollHeight,
                          child: ColumnScrollView(children: [dialogContent]),
                        ),
                      if (footer != null) ...[BoxSpacer.v24(), footer!]
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

  bool get _hasHeader => title != null || !noCloseButton;
}

class FlutterBaseDialogDelegate {
  final VoidCallback _showDialogCallback;

  FlutterBaseDialogDelegate._(this._showDialogCallback);

  void showDialog() {
    _showDialogCallback();
  }
}
