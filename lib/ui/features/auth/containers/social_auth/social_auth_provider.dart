import 'package:flutter_base/core/auth/domain/models/auth_provider.dart';
import 'package:flutter_base/core/auth/domain/use_cases/login_use_case.dart';
import 'package:flutter_base/core/auth/domain/use_cases/sign_up_use_case.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/ui/view_models/user_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

class SocialAuthProvider {
  late UserProvider _userProvider;
  late UiProvider _uiProvider;
  final _loginUseCase = GetIt.I.get<LoginUseCase>();
  final _signUpUseCase = GetIt.I.get<SignUpUseCase>();
  final _appRouter = GetIt.I.get<GoRouter>();

  SocialAuthProvider(AutoDisposeProviderRef ref) {
    _userProvider = ref.read(userProvider.notifier);
    _uiProvider = ref.read(uiProvider.notifier);
  }

  void socialLogin(AuthProvider provider) async {
    _uiProvider.tryAction(() async {
      final input = LoginUseCaseInput(provider: provider);
      final user = await _loginUseCase(input);
      _userProvider.setUserData(user.toViewModel());
      _appRouter.go('/home');
    });
  }

  void socialSignUp(AuthProvider provider) async {
    _uiProvider.tryAction(() async {
      final input = SignUpUseCaseInput(provider: provider);
      final user = await _signUpUseCase(input);
      _userProvider.setUserData(user.toViewModel());
      _appRouter.go('/home');
    });
  }
}

final socialAuthProvider =
    AutoDisposeProvider<SocialAuthProvider>((ref) => SocialAuthProvider(ref));
