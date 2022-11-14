import 'package:flutter/widgets.dart';
import 'package:flutter_base/core/auth/domain/use_cases/verify_account_use_case.dart';
import 'package:flutter_base/ui/providers/ui_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class VerifyAccountProvider {
  late UserProvider _userProvider;
  late UiProvider _uiProvider;
  final _verifyAccountUseCase = GetIt.I.get<VerifyAccountUseCase>();

  VerifyAccountProvider(AutoDisposeProviderRef ref) {
    _userProvider = ref.read(userProvider.notifier);
    _uiProvider = ref.read(uiProvider.notifier);
  }

  void verifyAccount(String token) async {
    await _uiProvider.tryAction(() async {
      FocusManager.instance.primaryFocus?.unfocus();
      final input = VerifyAccountUseCaseInput(token: token);
      await _verifyAccountUseCase(input);
      _userProvider.setUserVerified();
    }, rethrowError: true);
  }
}

final verifyAccountProvider = AutoDisposeProvider<VerifyAccountProvider>(
    (ref) => VerifyAccountProvider(ref));
