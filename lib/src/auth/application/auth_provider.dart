import 'dart:async';

import 'package:flutter_base/src/auth/domain/use_cases/get_token_stream_use_case.dart';
import 'package:flutter_base/src/shared/ioc/locator.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

class AuthNotifier extends StateNotifier<AuthStatus> {
  final tokenStreamUseCase = getIt<GetTokenStreamUseCase>();
  late StreamSubscription subscription;

  AuthNotifier() : super(AuthStatus.unauthenticated) {
    subscription = tokenStreamUseCase().listen(checkState);
  }

  void checkState(String token) {
    token.isNotEmpty
        ? state = AuthStatus.authenticated
        : state = AuthStatus.unauthenticated;
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthStatus>(
  (ref) => AuthNotifier(),
);
