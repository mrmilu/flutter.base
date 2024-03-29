import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/form_scaffold.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/views/column_scroll_view.dart';
import 'package:flutter_base/ui/features/auth/views/change_password/change_password_form.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/styles/insets.dart';

class ChangePasswordPageData {
  final String token;
  final String uid;

  const ChangePasswordPageData({
    required this.token,
    required this.uid,
  });
}

class ChangePasswordPage extends StatelessWidget {
  final ChangePasswordPageData data;

  const ChangePasswordPage({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return FormScaffold(
      appBar: FlutterBaseAppBar.dialog(),
      body: SafeArea(
        child: ColumnScrollView(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          padding: Insets.h24,
          children: [
            BoxSpacer.v16(),
            HighText.l(LocaleKeys.changePassword_title.tr()),
            BoxSpacer.v24(),
            ChangePasswordForm(
              token: data.token,
              uid: data.uid,
            ),
          ],
        ),
      ),
    );
  }
}
