import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/auth/domain/interfaces/i_token_repository.dart';
import 'package:flutter_base/ui/features/misc/views/main_page.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_base/user/domain/interfaces/i_user_repository.dart';
import 'package:flutter_base/user/domain/models/user.dart';
import 'package:flutter_base/user/presentation/pages/edit_profile_page.dart';
import 'package:flutter_base/user/presentation/pages/profile_page.dart';
import 'package:flutter_base/user/presentation/widgets/containers/profile_photo_action_sheet.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/fake/fake_values.dart';
import '../../../../helpers/pump_app.dart';
import '../../../../ioc/locator_mock.dart';

void main() {
  setUpAll(() {
    configureMockDependencies();
  });

  group(
    'Profile Page Test',
    () {
      late StreamController<String> controller;

      setUpAll(() {
        when(() => getIt<IUserRepository>().getLoggedUser()).thenAnswer(
          (_) async => const User(email: '', name: '', verified: true),
        );
        when(() => getIt<IAuthRepository>().logout()).thenAnswer((_) async {});
        controller = StreamController<String>();
        controller.add(fakeToken);
        when(() => getIt<ITokenRepository>().getTokenStream())
            .thenAnswer((_) => controller.stream);
        when(() => getIt<ITokenRepository>().clear()).thenAnswer((_) async {
          controller.add('');
        });
      });

      tearDownAll(() => controller.close());

      testWidgets(
        'When user enter in profile and tap logout app return main page',
        (tester) async {
          await tester.pumpAppRoute('/profile');
          expect(find.byType(ProfilePage), findsOneWidget);

          final button = find.byKey(const Key('logout-button'));
          await tester.tap(button);
          await tester.pumpAndSettle();

          expect(find.byType(MainPage), findsOneWidget);
          final user = getIt<ProviderContainer>().read(userProvider).userData;
          expect(user, isNull);
        },
      );

      testWidgets(
        'When user tap in edit profile go to edit profile page',
        (tester) async {
          await tester.pumpAppRoute('/profile');
          expect(find.byType(ProfilePage), findsOneWidget);

          final button = find.byKey(const Key('edit-profile-button'));
          await tester.tap(button);
          await tester.pumpAndSettle();

          expect(find.byType(EditProfilePage), findsOneWidget);
        },
      );

      testWidgets(
        'When user tap in profile image show bottom modal sheet with options',
        (tester) async {
          await tester.pumpAppRoute('/profile');
          expect(find.byType(ProfilePage), findsOneWidget);

          final avatar = find.byKey(const Key('profile-avatar'));
          await tester.tap(avatar);
          await tester.pumpAndSettle();

          expect(find.byType(ProfilePhotoActionSheet), findsOneWidget);
        },
      );
    },
  );
}
