import 'package:flutter/material.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/text_styles.dart';
import 'package:reactive_forms/reactive_forms.dart';

class CheckboxReactiveInput extends ReactiveCheckboxListTile {
  CheckboxReactiveInput({
    super.key,
    super.formControl,
    super.formControlName,
    required String label,
    super.shape,
    super.tileColor,
    super.contentPadding,
  }) : super(
          checkboxShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(2),
          ),
          dense: true,
          side: const BorderSide(color: FlutterBaseColors.specificBorderMid),
          activeColor: FlutterBaseColors.specificSemanticPrimary,
          title: Transform.translate(
            offset: const Offset(-20, 0),
            child: Text(
              label,
              style: TextStyles.smallM.copyWith(
                height: 1.8,
              ),
            ),
          ),
          controlAffinity: ListTileControlAffinity.leading,
        );
}
