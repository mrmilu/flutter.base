import 'package:flutter/widgets.dart';
import 'package:flutter_base/src/auth/domain/use_cases/verify_account_use_case.dart';
import 'package:flutter_base/src/shared/application/ui_provider.dart';
import 'package:flutter_base/src/user/application/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

class VerifyAccountNotifier extends AutoDisposeNotifier<void> {
  final _verifyAccountUseCase = GetIt.I.get<VerifyAccountUseCase>();

  @override
  void build() {}

  void verifyAccount(String token) async {
    await ref.read(uiProvider.notifier).tryAction(
      () async {
        FocusManager.instance.primaryFocus?.unfocus();
        final input = VerifyAccountUseCaseInput(token: token);
        await _verifyAccountUseCase(input);
        ref.read(userProvider.notifier).setUserVerified();
      },
      rethrowError: true,
    );
  }
}

final verifyAccountProvider =
    AutoDisposeNotifierProvider<VerifyAccountNotifier, void>(
  VerifyAccountNotifier.new,
);
