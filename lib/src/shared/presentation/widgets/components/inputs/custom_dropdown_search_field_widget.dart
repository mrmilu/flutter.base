import 'package:flutter/material.dart';

import '../../../utils/styles/colors/colors_context.dart';
import '../../common/custom_row_icon_text_widget.dart';

class CustomDropdownSearchFieldWidget<T> extends StatelessWidget {
  const CustomDropdownSearchFieldWidget({
    super.key,
    this.enabled = true,
    this.title,
    this.initialValue,
    required this.onChanged,
    this.infoText,
    this.showError = false,
    this.errorText,
    this.readOnly = false,
    this.value,
    required this.items,
    this.borderRadius = 32.0,
  });
  final bool enabled;
  final String? title;
  final String? initialValue;
  final Function(T) onChanged;
  final String? infoText;
  final bool showError;
  final String? errorText;
  final bool readOnly;
  final double borderRadius;

  final T? value;
  final List<DropdownMenuEntry<T>> items;

  Color _getBorderColor(BuildContext context) {
    if (!enabled || readOnly) {
      return context.colors.specificBasicGrey;
    }
    if (showError) {
      return context.colors.specificSemanticError;
    }
    return context.colors.specificBasicBlack;
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      ignoring: readOnly,
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: readOnly
                  ? context.colors.background
                  : context.colors.specificBasicWhite,
              borderRadius: BorderRadius.circular(borderRadius),
              border: Border.all(width: 1, color: _getBorderColor(context)),
            ),
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LayoutBuilder(
                  builder: (context, constrain) {
                    return DropdownMenu<T>(
                      label: const Text('Country'),
                      width: constrain.maxWidth,
                      dropdownMenuEntries: items,
                      enableFilter: true,
                      menuStyle: const MenuStyle(
                        alignment: Alignment.bottomLeft,
                      ),
                      requestFocusOnTap: true,
                      menuHeight: 200,

                      onSelected: (item) {},
                    );
                  },
                ),
              ],
            ),
          ),
          if ((errorText != null && showError) || infoText != null) ...[
            const SizedBox(height: 8),
            showError
                ? CustomRowIconTextWidget.error(errorText!, context: context)
                : CustomRowIconTextWidget.info(infoText!, context: context),
          ],
        ],
      ),
    );
  }
}
