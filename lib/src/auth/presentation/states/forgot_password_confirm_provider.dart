import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/src/auth/application/use_cases/resend_reset_password_email_use_case.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/states/ui_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'forgot_password_confirm_provider.freezed.dart';

@freezed
class ForgotPasswordConfirmState with _$ForgotPasswordConfirmState {
  factory ForgotPasswordConfirmState({
    @Default('') String pageTitle,
    @Default(false) bool resend,
  }) = _ForgotPasswordConfirmState;
}

class ForgotPasswordNotifier
    extends AutoDisposeNotifier<ForgotPasswordConfirmState> {
  final _resendResetPasswordEmailUseCase =
      GetIt.I.get<ResendResetPasswordEmailUseCase>();

  @override
  ForgotPasswordConfirmState build() {
    return ForgotPasswordConfirmState(
      pageTitle: LocaleKeys.forgotPasswordConfirm_title.tr(),
    );
  }

  void resendRequestChange(String email) async {
    ref.read(uiProvider.notifier).tryAction(() async {
      await _resendResetPasswordEmailUseCase(email);
      state = state.copyWith(
        pageTitle: LocaleKeys.forgotPasswordConfirm_resendTitle.tr(),
      );
    });
  }
}

final forgotPasswordConfirmProvider = AutoDisposeNotifierProvider<
    ForgotPasswordNotifier,
    ForgotPasswordConfirmState>(ForgotPasswordNotifier.new);
