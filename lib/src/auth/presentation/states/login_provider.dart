import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/auth/application/use_cases/login_use_case.dart';
import 'package:flutter_base/src/auth/presentation/view_models/basic_login_view_model.dart';
import 'package:flutter_base/src/shared/domain/models/device_type.dart';
import 'package:flutter_base/src/shared/presentation/states/ui_provider.dart';
import 'package:flutter_base/src/user/presentation/states/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class LoginNotifier extends AutoDisposeNotifier<BasicLoginModelForm> {
  final _loginUseCase = GetIt.I.get<LoginUseCase>();
  final _appRouter = GetIt.I.get<GoRouter>();

  @override
  BasicLoginModelForm build() {
    return BasicLoginViewModel().generateFormModel;
  }

  void login() async {
    final userNotifier = ref.read(userProvider.notifier);
    final uiNotifier = ref.read(uiProvider.notifier);
    state.form.markAllAsTouched();
    if (state.form.valid) {
      uiNotifier.tryAction(() async {
        final input = LoginUseCaseInput(
          email: state.model.email.trim(),
          password: state.model.password.trim(),
          userDeviceType: DeviceType.deviceType,
        );
        FocusManager.instance.primaryFocus?.unfocus();
        final user = await _loginUseCase(input);
        userNotifier.setUserData(user);
        _appRouter.go('/home');
      });
    }
  }
}

final loginProvider =
    AutoDisposeNotifierProvider<LoginNotifier, BasicLoginModelForm>(
  LoginNotifier.new,
);
