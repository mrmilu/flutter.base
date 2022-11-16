import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_tertiary.dart';
import 'package:flutter_base/ui/components/column_scroll_view.dart';
import 'package:flutter_base/ui/components/flutter_base_app_bar.dart';
import 'package:flutter_base/ui/components/form_scaffold.dart';
import 'package:flutter_base/ui/components/text/high_text.dart';
import 'package:flutter_base/ui/components/text/small_text.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/pages/auth/containers/social_auth/social_auth.dart';
import 'package:flutter_base/ui/pages/auth/views/sign_up/sign_up_form.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/text_style.dart';
import 'package:flutter_base/ui/view_models/button_size.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class SignUpPage extends ConsumerWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FormScaffold(
      appBar: FlutterBaseAppBar(
        trailing: Row(
          children: [
            SmallTextM(LocaleKeys.signUp_haveAccount.tr()),
            BoxSpacer.h4(),
            ButtonTertiary(
              text: LocaleKeys.signUp_signIn.tr(),
              fixedSize: const Size(50, 18),
              size: ButtonSize.small,
              onPressed: () {
                GoRouter.of(context).push('/login');
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
            HighTextL(LocaleKeys.signUp_title.tr()),
            BoxSpacer.v32(),
            const SignUpForm(),
            BoxSpacer.v48(),
            SmallTextM(LocaleKeys.signUp_alternative.tr()),
            BoxSpacer.v16(),
            const SocialAuth(type: SocialAuthType.singUp),
            BoxSpacer.v16(),
            const TermAndPrivacy()
          ],
        ),
      ),
    );
  }
}

class TermAndPrivacy extends StatelessWidget {
  const TermAndPrivacy({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: MoggieTextStyles.smallS.copyWith(
          color: MoggieColors.specificContentLow,
        ),
        children: [
          TextSpan(
            text: LocaleKeys.signUp_termsAndPrivacy_blockOne.tr(),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {},
            style: MoggieTextStyles.smallS.copyWith(
              color: MoggieColors.specificContentHigh,
            ),
            text: LocaleKeys.signUp_termsAndPrivacy_blockTwo.tr(),
          ),
          TextSpan(
            text: LocaleKeys.signUp_termsAndPrivacy_blockThree.tr(),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {},
            style: MoggieTextStyles.smallS.copyWith(
              color: MoggieColors.specificContentHigh,
            ),
            text: LocaleKeys.signUp_termsAndPrivacy_blockFour.tr(),
          ),
        ],
      ),
    );
  }
}
