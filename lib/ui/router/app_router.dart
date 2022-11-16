import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_base/ui/pages/auth/views/change_password/change_password_page.dart';
import 'package:flutter_base/ui/pages/auth/views/change_password/change_password_sucess_page.dart';
import 'package:flutter_base/ui/pages/auth/views/forgot_password/forgot_password_confirm_page.dart';
import 'package:flutter_base/ui/pages/auth/views/forgot_password/forgot_password_page.dart';
import 'package:flutter_base/ui/pages/auth/views/login/login_page.dart';
import 'package:flutter_base/ui/pages/auth/views/sign_up/sign_up_page.dart';
import 'package:flutter_base/ui/pages/home/pages/home_page.dart';
import 'package:flutter_base/ui/pages/misc/views/main_page.dart';
import 'package:flutter_base/ui/pages/post/pages/post_page.dart';
import 'package:flutter_base/ui/pages/profile/pages/edit_avatar_page.dart';
import 'package:flutter_base/ui/pages/profile/pages/edit_profile_page.dart';
import 'package:flutter_base/ui/pages/profile/pages/profile_page.dart';
import 'package:flutter_base/ui/router/guards/auth_guard.dart';
import 'package:go_router/go_router.dart';

Page platformPage(
  Widget child, {
  bool fullscreenDialog = false,
  bool maintainState = false,
}) =>
    Platform.isIOS
        ? CupertinoPage(
            child: child,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
          )
        : MaterialPage(
            child: child,
            fullscreenDialog: fullscreenDialog,
            maintainState: maintainState,
          );

CustomTransitionPage<void> fadeTransitionPage(
  GoRouterState state,
  Widget page,
) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: page,
    transitionDuration: const Duration(milliseconds: 150),
    transitionsBuilder: (
      BuildContext context,
      Animation<double> animation,
      Animation<double> secondaryAnimation,
      Widget child,
    ) =>
        FadeTransition(opacity: animation, child: child),
  );
}

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _appShellNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'appShell');

final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: '/home',
  routes: <RouteBase>[
    GoRoute(path: "/", builder: (context, state) => const MainPage()),
    // Auth routes
    GoRoute(path: "/login", builder: (context, state) => const LoginPage()),
    GoRoute(path: "/sign-up", builder: (context, state) => const SignUpPage()),
    GoRoute(
      path: "/forgot-password",
      pageBuilder: (context, state) =>
          platformPage(const ForgotPasswordPage(), fullscreenDialog: true),
    ),
    GoRoute(
      path: "/forgot-password/confirm",
      pageBuilder: (context, state) => platformPage(
        ForgotPasswordConfirmPage(
          data: state.extra as ForgotPasswordConfirmPageData,
        ),
        fullscreenDialog: true,
      ),
    ),
    GoRoute(
      path: "/change-password",
      pageBuilder: (context, GoRouterState state) => platformPage(
        ChangePasswordPage(data: state.extra as ChangePasswordPageData),
        fullscreenDialog: true,
      ),
    ),
    GoRoute(
      path: "/change-password/success",
      pageBuilder: (context, GoRouterState state) => platformPage(
        const ChangePasswordSuccessPage(),
        fullscreenDialog: true,
      ),
    ),

    /// Application
    ShellRoute(
      navigatorKey: _appShellNavigatorKey,
      builder: (BuildContext context, GoRouterState state, Widget child) {
        return HomePage(child: child);
      },
      routes: <RouteBase>[
        GoRoute(
          redirect: authGuard,
          path: "/profile",
          pageBuilder: (BuildContext context, GoRouterState state) =>
              fadeTransitionPage(state, const ProfilePage()),
          routes: <RouteBase>[
            GoRoute(
              path: 'edit',
              builder: (BuildContext context, GoRouterState state) =>
                  const EditProfilePage(),
            ),
            GoRoute(
              path: "avatar",
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => EditAvatarPage(
                avatar: (state.extra as EditAvatarPageData).avatar,
              ),
            ),
          ],
        ),
        GoRoute(
          redirect: authGuard,
          path: "/home",
          pageBuilder: (BuildContext context, GoRouterState state) =>
              fadeTransitionPage(state, const PostPage()),
        ),
      ],
    ),
  ],
);
