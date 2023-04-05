import 'package:flutter/material.dart';
import 'package:flutter_base/ui/features/auth/views/change_password/change_password_page.dart';
import 'package:flutter_base/ui/features/auth/views/change_password/change_password_success_page.dart';
import 'package:flutter_base/ui/features/auth/views/forgot_password/forgot_password_confirm_page.dart';
import 'package:flutter_base/ui/features/auth/views/forgot_password/forgot_password_page.dart';
import 'package:flutter_base/ui/features/auth/views/login/login_page.dart';
import 'package:flutter_base/ui/features/auth/views/sign_up/sign_up_page.dart';
import 'package:flutter_base/ui/features/auth/views/verify_account/verify_account_page.dart';
import 'package:flutter_base/ui/features/misc/components/scaffold_with_nav_bar.dart';
import 'package:flutter_base/ui/features/misc/views/main_page.dart';
import 'package:flutter_base/ui/features/post/views/detail_post_page/detail_post_page.dart';
import 'package:flutter_base/ui/features/post/views/posts/post_page.dart';
import 'package:flutter_base/ui/features/profile/views/edit_avatar/edit_avatar_page.dart';
import 'package:flutter_base/ui/features/profile/views/edit_profile/edit_profile_page.dart';
import 'package:flutter_base/ui/features/profile/views/profile_page.dart';
import 'package:flutter_base/ui/router/bottom_tab_bar_shell_route.dart';
import 'package:flutter_base/ui/router/guards/auth_guard.dart';
import 'package:flutter_base/ui/router/utils.dart';
import 'package:go_router/go_router.dart';

final _bottomBarItems = [
  ScaffoldWithNavBarTabItem(
    icon: Icons.list,
    rootRoutePath: '/home',
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'homeNav'),
  ),
  ScaffoldWithNavBarTabItem(
    icon: Icons.account_circle,
    rootRoutePath: '/profile',
    navigatorKey: GlobalKey<NavigatorState>(debugLabel: 'profileNav'),
  ),
];

final GlobalKey<NavigatorState> rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _appShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'appShell');

final GoRouter router = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(path: '/', builder: (context, state) => const MainPage()),
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
      pageBuilder: (context, state) => platformPage(
        ForgotPasswordConfirmPage(
          data: state.extra as ForgotPasswordConfirmPageData,
        ),
        fullscreenDialog: true,
      ),
    ),
    GoRoute(
      path: '/change-password',
      pageBuilder: (context, GoRouterState state) => platformPage(
        ChangePasswordPage(data: state.extra as ChangePasswordPageData),
        fullscreenDialog: true,
      ),
    ),
    GoRoute(
      path: '/change-password/success',
      pageBuilder: (context, GoRouterState state) => platformPage(
        const ChangePasswordSuccessPage(),
        fullscreenDialog: true,
      ),
    ),

    /// Application
    BottomTabBarShellRoute(
      tabs: _bottomBarItems,
      navigatorKey: _appShellNavigatorKey,
      routes: <RouteBase>[
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
        GoRoute(
          redirect: authGuard,
          path: '/home',
          pageBuilder: (BuildContext context, GoRouterState state) =>
              fadeTransitionPage(state, const PostPage()),
          routes: [
            GoRoute(
              path: ':id',
              builder: (context, state) =>
                  DetailPostPage(id: int.parse(state.params['id'] ?? '')),
            ),
          ],
        ),
      ],
    ),
  ],
);
