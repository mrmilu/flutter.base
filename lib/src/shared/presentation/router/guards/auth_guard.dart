import 'package:flutter/cupertino.dart';
import 'package:go_router/go_router.dart';

String? authGuard(BuildContext context, GoRouterState state) {
  return null;

  // final providerContainer = GetIt.I.get<ProviderContainer>();
  // final user = providerContainer.read(userProvider).userData;
  // final cats = providerContainer.read(userProvider).cats;
  // if (user != null && user.verified && cats.isNotEmpty) {
  //   return null;
  // } else if (user != null && user.verified && cats.isEmpty) {
  //   return '/onboarding/cats-amount';
  // } else if (user != null && !user.verified) {
  //   return '/onboarding/verify-account';
  // } else {
  //   return '/';
  // }
}
