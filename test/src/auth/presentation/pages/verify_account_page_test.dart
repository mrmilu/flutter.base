import 'package:flutter/foundation.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/src/posts/presentation/pages/post_page.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_deep_link_service.dart';
import 'package:flutter_base/src/shared/presentation/states/deep_link_controller.dart';
import 'package:flutter_base/src/user/domain/interfaces/i_user_repository.dart';
import 'package:flutter_base/src/user/domain/models/user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/expects.dart';
import '../../../../helpers/pump_app.dart';
import '../../../shared/ioc/locator_mock.dart';

void main() {
  setUpAll(() {
    configureMockDependencies();
  });

  group(
    'Verify Account Page Test',
    () {
      setUpAll(() {
        when(() => getIt<IUserRepository>().getLoggedUser()).thenAnswer(
          (_) async => const User(email: '', name: ''),
        );
      });

      testWidgets(
        'When user enter in page with verification token account is validated and can continue',
        (tester) async {
          await tester.pumpAppRoute('/verify-account');

          final button = find.byKey(const Key('verify-button'));
          expectButtonEnabled(tester, button, isEnabled: false);

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
          await tester.pumpAndSettle();

          expectButtonEnabled(tester, button, isEnabled: true);
          await tester.tap(button);
          await tester.pumpAndSettle();
          expect(find.byType(PostPage), findsOneWidget);
        },
      );
    },
  );
}
