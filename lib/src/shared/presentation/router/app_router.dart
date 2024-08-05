import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/src/auth/presentation/pages/change_password_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/change_password_success_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/forgot_password_confirm_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/forgot_password_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/initial_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/login_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/sign_up_page.dart';
import 'package:flutter_base/src/auth/presentation/pages/verify_account_page.dart';
import 'package:flutter_base/src/posts/presentation/pages/detail_post_page.dart';
import 'package:flutter_base/src/posts/presentation/pages/post_page.dart';
import 'package:flutter_base/src/shared/presentation/i18n/locale_keys.g.dart';
import 'package:flutter_base/src/shared/presentation/pages/scaffold_with_navigation.dart';
import 'package:flutter_base/src/shared/presentation/router/guards/auth_guard.dart';
import 'package:flutter_base/src/shared/presentation/router/utils.dart';
import 'package:flutter_base/src/user/presentation/pages/edit_avatar_page.dart';
import 'package:flutter_base/src/user/presentation/pages/edit_profile_page.dart';
import 'package:flutter_base/src/user/presentation/pages/profile_page.dart';
import 'package:go_router/go_router.dart';

final _bottomBarItems = [
  ScaffoldWithNavigationItem(
    icon: Icons.list,
    rootRoutePath: '/home',
    text: LocaleKeys.bottom_bar_posts.tr(),
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'homeNav'),
  ),
  ScaffoldWithNavigationItem(
    icon: Icons.account_circle,
    rootRoutePath: '/profile',
    text: LocaleKeys.bottom_bar_profile.tr(),
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'profileNav'),
  ),
];

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (context, state) => const InitialPage()),
    // Auth routes
    GoRoute(path: '/login', builder: (context, state) => const LoginPage()),
    GoRoute(path: '/sign-up', builder: (context, state) => const SignUpPage()),
    GoRoute(
      path: '/verify-account',
      builder: (context, state) =>
          VerifyAccountPage(token: state.extra as String?),
    ),
    GoRoute(
      path: '/forgot-password',
      pageBuilder: (context, state) =>
          platformPage(const ForgotPasswordPage(), fullscreenDialog: true),
    ),
    GoRoute(
      path: '/forgot-password/confirm',
      pageBuilder: (context, state) {
        final data = state.extra;
        return platformPage(
          data is ForgotPasswordConfirmPageData
              ? ForgotPasswordConfirmPage(data: data)
              : const SizedBox(),
          fullscreenDialog: true,
        );
      },
    ),
    GoRoute(
      path: '/change-password',
      pageBuilder: (context, GoRouterState state) {
        final data = state.extra;
        return platformPage(
          data is ChangePasswordPageData
              ? ChangePasswordPage(data: data)
              : const SizedBox(),
          fullscreenDialog: true,
        );
      },
    ),
    GoRoute(
      path: '/change-password/success',
      pageBuilder: (context, GoRouterState state) => platformPage(
        const ChangePasswordSuccessPage(),
        fullscreenDialog: true,
      ),
    ),

    /// Application
    StatefulShellRoute.indexedStack(
      builder: (context, state, navigationShell) {
        return ScaffoldWithNavigation(
          tabItems: _bottomBarItems,
          navigationShell: navigationShell,
        );
      },
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          routes: [
            GoRoute(
              redirect: authGuard,
              path: '/home',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  fadeTransitionPage(state, const PostPage()),
              routes: [
                GoRoute(
                  path: ':id',
                  builder: (context, state) => DetailPostPage(
                    id: int.parse(state.pathParameters['id'] ?? ''),
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              redirect: authGuard,
              path: '/profile',
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  fadeTransitionPage(state, const ProfilePage()),
              routes: <RouteBase>[
                GoRoute(
                  path: 'edit',
                  builder: (BuildContext context, GoRouterState state) =>
                      const EditProfilePage(),
                ),
                GoRoute(
                  path: 'avatar',
                  parentNavigatorKey: rootNavigatorKey,
                  builder: (context, state) => EditAvatarPage(
                    avatar: (state.extra as EditAvatarPageData).avatar,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    ),
  ],
);
