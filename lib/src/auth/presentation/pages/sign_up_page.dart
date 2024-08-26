import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/presentation/widgets/sign_up_form.dart';
import 'package:flutter_base/src/auth/presentation/widgets/social_auth.dart';
import 'package:flutter_base/src/shared/domain/types/button_size.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/insets.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/text_styles.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/box_spacer.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_tertiary.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/flutter_base_app_bar.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/high_text.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/text/small_text.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/views/column_scroll_view.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/views/form_scaffold.dart';
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
            SmallText.m(LocaleKeys.signUp_haveAccount.tr()),
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
          padding: Insets.h24,
          children: [
            BoxSpacer.v16(),
            HighText.l(LocaleKeys.signUp_title.tr()),
            BoxSpacer.v32(),
            const SignUpForm(),
            BoxSpacer.v48(),
            SmallText.m(LocaleKeys.signUp_alternative.tr()),
            BoxSpacer.v16(),
            const SocialAuth(type: SocialAuthType.singUp),
            BoxSpacer.v16(),
            const _TermAndPrivacy(),
          ],
        ),
      ),
    );
  }
}

class _TermAndPrivacy extends StatelessWidget {
  const _TermAndPrivacy();

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyles.smallS.copyWith(
          color: FlutterBaseColors.specificContentLow,
        ),
        children: [
          TextSpan(
            text: LocaleKeys.signUp_termsAndPrivacy_blockOne.tr(),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {},
            style: TextStyles.smallS.copyWith(
              color: FlutterBaseColors.specificContentHigh,
            ),
            text: LocaleKeys.signUp_termsAndPrivacy_blockTwo.tr(),
          ),
          TextSpan(
            text: LocaleKeys.signUp_termsAndPrivacy_blockThree.tr(),
          ),
          TextSpan(
            recognizer: TapGestureRecognizer()..onTap = () {},
            style: TextStyles.smallS.copyWith(
              color: FlutterBaseColors.specificContentHigh,
            ),
            text: LocaleKeys.signUp_termsAndPrivacy_blockFour.tr(),
          ),
        ],
      ),
    );
  }
}
