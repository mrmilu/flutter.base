import 'dart:async';

import 'package:flutter_base/src/user/application/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';

FutureOr<String?> authGuard(_, __) {
  final providerContainer = GetIt.I.get<ProviderContainer>();
  final user = providerContainer.read(userProvider).userData;
  if (user != null) {
    return user.verified ? null : '/verify-account';
  }
  return '/initial';
}
