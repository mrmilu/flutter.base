import 'dart:developer';
import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/validate_email/validate_email_cubit.dart';
import '../../domain/models/env_vars.dart';
import '../../presentation/router/app_router.dart';
import '../../presentation/router/page_names.dart';

// Types
const dynamicLinkTypeValidateEmail = 'email_verification';
const dynamicLinkTypeLinkEncoded = 'link_encoded';
const dynamicLinkTypeResetPassword = 'password_reset';
// Params
const dynamicLinkParamType = 'type';
const dynamicLinkParamToken = 'token';
const dynamicLinkParamEncoded = 'encoded';

AppFlyerService? appFlyerService;
String? typeGlobalDynamicLink;
String? keyGlobalDynamicLink;
String? encodeGlobalDynamicLink;

class AppFlyerService {
  AppFlyerService();

  static final AppsFlyerSdk appsFlyerSdk = AppsFlyerSdk.instance;

  bool _initialized = false;
  bool _started = false;

  Future<void> init() async {
    if (_initialized) {
      return;
    }

    try {
      final env = EnvVars();
      final afDevKey = env.afDevKey;
      final appIdIos = env.appIdIOS;
      final appIdAndroid = env.appIdAndroid;

      _initialized = true;

      if (kDebugMode) {
        await appsFlyerSdk.enableDebug(true);
      }

      await appsFlyerSdk.registerDeepLinkListener(
        onDeepLinking: _onDeepLinkingSimple,
      );

      await appsFlyerSdk.init(
        devKey: afDevKey,
        appId: Platform.isIOS ? appIdIos : appIdAndroid,
      );

      // Se registra después de init().
      await appsFlyerSdk.registerConversionListener(
        onConversionDataSuccess: _onInstallConversionData,
        onConversionDataFail: _onInstallConversionDataFailure,
      );

      await appsFlyerSdk.registerSessionReadyListener(() async {
        if (_started) {
          return;
        }

        _started = true;

        try {
          await appsFlyerSdk.start();

          log('AppsFlyer SDK started');
        } catch (error, stackTrace) {
          log(
            'Failed to start AppsFlyer SDK: $error',
            stackTrace: stackTrace,
          );
        }
      });

      log('AppsFlyer SDK initialized');

      // await appsFlyerSdk.start(awaitResponse: true);
    } catch (e) {
      _initialized = false;
      log('failed to initialize appsflyer sdk: $e');
    }
  }

  void logEvent(String eventName, Map<String, dynamic> eventValues) {
    appsFlyerSdk.logEvent(eventName, eventValues: eventValues);
  }

  void generateDeekLink(
    String referalCode,
    Function(dynamic) onSuccess,
    Function(dynamic) onError,
  ) {
    final params = AppsFlyerInviteLinkParams(
      baseDeepLink: 'https://fastlight-beta.onelink.me/MtS5/ysgttczl/',
      userParams: {
        "type": "get_member",
        "referal_code": referalCode,
        "af_web_dp":
            "https://clientes.niba.es/es/checkout/1?referal_code=$referalCode",
      },
    );
    appsFlyerSdk.generateInviteLink(parameters: params);
  }

  void _onDeepLinkingSimple(DeepLinkResult p0) {
    final deepLink = p0.deepLink?.clickEvent;
    final type = deepLink?[dynamicLinkParamType];
    final keyToken = deepLink?[dynamicLinkParamToken];
    final uId = deepLink?[dynamicLinkParamEncoded];

    debugPrint('DeepLink - type: $type, keyToken: $keyToken, uId: $uId');

    typeGlobalDynamicLink = type;
    keyGlobalDynamicLink = keyToken;
    encodeGlobalDynamicLink = uId;
  }

  void _onInstallConversionData(Map<dynamic, dynamic> installData) {
    debugPrint('Install conversion data: $installData');

    final type = installData[dynamicLinkParamType];
    final keyToken = installData[dynamicLinkParamToken];
    final uId = installData[dynamicLinkParamEncoded];

    if (type != null || keyToken != null || uId != null) {
      debugPrint('Install - type: $type, keyToken: $keyToken, uId: $uId');

      typeGlobalDynamicLink = type;
      keyGlobalDynamicLink = keyToken;
      encodeGlobalDynamicLink = uId;
    }
  }

  Future<void> _onInstallConversionDataFailure(
    Map<dynamic, dynamic> dataFail,
  ) async {
    debugPrint('AppsFlyer conversion data failed: $dataFail');
  }

  Future<void> onDeepLinkingWithRedirectInitialPage(
    BuildContext context,
    ValueNotifier<int> currentStep,
  ) async {
    if (!context.mounted) return;
    await appsFlyerSdk.registerDeepLinkListener(
      onDeepLinking: (result) async {
        final deepLink = result.deepLink?.clickEvent;
        String? type = deepLink?[dynamicLinkParamType];
        String? keyToken = deepLink?[dynamicLinkParamToken];
        String? uId = deepLink?[dynamicLinkParamEncoded];

        debugPrint('type: $type, keyToken: $keyToken, uId: $uId');

        typeGlobalDynamicLink = type;
        keyGlobalDynamicLink = keyToken;
        encodeGlobalDynamicLink = uId;

        _handleDynamicLink(type, keyToken, uId, currentStep, context);
      },
    );

    await appsFlyerSdk.registerConversionListener(
      onConversionDataSuccess: (installData) async {
        debugPrint('Install conversion data with redirect: $installData');

        final type = installData[dynamicLinkParamType];
        final keyToken = installData[dynamicLinkParamToken];
        final uId = installData[dynamicLinkParamEncoded];

        if (type != null || keyToken != null || uId != null) {
          debugPrint(
            'Install redirect - type: $type, keyToken: $keyToken, uId: $uId',
          );

          typeGlobalDynamicLink = type;
          keyGlobalDynamicLink = keyToken;
          encodeGlobalDynamicLink = uId;

          _handleDynamicLink(type, keyToken, uId, currentStep, context);
        }
      },
      onConversionDataFail: _onInstallConversionDataFailure,
    );
  }

  void _handleDynamicLink(
    String? typeDynamicLink,
    String? keyToken,
    String? uId,
    ValueNotifier<int> currentStep,
    BuildContext context,
  ) async {
    switch (typeDynamicLink) {
      case dynamicLinkTypeResetPassword:
        if (keyToken == null) return;
        routerApp.pushNamed(PageNames.resetPassword);
        break;
      case dynamicLinkTypeValidateEmail:
        if (keyToken == null || !context.mounted) return;
        context.read<ValidateEmailCubit>().validateEmail(keyToken);
        break;
    }
  }
}
