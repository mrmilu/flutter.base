import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_tertiary.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/form_scaffold.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/text/small_text.dart';
import 'package:flutter_base/ui/components/views/column_scroll_view.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/pages/auth/containers/social_auth/social_auth.dart';
import 'package:flutter_base/ui/pages/auth/views/login/login_form.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormScaffold(
      appBar: FlutterBaseAppBar(
        trailing: Row(
          children: [
            SmallTextM(LocaleKeys.login_noAccount.tr()),
            BoxSpacer.h4(),
            ButtonTertiary(
              text: LocaleKeys.login_signUp.tr(),
              fixedSize: const Size(53, 18),
              size: ButtonSize.small,
              onPressed: () {
                GoRouter.of(context).push("/sign-up");
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: ColumnScrollView(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            BoxSpacer.v16(),
            HighTextL(LocaleKeys.login_title.tr()),
            BoxSpacer.v24(),
            const LoginForm(),
            BoxSpacer.v48(),
            SmallTextM(LocaleKeys.login_or.tr()),
            BoxSpacer.v16(),
            const SocialAuth(),
          ],
        ),
      ),
    );
  }
}
