import 'package:flutter_base/core/auth/domain/use_cases/change_password_use_case.dart';
import 'package:flutter_base/ui/features/auth/views/change_password/view_models/change_password_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms_annotations/reactive_forms_annotations.dart';

class ChangePasswordProvider {
  final _changePasswordUseCase = GetIt.I.get<ChangePasswordUseCase>();
  late UiNotifier _uiProvider;
  final _appRouter = GetIt.I.get<GoRouter>();

  ChangePasswordProvider(AutoDisposeProviderRef ref) {
    _uiProvider = ref.watch(uiProvider.notifier);
  }

  void changePassword(
    ChangePasswordModelForm formModel, {
    required String token,
    required String uid,
  }) async {
    formModel.form.markAllAsTouched();
    if (formModel.form.valid) {
      _uiProvider.tryAction(() async {
        FocusManager.instance.primaryFocus?.unfocus();
        final input = ChangePasswordUseCaseInput(
          uid: uid,
          token: token,
          password: formModel.model.password.trim(),
          repeatPassword: formModel.model.repeatPassword.trim(),
        );
        await _changePasswordUseCase(input);
        _appRouter.push('/change-password/success');
      });
    }
  }
}

final changePasswordProvider =
    AutoDisposeProvider((ref) => ChangePasswordProvider(ref));
