import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
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

  group('Verify Account Page Test', () {
    testWidgets(
      'When user is verified tap in continue go to home',
      (tester) async {
        await tester.pumpAppRoute('/verify-account');
        expect(find.text(LocaleKeys.verifyAccount_title.tr()), findsOneWidget);

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
  });
}
