import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/application/social_auth_provider.dart';
import 'package:flutter_base/src/auth/domain/enums/auth_provider.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/utils/platform_utils.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/colors.dart';
import 'package:flutter_base/src/shared/presentation/utils/styles/text_styles.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/box_spacer.dart';
import 'package:flutter_base/src/shared/presentation/widgets/components/buttons/button_secondary.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SocialAuthType { login, singUp }

class SocialAuth extends ConsumerWidget {
  final SocialAuthType type;

  const SocialAuth({
    super.key,
    this.type = SocialAuthType.login,
  });

  void _appleAuth(WidgetRef ref) {
    if (type == SocialAuthType.login) {
      ref
          .read(socialAuthProvider.notifier)
          .socialLogin(SocialAuthServiceProvider.apple);
    }
    if (type == SocialAuthType.singUp) {
      ref
          .read(socialAuthProvider.notifier)
          .socialSignUp(SocialAuthServiceProvider.apple);
    }
  }

  void _googleAuth(WidgetRef ref) {
    if (type == SocialAuthType.login) {
      ref
          .read(socialAuthProvider.notifier)
          .socialLogin(SocialAuthServiceProvider.google);
    }
    if (type == SocialAuthType.singUp) {
      ref
          .read(socialAuthProvider.notifier)
          .socialSignUp(SocialAuthServiceProvider.google);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (PlatformUtils.isIOS) ...[
          ButtonSecondary(
            iconName: 'apple_logo',
            onPressed: () {
              _appleAuth(ref);
            },
            customTextStyle: TextStyles.midM.copyWith(
              fontSize: 15,
              color: FlutterBaseColors.specificContentHigh,
            ),
            text: _appleBtnTxt,
          ),
          BoxSpacer.v8(),
        ],
        ButtonSecondary(
          iconName: 'google_logo',
          text: _googleBtnTxt,
          customTextStyle: TextStyles.midM.copyWith(
            fontSize: 15,
            color: FlutterBaseColors.specificContentHigh,
          ),
          onPressed: () {
            _googleAuth(ref);
          },
        ),
      ],
    );
  }

  String get _appleBtnTxt => type == SocialAuthType.singUp
      ? LocaleKeys.login_socialAuth_signUp_apple.tr()
      : LocaleKeys.login_socialAuth_login_apple.tr();

  String get _googleBtnTxt => type == SocialAuthType.singUp
      ? LocaleKeys.login_socialAuth_signUp_google.tr()
      : LocaleKeys.login_socialAuth_login_google.tr();
}
