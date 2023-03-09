import 'package:flutter/material.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/ui/features/misc/views/main_page.dart';
import 'package:flutter_base/ui/features/profile/views/profile_page.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/pump_app.dart';
import '../../../ioc/locator_mock.dart';

void main() {
  setUpAll(() {
    configureMockDependencies();
  });

  group(
    'Profile Page Test',
    () {
      setUpAll(() {
        when(() => getIt<IUserRepository>().getLoggedUser()).thenAnswer(
          (_) async => const User(email: '', name: '', verified: true),
        );
        when(() => getIt<IAuthRepository>().logout()).thenAnswer((_) async {});
        when(() => getIt<ITokenRepository>().clear()).thenAnswer((_) async {});
      });

      testWidgets(
        'When user enter in profile and tap logout app return main page',
        (tester) async {
          await tester.pumpAppRoute(null);

          await getIt<ProviderContainer>()
              .read(userProvider.notifier)
              .getInitialUserData();
          getIt<GoRouter>().go('/profile');
          await tester.pumpAndSettle();

          expect(find.byType(ProfilePage), findsOneWidget);

          final button = find.byKey(const Key('logout-button'));
          await tester.tap(button);
          await tester.pumpAndSettle();

          expect(find.byType(MainPage), findsOneWidget);
          final user = getIt<ProviderContainer>().read(userProvider).userData;
          expect(user, isNull);
        },
      );
    },
  );
}
