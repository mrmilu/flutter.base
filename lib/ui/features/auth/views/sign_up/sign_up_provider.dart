import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_base/ui/features/auth/views/sign_up/view_models/sign_up_view_model.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SignUpProvider {
  late UserProvider _userProvider;
  late UiProvider _uiProvider;
  final _signUpUseCase = GetIt.I.get<SignUpUseCase>();

  SignUpProvider(AutoDisposeProviderRef ref) {
    _userProvider = ref.read(userProvider.notifier);
    _uiProvider = ref.read(uiProvider.notifier);
  }

  void signUp(SignUpModelForm formModel) async {
    formModel.form.markAllAsTouched();
    if (formModel.form.valid) {
      await _uiProvider.tryAction(
        () async {
          FocusManager.instance.primaryFocus?.unfocus();
          final input = SignUpUseCaseInput(
            email: formModel.model.email,
            password: formModel.model.password,
            name: formModel.model.name,
            provider: AuthProvider.email,
          );
          final user = await _signUpUseCase(input);
          _userProvider.setUserData(user.toViewModel());
          GetIt.I.get<GoRouter>().go('/home');
        },
        rethrowError: true,
      );
    }
  }
}

final signUpProvider =
    AutoDisposeProvider<SignUpProvider>((ref) => SignUpProvider(ref));
