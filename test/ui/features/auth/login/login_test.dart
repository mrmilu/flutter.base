import 'package:flutter/material.dart';
import 'package:flutter_base/ui/features/auth/views/login/login_page.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';

import '../../../../helpers/pump_app.dart';

const emailString = 'test@test.com';
const passwordString = 'password';

void main() {
  group('Login Page Widget Tests', () {
    testWidgets(
      'When enter valid credentials user enter in app',
      (tester) async {
        await tester.pumpApp(const LoginPage());

        // Find textFields
        final email = find.byKey(const Key('sing_in_email'));
        final pass = find.byKey(const Key('sing_in_pass'));
        expect(email, findsOneWidget);
        expect(pass, findsOneWidget);

        // Enter text
        await tester.enterText(email, emailString);
        await tester.enterText(pass, passwordString);
        await tester.pumpAndSettle();
        expect(find.text(emailString), findsOneWidget);
        expect(find.text(passwordString), findsOneWidget);

        // Tap sign in
        final signInButton = find.byKey(const Key('sing_in_button'));
        await tester.tap(signInButton);
        await tester.pumpAndSettle();

        // Check if user logged
        final container = GetIt.I.get<ProviderContainer>();
        expect(container.read(userProvider).userData, isNotNull);
      },
    );

    testWidgets(
      'When enter invalid credentials show error message',
          (tester) async {
        // FIXME this test cannot be done because we have no control over the mocked data
      },
    );
  });
}
