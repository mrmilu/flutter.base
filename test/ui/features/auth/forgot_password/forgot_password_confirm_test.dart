import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/common/interfaces/deep_link_service.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/ui/controllers/deep_link_controller.dart';
import 'package:flutter_base/ui/features/auth/views/change_password/change_password_page.dart';
import 'package:flutter_base/ui/features/auth/views/forgot_password/forgot_password_confirm_page.dart';
import 'package:flutter_base/ui/i18n/locale_keys.g.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/expects.dart';
import '../../../../helpers/fake/fake_values.dart';
import '../../../../helpers/pump_app.dart';
import '../../../../ioc/locator_mock.dart';

void main() {
  setUpAll(() {
    configureMockDependencies();
  });

  group('Forgot Password Confirm Page Test', () {
    testWidgets(
      'When user go to confirm page from forgot password page can`t continue',
      (tester) async {
        await tester.pumpAppRoute(
          '/forgot-password/confirm',
          extra: ForgotPasswordConfirmPageData(email: fakeEmail),
        );
        expect(find.byType(ForgotPasswordConfirmPage), findsOneWidget);
        final button = find.byKey(const Key('forgot-pass-confirm-button'));
        expectButtonEnabled(tester, button, isEnabled: false);

        when(() => getIt<IAuthRepository>().resendPasswordResetEmail(any()))
            .thenAnswer((_) async {});
        final resendButton =
            find.byKey(const Key('forgot-pass-confirm-resend-button'));
        await tester.tap(resendButton);
        await tester.pumpAndSettle();

        expect(
          find.text(LocaleKeys.forgotPasswordConfirm_resendTitle.tr()),
          findsOneWidget,
        );
      },
    );

    testWidgets(
      'When user go to confirm page from deeplink can continue to change password page',
      (tester) async {
        await tester.pumpAppRoute('/forgot-password');

        final deeplinkService = getIt<IDeepLinkService>();
        when(() => deeplinkService.onLink())
            .thenAnswer((_) => const Stream.empty());
        final uri =
            Uri.parse('https://mrmilu.com?type=reset-password&key=key&uid=uid');
        when(() => deeplinkService.getInitialLink())
            .thenAnswer((_) async => uri);

        getIt<DeepLinkController>()();
        await tester.pumpAndSettle();

        expect(find.byType(ForgotPasswordConfirmPage), findsOneWidget);

        final button = find.byKey(const Key('forgot-pass-confirm-button'));
        await tester.tap(button);
        await tester.pumpAndSettle();

        expect(find.byType(ChangePasswordPage), findsOneWidget);
      },
    );
  });
}
