import 'package:flutter/foundation.dart';
import 'package:flutter_base/common/interfaces/deep_link_service.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/ui/controllers/deep_link_controller.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';
import '../../../../ioc/locator_mock.dart';

void main() {
  setUpAll(() {
    configureMockDependencies();
  });

  group(
    'Verify Account Page Test',
    () {
      testWidgets(
        'When user is verified tap in continue go to home',
        (tester) async {
          await tester.pumpAppRoute('/verify-account');

          // Prepare use case context
          when(() => getIt<IUserRepository>().getLoggedUser()).thenAnswer(
            (_) async => const User(email: '', name: '', verified: true),
          );
          await getIt<ProviderContainer>()
              .read(userProvider.notifier)
              .getInitialUserData();
          await tester.pump();

          final button = find.byKey(const Key('verify-button'));
          await tester.tap(button);
          await tester.pumpAndSettle();
          expect(getIt<GoRouter>().location, '/home');
        },
      );

      testWidgets(
        'When user enter in page with verification token account is validated and can continue',
        (tester) async {
          await tester.pumpAppRoute('/verify-account');

          // Prepare use case context
          when(() => getIt<IUserRepository>().getLoggedUser()).thenAnswer(
            (_) async => const User(email: '', name: ''),
          );
          await getIt<ProviderContainer>()
              .read(userProvider.notifier)
              .getInitialUserData();
          await tester.pumpAndSettle();

          when(() => getIt<IAuthRepository>().verifyAccount(any()))
              .thenAnswer((_) async {});
          final deeplinkService = getIt<IDeepLinkService>();
          when(() => deeplinkService.onLink())
              .thenAnswer((_) => const Stream.empty());
          final uri =
              Uri.parse('https://mrmilu.com?type=verify-account&key=key');
          when(() => deeplinkService.getInitialLink())
              .thenAnswer((_) async => uri);

          getIt<DeepLinkController>()();
          await tester.pumpAndSettle();

          final button = find.byKey(const Key('verify-button'));
          await tester.tap(button);
          await tester.pumpAndSettle();
          expect(getIt<GoRouter>().location, '/home');
        },
      );
    },
  );
}
