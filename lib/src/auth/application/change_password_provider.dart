import 'package:flutter_base/src/auth/domain/use_cases/change_password_use_case.dart';
import 'package:flutter_base/src/auth/presentation/view_models/change_password_view_model.dart';
import 'package:flutter_base/src/shared/application/ui_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ChangePasswordNotifier
    extends AutoDisposeNotifier<ChangePasswordModelForm> {
  final _changePasswordUseCase = GetIt.I.get<ChangePasswordUseCase>();
  final _appRouter = GetIt.I.get<GoRouter>();

  @override
  ChangePasswordModelForm build() {
    return ChangePasswordViewModel().formModel;
  }

  void changePassword({
    required String token,
    required String uid,
  }) async {
    state.form.markAllAsTouched();
    if (state.form.valid) {
      ref.read(uiProvider.notifier).tryAction(() async {
        FocusManager.instance.primaryFocus?.unfocus();
        final input = ChangePasswordUseCaseInput(
          uid: uid,
          token: token,
          password: state.model.password.trim(),
          repeatPassword: state.model.repeatPassword.trim(),
        );
        await _changePasswordUseCase(input);
        _appRouter.push('/change-password/success');
      });
    }
  }
}

final changePasswordProvider = AutoDisposeNotifierProvider<
    ChangePasswordNotifier, ChangePasswordModelForm>(
  ChangePasswordNotifier.new,
);
