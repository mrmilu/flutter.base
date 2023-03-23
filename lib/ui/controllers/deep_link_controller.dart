import 'package:flutter/foundation.dart';
import 'package:flutter_base/common/interfaces/deep_link_service.dart';
import 'package:flutter_base/ui/features/auth/views/forgot_password/forgot_password_confirm_page.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class DeepLinkController {
  final GoRouter _appRouter;
  final IDeepLinkService _deepLinkService;

  DeepLinkController(this._appRouter, this._deepLinkService);

  void call() {
    _initDeepLinks();
  }

  Future<void> _initDeepLinks() async {
    _deepLinkService.onLink().listen((link) {
      _processDeepLinks(link);
    }).onError((e, stack) {
      debugPrintStack(label: e.toString(), stackTrace: stack);
    });

    final Uri? link = await _deepLinkService.getInitialLink();
    if (link != null) {
      _processDeepLinks(link);
    }
  }

  void _processDeepLinks(Uri deepLink) {
    if (deepLink.queryParameters.containsKey('type') &&
        deepLink.queryParameters['type'] == 'reset-password' &&
        deepLink.queryParameters.containsKey('key') &&
        deepLink.queryParameters.containsKey('uid') &&
        deepLink.queryParameters['uid']?.isNotEmpty == true) {
      _appRouter.pushReplacement(
        '/forgot-password/confirm',
        extra: ForgotPasswordConfirmPageData(
          token: deepLink.queryParameters['key'],
          uid: deepLink.queryParameters['uid'],
        ),
      );
    }
    if (deepLink.queryParameters.containsKey('type') &&
        deepLink.queryParameters['type'] == 'verify-account' &&
        deepLink.queryParameters.containsKey('key')) {
      _appRouter.pushReplacement(
        '/verify-account',
        extra: deepLink.queryParameters['key'],
      );
    }
  }
}
