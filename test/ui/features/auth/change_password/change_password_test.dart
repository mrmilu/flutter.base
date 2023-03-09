import 'package:flutter/foundation.dart';
import 'package:flutter_base/core/app/domain/models/app_error.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/models/change_password_input_model.dart';
import 'package:flutter_base/ui/features/auth/views/change_password/change_password_page.dart';
import 'package:flutter_base/ui/features/auth/views/change_password/change_password_success_page.dart';
import 'package:flutter_base/ui/features/auth/views/login/login_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/expects.dart';
import '../../../../helpers/fake/fake_values.dart';
import '../../../../helpers/pump_app.dart';
import '../../../../ioc/locator_mock.dart';

class FakeChangePasswordInputModel extends Fake
    implements ChangePasswordInputModel {}

void main() {
  setUpAll(() {
    configureMockDependencies();
    registerFallbackValue(FakeChangePasswordInputModel());
  });

  group(
    'Change Password Page Test',
    () {
      testWidgets(
        'When user not enter data or invalid data button is disabled',
        (tester) async {
          await tester.pumpAppRoute(
            '/change-password',
            extra: const ChangePasswordPageData(token: 'token', uid: 'uid'),
          );

          // Empty data
          final button = find.byKey(const Key('change-password-button'));
          expectButtonEnabled(tester, button, isEnabled: false);

          // Repeated invalid passwords
          await _enterPasswords(
            tester,
            invalidPasswordString,
            invalidPasswordString,
          );
          expectButtonEnabled(tester, button, isEnabled: false);

          // Different valid passwords
          await _enterPasswords(tester, passwordString, '${passwordString}2');
          expectButtonEnabled(tester, button, isEnabled: false);
        },
      );

      testWidgets(
        'When user enter valid data and tap button complete action',
        (tester) async {
          await tester.pumpAppRoute(
            '/change-password',
            extra: const ChangePasswordPageData(token: 'token', uid: 'uid'),
          );

          when(() => getIt<IAuthRepository>().changePassword(any()))
              .thenAnswer((_) async {});

          final button = find.byKey(const Key('change-password-button'));
          await _enterPasswords(tester, passwordString, passwordString);
          await tester.tap(button);
          await tester.pumpAndSettle();

          expect(find.byType(ChangePasswordSuccessPage), findsOneWidget);

          final successButton =
              find.byKey(const Key('change-password-success-button'));
          await tester.tap(successButton);
          await tester.pumpAndSettle();

          expect(find.byType(LoginPage), findsOneWidget);
        },
      );

      testWidgets(
        'When back return error show snack bar with message',
        (tester) async {
          await tester.pumpAppRoute(
            '/change-password',
            extra: const ChangePasswordPageData(token: 'token', uid: 'uid'),
          );

          when(() => getIt<IAuthRepository>().changePassword(any()))
              .thenThrow(const AppError(message: 'Invalid password'));

          final button = find.byKey(const Key('change-password-button'));
          await _enterPasswords(tester, passwordString, passwordString);
          await tester.tap(button);
          await tester.pumpAndSettle();

          expectSnackBarWithMessage('Invalid password');
        },
      );
    },
  );
}

Future<void> _enterPasswords(
  WidgetTester tester,
  String pass1String,
  String pass2String,
) async {
  final pass1 = find.byKey(const Key('change-password-pass1'));
  await tester.enterText(pass1, pass1String);
  final pass2 = find.byKey(const Key('change-password-pass2'));
  await tester.enterText(pass2, pass2String);
  await tester.pump();
}
