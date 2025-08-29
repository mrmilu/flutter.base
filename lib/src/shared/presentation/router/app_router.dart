import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sentry_flutter/sentry_flutter.dart';

import '../../../auth/presentation/initial/initial_page.dart';
import '../../../auth/presentation/pages/forgot_password_page.dart';
import '../../../auth/presentation/signin/sign_in_page.dart';
import '../../../auth/presentation/signup/sign_up_page.dart';
import '../../../auth/presentation/signup/sign_up_two_page.dart';
import '../../../auth/presentation/validate_email/validate_email_page.dart';
import '../../../home/presentation/pages/main_home_page.dart';
import '../../../onboarding/presentation/onboarding_page.dart';
import '../../../settings/presentation/profile_info/access_data/access_data_page.dart';
import '../../../settings/presentation/profile_info/access_data/change_password/change_password_page.dart';
import '../../../settings/presentation/profile_info/config/settings_config_page.dart';
import '../../../settings/presentation/profile_info/info_extra/info_extra_page.dart';
import '../../../settings/presentation/profile_info/personal_data/personal_data_page.dart';
import '../../../settings/presentation/profile_info/profile_info_page.dart';
import '../../../settings/presentation/settings_languages/settings_languages_page.dart';
import '../../../splash/presentation/pages/splash_page.dart';
import '../../../tap2/tap2_page.dart';
import '../helpers/analytics_helper.dart';
import '../pages/scaffold_with_navigation.dart';
import '../pages/web_view_page.dart';
import 'guards/auth_guard.dart';
import 'page_names.dart';
import 'router_observer.dart';
import 'utils.dart';

final GlobalKey<NavigatorState> rootNavigatorKey = GlobalKey<NavigatorState>(
  debugLabel: 'root',
);

final GoRouter routerApp = GoRouter(
  navigatorKey: rootNavigatorKey,
  initialLocation: '/',
  observers: [
    AppRouterObserver(),
    SentryNavigatorObserver(),
    FirebaseAnalyticsObserver(analytics: MyAnalyticsHelper.instance),
  ],
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: PageNames.splash,
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboarding',
      name: PageNames.onboarding,
      builder: (context, state) => const OnboardingPage(),
    ),
    // Auth routes
    GoRoute(
      path: '/initial',
      name: PageNames.initial,
      pageBuilder: (BuildContext context, GoRouterState state) =>
          fadeTransitionPage(
            state,
            const InitialPage(),
          ),
      routes: [
        GoRoute(
          path: '/sign-up2',
          name: PageNames.signUp2,
          pageBuilder: (context, state) {
            return CustomTransitionPage(
              opaque: false,
              barrierDismissible: true,
              child: const SignUpTwoPage(),
              transitionsBuilder:
                  (context, animation, secondaryAnimation, child) {
                    const begin = Offset(0.0, 1.0);
                    const end = Offset.zero;
                    const curve = Curves.easeInOut;
                    var tween = Tween(
                      begin: begin,
                      end: end,
                    ).chain(CurveTween(curve: curve));
                    var offsetAnimation = animation.drive(tween);
                    return SlideTransition(
                      position: offsetAnimation,
                      child: child,
                    );
                  },
            );
          },
        ),
      ],
    ),
    GoRoute(
      path: '/sign-up',
      name: PageNames.signUp,
      builder: (context, state) => const SignUpPage(),
    ),
    GoRoute(
      path: '/validate-email',
      name: PageNames.validateEmail,
      builder: (context, state) => const ValidateEmailPage(),
    ),
    GoRoute(
      path: '/sign-in',
      name: PageNames.signIn,
      builder: (context, state) => const SignInPage(),
    ),
    GoRoute(
      path: '/forgot-password',
      name: PageNames.forgotPassword,
      pageBuilder: (context, state) => platformPage(
        const ForgotPasswordPage(),
        fullscreenDialog: true,
        state: state,
      ),
    ),
    // GoRoute(
    //   path: '/forgot-password/confirm',
    //   name: PageNames.forgotPasswordConfirm,
    //   pageBuilder: (context, state) => platformPage(
    //     ForgotPasswordConfirmPage(
    //       data: state.extra as ForgotPasswordConfirmPageData,
    //     ),
    //     state: state,
    //     fullscreenDialog: true,
    //   ),
    // ),
    // GoRoute(
    //   path: '/change-password',
    //   name: PageNames.changePassword,
    //   pageBuilder: (context, GoRouterState state) => platformPage(
    //     const ChangePasswordPage(),
    //     fullscreenDialog: true,
    //     state: state,
    //   ),
    // ),
    // GoRoute(
    //   path: '/change-password/success',
    //   name: PageNames.changePasswordSuccess,
    //   pageBuilder: (context, GoRouterState state) => platformPage(
    //     const ChangePasswordSuccessPage(),
    //     fullscreenDialog: true,
    //     state: state,
    //   ),
    // ),

    // Onboarding

    /// Application
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) => fadeTransitionPage(
        state,
        ScaffoldWithNavigation(
          navigationShell: navigationShell,
        ),
      ),
      branches: <StatefulShellBranch>[
        StatefulShellBranch(
          observers: [
            AppRouterObserver(),
            SentryNavigatorObserver(),
            FirebaseAnalyticsObserver(analytics: MyAnalyticsHelper.instance),
          ],
          routes: [
            GoRoute(
              redirect: authGuard,
              path: '/home',
              name: PageNames.mainHome,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  fadeTransitionPage(state, const MainHomePage()),
            ),
          ],
        ),
        StatefulShellBranch(
          observers: [
            AppRouterObserver(),
            SentryNavigatorObserver(),
            FirebaseAnalyticsObserver(analytics: MyAnalyticsHelper.instance),
          ],
          routes: [
            GoRoute(
              redirect: authGuard,
              path: '/tap2',
              name: PageNames.mainTap2,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  fadeTransitionPage(state, const MainTap2Page()),
            ),
          ],
        ),
        StatefulShellBranch(
          observers: [
            AppRouterObserver(),
            SentryNavigatorObserver(),
            FirebaseAnalyticsObserver(analytics: MyAnalyticsHelper.instance),
          ],
          routes: [
            GoRoute(
              redirect: authGuard,
              path: '/tap3',
              name: PageNames.mainTap3,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  fadeTransitionPage(state, const MainTap2Page()),
            ),
          ],
        ),
        StatefulShellBranch(
          observers: [
            AppRouterObserver(),
            SentryNavigatorObserver(),
            FirebaseAnalyticsObserver(analytics: MyAnalyticsHelper.instance),
          ],
          routes: [
            GoRoute(
              redirect: authGuard,
              path: '/tap4',
              name: PageNames.mainTap4,
              pageBuilder: (BuildContext context, GoRouterState state) =>
                  fadeTransitionPage(state, const MainTap2Page()),
            ),
          ],
        ),
      ],
    ),

    // Application root pages
    GoRoute(
      path: '/web_view',
      name: PageNames.webView,
      builder: (context, state) => WebViewPage(
        title: (state.extra as Map<String, dynamic>)['title'] ?? '',
        url: (state.extra as Map<String, dynamic>)['url'] ?? '',
      ),
    ),
    GoRoute(
      path: '/settings_profile_info',
      name: PageNames.settingsProfileInfo,
      builder: (context, state) => const ProfileInfoPage(),
      routes: [
        GoRoute(
          path: 'personal_data',
          name: PageNames.profileInfoPersonalData,
          builder: (_, state) => const ProfileInfoPersonalDataPage(),
        ),
        GoRoute(
          path: 'access_data',
          name: PageNames.profileInfoAccessData,
          builder: (context, state) => const ProfileInfoAccessDataPage(),
          routes: [
            GoRoute(
              path: 'change_password',
              name: PageNames.profileInfoAccessDataChangePassword,
              builder: (context, state) => const ChangePasswordPage(),
            ),
          ],
        ),
        GoRoute(
          path: 'settings_config',
          name: PageNames.profileInfoSettingsConfig,
          builder: (_, state) => const SettingsConfigPage(),
          routes: [
            GoRoute(
              path: 'settings_language',
              name: PageNames.settingsChangeLanguage,
              builder: (context, state) => const SettingsLanguagesPage(),
            ),
          ],
        ),
        GoRoute(
          path: 'infoExtra',
          name: PageNames.profileInfoInfoExtra,
          builder: (_, state) => const InfoExtraPage(),
        ),
      ],
    ),
  ],
);
