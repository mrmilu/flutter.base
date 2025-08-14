import 'package:flutter/material.dart';

import '../../../extensions/buildcontext_extensions.dart';
import '../../../utils/styles/colors/colors_context.dart';
import '../../common/custom_row_icon_text_widget.dart';
import 'template_verification_code.dart';

class CustomCodeFieldWidget extends StatelessWidget {
  const CustomCodeFieldWidget({
    super.key,
    this.enabled = true,
    this.title,
    required this.onCompleted,
    this.infoText,
    this.showError = false,
    this.errorText,
  });
  final bool enabled;
  final String? title;
  final Function(String) onCompleted;
  final String? infoText;
  final bool showError;
  final String? errorText;

  Color _getBorderColor(BuildContext context) {
    if (!enabled) {
      return context.colors.specificBasicGrey;
    }
    if (showError) {
      return context.colors.specificSemanticError;
    }
    return context.colors.specificBasicBlack;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.colors.specificBasicWhite,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(width: 1, color: _getBorderColor(context)),
          ),
          alignment: Alignment.center,
          child: Center(
            child: TemplateVerificationCode(
              enabled: true,
              length: 6,
              textStyle: context.textTheme.bodyMedium,
              keyboardType: TextInputType.number,
              underlineColor: Colors.white,
              cursorColor: Colors.black,
              margin: EdgeInsets.zero,
              itemSize: 48,
              padding: EdgeInsets.zero,
              fullBorder: true,
              underlineWidth: 0,
              underlineUnfocusedColor: Colors.transparent,
              onCompleted: onCompleted,
              onEditing: (bool value) {},
            ),
          ),
        ),
        if ((errorText != null && showError) || infoText != null) ...[
          const SizedBox(height: 8),
          showError
              ? CustomRowIconTextWidget.warning(errorText!, context: context)
              : CustomRowIconTextWidget.info(infoText!, context: context),
        ],
      ],
    );
  }
}
