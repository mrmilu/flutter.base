import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_base/ui/features/auth/views/sign_up/view_models/sign_up_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SignUpProvider extends AutoDisposeNotifier<SignUpModelForm> {
  final _signUpUseCase = GetIt.I.get<SignUpUseCase>();

  @override
  SignUpModelForm build() {
    return SignUpViewModel().generateFormModel();
  }

  void signUp() async {
    final uiNotifier = ref.watch(uiProvider.notifier);
    final userNotifier = ref.watch(userProvider.notifier);

    state.form.markAllAsTouched();
    if (state.form.valid) {
      await uiNotifier.tryAction(
        () async {
          FocusManager.instance.primaryFocus?.unfocus();
          final input = SignUpUseCaseInput(
            email: state.model.email,
            password: state.model.password,
            name: state.model.name,
          );
          final user = await _signUpUseCase(input);
          userNotifier.setUserData(user.toViewModel());
          GetIt.I.get<GoRouter>().go('/home');
        },
      );
    }
  }
}

final signUpProvider =
    AutoDisposeNotifierProvider<SignUpProvider, SignUpModelForm>(
  SignUpProvider.new,
);
