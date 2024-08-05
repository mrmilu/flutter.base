import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/src/auth/presentation/pages/forgot_password_confirm_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/forgot_password_page.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/expects.dart';
import '../../../../helpers/fake/fake_values.dart';
import '../../../../helpers/pump_app.dart';
import '../../../shared/ioc/locator_mock.dart';

void main() {
  setUpAll(() {
    configureMockDependencies();
  });

  group('Forgot Password Page Test', () {
    testWidgets(
      'When user enter valid email navigate con confirm page',
      (tester) async {
        await tester.pumpAppRoute('/forgot-password');

        final button = find.byKey(const Key('forgot-password-button'));
        expectButtonEnabled(tester, button, isEnabled: false);

        when(() => getIt<IAuthRepository>().requestResetPassword(any()))
            .thenAnswer((_) async {});

        final email = find.byKey(const Key('forgot-password-email'));
        await tester.enterText(email, fakeEmail);
        await tester.pumpAndSettle();
        await tester.tap(button);
        await tester.pumpAndSettle();
        expect(find.byType(ForgotPasswordConfirmPage), findsOneWidget);
      },
    );

    testWidgets(
      'When user enter invalid email show snackbar error',
      (tester) async {
        await tester.pumpAppRoute('/forgot-password');
        expect(find.byType(ForgotPasswordPage), findsOneWidget);

        when(() => getIt<IAuthRepository>().requestResetPassword(any()))
            .thenThrow(const AppError(message: 'Email not exist'));

        final email = find.byKey(const Key('forgot-password-email'));
        await tester.enterText(email, fakeEmail);
        await tester.pumpAndSettle();
        final button = find.byKey(const Key('forgot-password-button'));
        await tester.tap(button);
        await tester.pumpAndSettle();
        expectSnackBar();
        await tester.pumpAppRoute('/login');
      },
    );
  });
}
