import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';
import 'package:flutter_base/ui/components/box_spacer.dart';
import 'package:flutter_base/ui/components/buttons/button_secondary.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/pages/auth/containers/social_auth/social_auth_provider.dart';
import 'package:flutter_base/ui/styles/colors.dart';
import 'package:flutter_base/ui/styles/text_style.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum SocialAuthType { login, singUp }

class SocialAuth extends ConsumerWidget {
  final SocialAuthType type;

  const SocialAuth({
    super.key,
    this.type = SocialAuthType.login,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (Platform.isIOS) ...[
          ButtonSecondary(
            iconName: "apple_logo",
            onPressed: () {
              _appleAuth(ref);
            },
            customTextStyle: MoggieTextStyles.midM.copyWith(
              fontSize: 15,
              color: MoggieColors.specificContentHigh,
            ),
            text: _appleBtnTxt,
          ),
          BoxSpacer.v8(),
        ],
        ButtonSecondary(
          iconName: "google_logo",
          text: _googleBtnTxt,
          customTextStyle: MoggieTextStyles.midM.copyWith(
            fontSize: 15,
            color: MoggieColors.specificContentHigh,
          ),
          onPressed: () {
            _googleAuth(ref);
          },
        )
      ],
    );
  }

  String get _appleBtnTxt => type == SocialAuthType.singUp
      ? LocaleKeys.login_socialAuth_signUp_apple.tr()
      : LocaleKeys.login_socialAuth_login_apple.tr();

  String get _googleBtnTxt => type == SocialAuthType.singUp
      ? LocaleKeys.login_socialAuth_signUp_google.tr()
      : LocaleKeys.login_socialAuth_login_google.tr();

  void _appleAuth(WidgetRef ref) {
    if (type == SocialAuthType.login) {
      ref.read(socialAuthProvider).socialLogin(AuthProvider.apple);
    }
    if (type == SocialAuthType.singUp) {
      ref.read(socialAuthProvider).socialSignUp(AuthProvider.apple);
    }
  }

  void _googleAuth(WidgetRef ref) {
    if (type == SocialAuthType.login) {
      ref.read(socialAuthProvider).socialLogin(AuthProvider.google);
    }
    if (type == SocialAuthType.singUp) {
      ref.read(socialAuthProvider).socialSignUp(AuthProvider.google);
    }
  }
}
