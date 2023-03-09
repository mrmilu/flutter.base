import 'package:flutter/material.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_base/ui/components/buttons/icon_button_primary.dart';
import 'package:flutter_base/ui/features/post/views/posts/post_page.dart';
import 'package:flutter_base/ui/features/post/views/posts/providers/post_page_provider.dart';
import 'package:flutter_base/ui/providers/user_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../helpers/pump_app.dart';
import '../../../../ioc/locator_mock.dart';

void main() {
  setUpAll(() {
    configureMockDependencies();
  });

  group(
    'Post Page Test',
    () {
      setUpAll(() {
        when(() => getIt<IUserRepository>().getLoggedUser()).thenAnswer(
          (_) async => const User(email: '', name: '', verified: true),
        );
      });

      testWidgets(
        'When user enter in app logged show post list and he can make scroll',
        (tester) async {
          final handle = tester.ensureSemantics();

          await tester.pumpAppRoute(null);

          await getIt<ProviderContainer>()
              .read(userProvider.notifier)
              .getInitialUserData();
          getIt<GoRouter>().go('/home');
          await tester.pumpAndSettle();

          expect(find.byType(PostPage), findsOneWidget);

          final listView = find.byType(ListView);
          expect(listView, findsOneWidget);

          await tester.drag(listView, const Offset(0, 500));
          await tester.pump();

          expect(
            tester.getSemantics(find.byType(RefreshProgressIndicator)),
            matchesSemantics(label: 'Refresh'),
          );

          final ScrollableState state = tester.state(find.byType(Scrollable));
          state.position.jumpTo(state.position.maxScrollExtent);

          handle.dispose();
        },
      );

      testWidgets(
        'When user delete list item, item disappears',
        (tester) async {
          await tester.pumpAppRoute(null);

          await getIt<ProviderContainer>()
              .read(userProvider.notifier)
              .getInitialUserData();
          getIt<GoRouter>().go('/home');
          await tester.pumpAndSettle();

          expect(find.byType(PostPage), findsOneWidget);

          final container = getIt<ProviderContainer>();
          final previousCount = container.read(postPageProvider).value!.length;

          final firstItemButton = find.byType(IconButtonPrimary).first;
          await tester.tap(firstItemButton);
          await tester.pumpAndSettle(const Duration(seconds: 2));
          final currentCount = container.read(postPageProvider).value!.length;

          expect(currentCount, previousCount - 1);
        },
      );
    },
  );
}
