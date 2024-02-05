import 'package:flutter_base/core/auth/domain/use_cases/reset_password_use_case.dart';
import 'package:flutter_base/ui/features/auth/views/forgot_password/forgot_password_confirm_page.dart';
import 'package:flutter_base/ui/features/auth/views/forgot_password/view_models/forgot_password_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ForgotPasswordNotifier
    extends AutoDisposeNotifier<ForgotPasswordModelForm> {
  final _resetPasswordUseCase = GetIt.I.get<ResetPasswordUseCase>();
  final _appRouter = GetIt.I.get<GoRouter>();

  @override
  ForgotPasswordModelForm build() {
    return ForgotPasswordViewModel().formModel;
  }

  void requestChangePassword() async {
    state.form.markAllAsTouched();
    if (state.form.valid) {
      ref.read(uiProvider.notifier).tryAction(() async {
        FocusManager.instance.primaryFocus?.unfocus();
        final input =
            ResetPasswordUseCaseInput(email: state.model.email.trim());
        await _resetPasswordUseCase(input);
        _appRouter.push(
          '/forgot-password/confirm',
          extra: ForgotPasswordConfirmPageData(email: input.email),
        );
      });
    }
  }
}

final forgotPasswordProvider = AutoDisposeNotifierProvider<
    ForgotPasswordNotifier, ForgotPasswordModelForm>(
  ForgotPasswordNotifier.new,
);
