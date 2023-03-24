import 'package:flutter/material.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/ui/features/profile/views/edit_profile/edit_profile_page.dart';
import 'package:flutter_base/ui/features/profile/views/profile_page.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake/fake_values.dart';
import '../../../helpers/pump_app.dart';
import '../../../ioc/locator_mock.dart';

class FakeUpdateUserInputModel extends Fake implements UpdateUserInputModel {}

void main() {
  setUpAll(() {
    configureMockDependencies();
    registerFallbackValue(FakeUpdateUserInputModel());
  });

  group(
    'Edit Profile Page Test',
    () {
      setUpAll(() {
        final userRepository = getIt<IUserRepository>();
        when(() => userRepository.getLoggedUser()).thenAnswer(
          (_) async => const User(email: '', name: '', verified: true),
        );
        when(() => userRepository.update(any())).thenAnswer(
          (_) async => const User(email: '', name: fakeName, verified: true),
        );
      });

      testWidgets(
        'When user change her name update profile data',
        (tester) async {
          await tester.pumpAppRoute('/profile/edit');
          expect(find.byType(EditProfilePage), findsOneWidget);

          final name = find.byKey(const Key('profile-name-text-field'));
          await tester.enterText(name, fakeName);
          await tester.pump();

          final button = find.byKey(const Key('profile-save-button'));
          await tester.tap(button);
          await tester.pumpAndSettle();

          expect(find.byType(ProfilePage), findsOneWidget);
          expect(find.text(fakeName), findsOneWidget);
        },
      );
    },
  );
}
