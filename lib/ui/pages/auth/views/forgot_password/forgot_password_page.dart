import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/components/column_scroll_view.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/form_scaffold.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/form/input_reactive.dart';
import 'package:flutter_base/ui/components/text/small_text.dart';
import 'package:flutter_base/ui/components/space_gap.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_base/ui/pages/auth/views/forgot_password/providers/forgot_password_provider.dart';
import 'package:flutter_base/ui/pages/auth/views/forgot_password/view_models/forgot_password_view_model.dart';
import 'package:flutter_base/ui/utils/form.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
      appBar: FlutterBaseAppBar.dialog(),
      body: SafeArea(
        child: ColumnScrollView(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            BoxSpacer.v16(),
            HighTextL(LocaleKeys.forgotPassword_title.tr()),
            BoxSpacer.v24(),
            SmallTextM(LocaleKeys.forgotPassword_claim.tr()),
            BoxSpacer.v16(),
            ForgotPasswordModelFormBuilder(
              model: ForgotPasswordViewModel(),
              builder: (context, formModel, child) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    InputReactive.email(
                      placeholder:
                          LocaleKeys.forgotPassword_form_email_label.tr(),
                      formControl: formModel.emailControl,
                    ),
                    BoxSpacer.v24(),
                    _buildContinueBtn(formModel),
                    SpaceGap.horizontal(),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }

  _buildContinueBtn(ForgotPasswordModelForm formModel) {
    return Consumer(builder: (context, ref, _) {
      return StreamBuilder<Map<String, Object?>?>(
        stream: formModel.form.valueChanges,
        builder: (context, snapshot) {
          var submitDisabled = true;
          if (snapshot.data != null) {
            submitDisabled = formValueIsEmpty(snapshot.data!, "email");
          }

          return ButtonPrimary(
            text: LocaleKeys.forgotPassword_form_submit.tr(),
            onPressed: submitDisabled
                ? null
                : () {
                    ref
                        .read(forgotPasswordProvider)
                        .requestChangePassword(formModel);
                  },
          );
        },
      );
    });
  }
}
