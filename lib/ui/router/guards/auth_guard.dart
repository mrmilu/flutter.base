import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';

FutureOr<String?> authGuard(BuildContext context, GoRouterState state) {
  final providerContainer = GetIt.I.get<ProviderContainer>();
  final user = providerContainer.read(userProvider).userData;
  if (user != null && user.verified) {
    return null;
  } else if (user != null && !user.verified) {
    return '/verify-account';
  } else {
    return '/';
  }
}
