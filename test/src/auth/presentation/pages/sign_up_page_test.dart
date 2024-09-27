// ignore_for_file: avoid_annotating_with_dynamic

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_token_repository.dart';
import 'package:flutter_base/src/auth/domain/models/sign_up_input_model.dart';
import 'package:flutter_base/src/auth/domain/models/token_model.dart';
import 'package:flutter_base/src/auth/presentation/pages/verify_account_page.dart';
import 'package:flutter_base/src/notifications/domain/interfaces/i_notifications_service.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/user/domain/interfaces/i_user_repository.dart';
import 'package:flutter_base/src/user/domain/models/user.dart';
import 'package:flutter_base/src/user/presentation/states/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/expects.dart';
import '../../../../helpers/fake/fake_values.dart';
import '../../../../helpers/pump_app.dart';
import '../../../shared/ioc/locator_mock.dart';

class FakeSignUpInputModel extends Fake implements SignUpInputModel {}

void main() {
  setUpAll(() {
    configureMockDependencies();
    registerFallbackValue(FakeSignUpInputModel());
    registerFallbackValue(TokenModel());
  });

  group('Signup Page Tests', () {
    setUpAll(() {
      final tokenRepo = getIt<ITokenRepository>();
      when(() => tokenRepo.update(any())).thenAnswer((_) => Future.value());
      final notificationService = getIt<INotificationsService>();
      when(() => notificationService.getToken()).thenAnswer((_) async => null);
      final userRepo = getIt<IUserRepository>();
      when(() => userRepo.getLoggedUser()).thenAnswer(
        (_) async => const User(email: '', name: ''),
      );
    });

    testWidgets(
      'When not enter required sign up data button is disable',
      (tester) async {
        await tester.pumpAppRoute('/sign-up');

        await _enterSignUpData(tester);
        _checkRegisterButtonEnabled(tester, true);

        await _enterName(tester, '');
        await tester.pumpAndSettle();
        _checkRegisterButtonEnabled(tester, false);

        await _enterSignUpData(tester);
        _checkRegisterButtonEnabled(tester, true);

        await _enterEmail(tester, '');
        await tester.pumpAndSettle();
        _checkRegisterButtonEnabled(tester, false);
        await _enterEmail(tester, fakeInvalidEmail);
        await tester.pumpAndSettle();
        _checkRegisterButtonEnabled(tester, false);

        await _enterSignUpData(tester);
        _checkRegisterButtonEnabled(tester, true);

        await _enterPassword(tester, '');
        await tester.pumpAndSettle();
        _checkRegisterButtonEnabled(tester, false);
        await _enterPassword(tester, fakeInvalidPassword);
        await tester.pumpAndSettle();
        _checkRegisterButtonEnabled(tester, false);
      },
    );

    testWidgets(
      'When enter valid data user is registered in app',
      (tester) async {
        await tester.pumpAppRoute('/sign-up');

        final authRepo = getIt<IAuthRepository>();
        when(() => authRepo.signUp(any())).thenAnswer((_) async => 'token');

        await _enterSignUpData(tester);
        await _tapRegisterButton(tester);

        final container = getIt<ProviderContainer>();
        expect(container.read(userProvider).userData, isNotNull);
        expect(find.text(LocaleKeys.verifyAccount_title.tr()), findsOneWidget);
        expect(find.byType(VerifyAccountPage), findsOneWidget);
      },
    );

    testWidgets(
      'When server returns error show error message',
      (tester) async {
        await tester.pumpAppRoute('/sign-up');

        final authRepo = getIt<IAuthRepository>();
        when(() => authRepo.signUp(any()))
            .thenThrow(const AppError(message: 'Sign up error'));

        await _enterSignUpData(tester);
        await _tapRegisterButton(tester);

        expectSnackBarWithMessage('Sign up error');
      },
    );
  });
}

void _checkRegisterButtonEnabled(WidgetTester tester, bool isEnabled) {
  final button = find.byKey(const Key('sign_up_button'));
  expectButtonEnabled(tester, button, isEnabled: isEnabled);
}

Future<void> _tapRegisterButton(WidgetTester tester) async {
  final signUpButton = find.byKey(const Key('sign_up_button'));
  await tester.tap(signUpButton);
  await tester.pumpAndSettle();
}

Future<void> _enterSignUpData(WidgetTester tester) async {
  await _enterName(tester, fakeName);
  await _enterEmail(tester, fakeEmail);
  await _enterPassword(tester, fakePassword);
  await tester.pump();
}

Future<void> _enterName(WidgetTester tester, String name) async {
  final finder = find.byKey(const Key('sign_up_name'));
  await tester.enterText(finder, name);
}

Future<void> _enterEmail(WidgetTester tester, String email) async {
  final finder = find.byKey(const Key('sign_up_email'));
  await tester.enterText(finder, email);
}

Future<void> _enterPassword(WidgetTester tester, String password) async {
  final finder = find.byKey(const Key('sign_up_pass'));
  await tester.enterText(finder, password);
}
