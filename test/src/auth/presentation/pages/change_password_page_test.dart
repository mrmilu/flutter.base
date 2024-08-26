import 'package:flutter/foundation.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/src/auth/domain/models/change_password_input_model.dart';
import 'package:flutter_base/src/auth/presentation/pages/change_password_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/change_password_success_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/login_page.dart';
import 'package:flutter_base/src/shared/domain/models/app_error.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/expects.dart';
import '../../../../helpers/fake/fake_values.dart';
import '../../../../helpers/pump_app.dart';
import '../../../shared/ioc/locator_mock.dart';

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
        'When user enter valid data and tap button complete action',
        (tester) async {
          await tester.pumpAppRoute(
            '/change-password',
            extra: const ChangePasswordPageData(token: 'token', uid: 'uid'),
          );
          await tester.pumpAndSettle();

          when(() => getIt<IAuthRepository>().changePassword(any()))
              .thenAnswer((_) async {});

          final button = find.byKey(const Key('change-password-button'));
          final password = fakePassword;
          await _enterPasswords(tester, password, password);
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
          final password = fakePassword;
          await _enterPasswords(tester, password, password);
          await tester.tap(button);
          await tester.pumpAndSettle();

          expectSnackBar();
        },
      );

      testWidgets(
        'When user not enter data or invalid data button is disabled',
        (tester) async {
          await tester.pumpAppRoute(
            '/change-password',
            extra: const ChangePasswordPageData(token: 'token', uid: 'uid'),
          );

          // Empty data
          final button = find.byKey(const Key('change-password-button'));
          await _enterPasswords(tester, '', '');
          expectButtonEnabled(tester, button, isEnabled: false);

          // Repeated invalid passwords
          await _enterPasswords(
            tester,
            fakeInvalidPassword,
            fakeInvalidPassword,
          );
          expectButtonEnabled(tester, button, isEnabled: false);

          // Different valid passwords

          await _enterPasswords(tester, fakePassword, '${fakePassword}2');
          expectButtonEnabled(tester, button, isEnabled: false);
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
