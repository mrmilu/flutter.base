import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_base/core/auth/domain/use_cases/resend_reset_password_email_use_case.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:get_it/get_it.dart';

part 'forgot_password_confirm_provider.freezed.dart';

@freezed
class ForgotPasswordConfirmState with _$ForgotPasswordConfirmState {
  factory ForgotPasswordConfirmState({
    String? pageTitle,
    @Default(false) bool resend,
  }) = _ForgotPasswordConfirmState;
}

class ForgotPasswordProvider extends StateNotifier<ForgotPasswordConfirmState> {
  late UiProvider _uiProvider;
  final _resendResetPasswordEmailUseCase =
      GetIt.I.get<ResendResetPasswordEmailUseCase>();

  ForgotPasswordProvider(AutoDisposeStateNotifierProviderRef ref)
      : super(
          ForgotPasswordConfirmState(
            pageTitle: LocaleKeys.forgotPasswordConfirm_title.tr(),
          ),
        ) {
    _uiProvider = ref.read(uiProvider.notifier);
  }

  void resendRequestChange(String email) async {
    _uiProvider.tryAction(() async {
      final input = ResendResetPasswordEmailUseCaseInput(email: email);
      await _resendResetPasswordEmailUseCase(input);
      state = state.copyWith(
        pageTitle: LocaleKeys.forgotPasswordConfirm_resendTitle.tr(),
      );
    });
  }
}

final forgotPasswordConfirmProvider = AutoDisposeStateNotifierProvider<
    ForgotPasswordProvider,
    ForgotPasswordConfirmState>((ref) => ForgotPasswordProvider(ref));
