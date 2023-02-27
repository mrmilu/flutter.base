// ignore_for_file: avoid_annotating_with_dynamic

import 'package:flutter/material.dart';
import 'package:flutter_base/common/interfaces/notifications_service.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:flutter_base/core/app/ioc/locator.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/models/sign_up_input_model.dart';
import 'package:flutter_base/core/auth/domain/models/token_model.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/ui/components/buttons/button_primary.dart';
import 'package:flutter_base/ui/features/auth/views/sign_up/sign_up_page.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';

const nameString = 'Test User';
const emailString = 'test@test.com';
const passwordString = 'Password1';
const invalidEmailString = 'email';
const invalidPasswordString = 'password';

class FakeSignUpInputModel extends Fake implements SignUpInputModel {}

void main() {
  // Configure global dependency injection
  configureDependencies(env: Environments.test);

  setUpAll(() {
    registerFallbackValue(FakeSignUpInputModel());
    registerFallbackValue(TokenModel());
  });

  group('Sign Up Page Widget Tests', () {
    setUpAll(() {
      final tokenRepo = getIt<ITokenRepository>();
      when(() => tokenRepo.update(any())).thenAnswer((_) async {});
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
        await tester.pumpApp(const SignUpPage());

        await _enterSignUpData(tester);
        _checkRegisterButtonEnable(tester, isTrue);

        await _enterName(tester, '');
        await tester.pumpAndSettle();
        _checkRegisterButtonEnable(tester, isFalse);

        await _enterSignUpData(tester);
        _checkRegisterButtonEnable(tester, isTrue);

        await _enterEmail(tester, '');
        await tester.pumpAndSettle();
        _checkRegisterButtonEnable(tester, isFalse);
        await _enterEmail(tester, invalidEmailString);
        await tester.pumpAndSettle();
        _checkRegisterButtonEnable(tester, isFalse);

        await _enterSignUpData(tester);
        _checkRegisterButtonEnable(tester, isTrue);

        await _enterPassword(tester, '');
        await tester.pumpAndSettle();
        _checkRegisterButtonEnable(tester, isFalse);
        await _enterPassword(tester, invalidPasswordString);
        await tester.pumpAndSettle();
        _checkRegisterButtonEnable(tester, isFalse);
      },
    );

    testWidgets(
      'When enter valid data user is registered in app',
      (tester) async {
        await tester.pumpApp(const SignUpPage());

        final authRepo = getIt<IAuthRepository>();
        when(() => authRepo.signUp(any())).thenAnswer((_) async => 'token');

        await _enterSignUpData(tester);
        await _tapRegisterButton(tester);

        final container = getIt<ProviderContainer>();
        expect(container.read(userProvider).userData, isNotNull);
      },
    );

    testWidgets(
      'When server returns error show error message',
      (tester) async {
        await tester.pumpApp(const SignUpPage());

        final authRepo = getIt<IAuthRepository>();
        when(() => authRepo.signUp(any()))
            .thenThrow(const AppError(message: 'Sign up error'));

        await _enterSignUpData(tester);
        await _tapRegisterButton(tester);

        expect(find.byType(SnackBar), findsOneWidget);
        expect(find.text('Sign up error'), findsOneWidget);
      },
    );
  });
}

void _checkRegisterButtonEnable(WidgetTester tester, dynamic matcher) {
  final signUpButtonWidget =
      tester.widget<ButtonPrimary>(find.byKey(const Key('sing_up_button')));
  expect(signUpButtonWidget.enabled, matcher);
}

Future<void> _tapRegisterButton(WidgetTester tester) async {
  final signUpButton = find.byKey(const Key('sing_up_button'));
  await tester.tap(signUpButton);
  await tester.pumpAndSettle();
}

Future<void> _enterSignUpData(WidgetTester tester) async {
  await _enterName(tester, nameString);
  await _enterEmail(tester, emailString);
  await _enterPassword(tester, passwordString);
  await tester.pumpAndSettle();
}

Future<void> _enterName(WidgetTester tester, String name) async {
  final finder = find.byKey(const Key('sing_up_name'));
  await tester.enterText(finder, name);
}

Future<void> _enterEmail(WidgetTester tester, String email) async {
  final finder = find.byKey(const Key('sing_up_email'));
  await tester.enterText(finder, email);
}

Future<void> _enterPassword(WidgetTester tester, String password) async {
  final finder = find.byKey(const Key('sing_up_pass'));
  await tester.enterText(finder, password);
}
