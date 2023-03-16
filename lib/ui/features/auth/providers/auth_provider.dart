import 'dart:async';

import 'package:flutter_base/core/app/ioc/locator.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum AuthStatus {
  authenticated,
  unauthenticated,
}

class AuthNotifier extends StateNotifier<AuthStatus> {
  final ITokenRepository tokenRepository = getIt<ITokenRepository>();
  late StreamSubscription subscription;

  AuthNotifier() : super(AuthStatus.unauthenticated) {
    subscription = tokenRepository.getTokenStream().listen(checkState);
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
