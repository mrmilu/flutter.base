import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_base/ui/features/auth/views/login/view_models/basic_login_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LoginProvider {
  late UserProvider _userProvider;
  late UiProvider _uiProvider;
  final _loginUseCase = GetIt.I.get<LoginUseCase>();
  final _appRouter = GetIt.I.get<GoRouter>();

  LoginProvider(AutoDisposeProviderRef ref) {
    _userProvider = ref.read(userProvider.notifier);
    _uiProvider = ref.read(uiProvider.notifier);
  }

  void login(BasicLoginModelForm formModel) async {
    formModel.form.markAllAsTouched();
    if (formModel.form.valid) {
      _uiProvider.tryAction(() async {
        final input = LoginUseCaseInput(
          email: formModel.model.email.trim(),
          password: formModel.model.password.trim(),
          provider: AuthProvider.email,
        );
        FocusManager.instance.primaryFocus?.unfocus();
        final user = await _loginUseCase(input);
        _userProvider.setUserData(user.toViewModel());
        _appRouter.go('/home');
      });
    }
  }
}

final loginProvider =
    AutoDisposeProvider<LoginProvider>((ref) => LoginProvider(ref));
