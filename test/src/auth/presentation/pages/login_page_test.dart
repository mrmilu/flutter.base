import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_token_repository.dart';
import 'package:flutter_base/src/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/src/auth/domain/models/token_model.dart';
import 'package:flutter_base/src/posts/presentation/pages/post_page.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_notifications_service.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:flutter_base/src/user/application/user_provider.dart';
import 'package:flutter_base/src/user/domain/interfaces/i_user_repository.dart';
import 'package:flutter_base/src/user/domain/models/user.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/expects.dart';
import '../../../../helpers/fake/fake_values.dart';
import '../../../../helpers/pump_app.dart';
import '../../../shared/ioc/locator_mock.dart';

class FakeLoginInputModel extends Fake implements LoginInputModel {}

void main() {
  setUpAll(() {
    configureMockDependencies();
    registerFallbackValue(FakeLoginInputModel());
    registerFallbackValue(TokenModel());
  });

  group('Login Page Tests', () {
    setUpAll(() {
      final tokenRepo = getIt<ITokenRepository>();
      when(() => tokenRepo.update(any())).thenAnswer((_) => Future.value());
      final notificationService = getIt<INotificationsService>();
      when(() => notificationService.getToken()).thenAnswer((_) async => null);
    });

    tearDown(() => getIt<ProviderContainer>().refresh(userProvider));

    testWidgets(
      'When enter valid credentials user enter in app',
      (tester) async {
        await tester.pumpAppRoute('/login');

        when(() => getIt<IAuthRepository>().login(any())).thenAnswer(
          (_) async => 'token',
        );
        when(() => getIt<IUserRepository>().getLoggedUser()).thenAnswer(
          (_) async => const User(email: '', name: '', verified: true),
        );

        await _enterLoginCredentials(tester);
        await _tapLoginButton(tester);
        await tester.pump(const Duration(seconds: 2));

        final container = getIt<ProviderContainer>();
        expect(container.read(userProvider).userData, isNotNull);
        expect(find.byType(PostPage), findsOneWidget);
      },
    );

    testWidgets(
      'When enter invalid credentials show error message',
      (tester) async {
        await tester.pumpAppRoute('/login');

        final authRepo = getIt<IAuthRepository>();
        when(() => authRepo.login(any()))
            .thenThrow(const AppError(message: 'Bad credentials'));

        await _enterLoginCredentials(tester);
        await _tapLoginButton(tester);

        expectSnackBarWithMessage('Bad credentials');
      },
    );
  });
}

Future<void> _tapLoginButton(WidgetTester tester) async {
  final signInButton = find.byKey(const Key('sing_in_button'));
  await tester.tap(signInButton);
  await tester.pumpAndSettle();
}

Future<void> _enterLoginCredentials(WidgetTester tester) async {
  final email = find.byKey(const Key('sing_in_email'));
  final pass = find.byKey(const Key('sing_in_pass'));
  await tester.enterText(email, fakeEmail);
  await tester.enterText(pass, fakePassword);
  await tester.pump();
}
