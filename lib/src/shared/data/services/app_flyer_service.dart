import 'dart:developer';
import 'dart:io';

import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../auth/presentation/pages/initial_page.dart';
import '../../../auth/presentation/validate_email/validate_email_cubit.dart';
import '../../domain/models/env_vars.dart';

// Types
const dynamicLinkTypeValidateEmail = 'email_verification';
const dynamicLinkTypeLinkEncoded = 'link_encoded';
const dynamicLinkTypeResetPassword = 'password_reset';
// Params
const dynamicLinkParamType = 'type';
const dynamicLinkParamToken = 'token';
const dynamicLinkParamEncoded = 'encoded';

AppsflyerSdk? appsflyerSdk;
AppFlyerService? appFlyerService;
String? typeGlobalDynamicLink;
String? keyGlobalDynamicLink;
String? encodeGlobalDynamicLink;

class AppFlyerService {
  AppFlyerService();

  Future<void> init() async {
    try {
      final env = EnvVars();
      final afDevKey = env.afDevKey;
      final appIdIos = env.appIdIOS;
      final appIdAndroid = env.appIdAndroid;

      AppsFlyerOptions appsFlyerOptions = AppsFlyerOptions(
        afDevKey: afDevKey,
        appId: Platform.isAndroid ? appIdAndroid : appIdIos,
        showDebug: true,
        timeToWaitForATTUserAuthorization: 60,
        appInviteOneLink: 'fastlight_link',
        disableAdvertisingIdentifier: false,
        disableCollectASA: false,
        manualStart: true,
      );

      appsflyerSdk = AppsflyerSdk(appsFlyerOptions);

      await appsflyerSdk?.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );

      onDeepLinkingWithoutRedirect();

      appsflyerSdk?.startSDK(
        onSuccess: () {
          log('AppsFlyer SDK initialized successfully.');
        },
        onError: (int errorCode, String errorMessage) {
          log(
            'Error initializing AppsFlyer SDK: Code $errorCode - $errorMessage',
          );
        },
      );
    } catch (e) {
      log('failed to initialize appsflyer sdk: $e');
    }
  }

  void onDeepLinkingWithoutRedirect() {
    appsflyerSdk?.onDeepLinking(_onDeepLinkingSimple);

    appsflyerSdk?.onInstallConversionData((installData) {
      _onInstallConversionData(installData);
    });

    appsflyerSdk?.onAppOpenAttribution((attributionData) {
      _onAppOpenAttribution(attributionData);
    });
  }

  void logEvent(String eventName, Map<String, dynamic> eventValues) {
    appsflyerSdk?.logEvent(eventName, eventValues);
  }

  void generateDeekLink(
    Map<String, String> parameters,
    Function() onSuccess,
    Function(String) onError,
  ) {
    appsflyerSdk?.generateInviteLink(
      AppsFlyerInviteLinkParams(customParams: parameters),
      onSuccess,
      onError,
    );
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

  void _onAppOpenAttribution(Map<dynamic, dynamic> attributionData) {
    debugPrint('App open attribution data: $attributionData');

    final type = attributionData[dynamicLinkParamType];
    final keyToken = attributionData[dynamicLinkParamToken];
    final uId = attributionData[dynamicLinkParamEncoded];

    if (type != null || keyToken != null || uId != null) {
      debugPrint('App Open - type: $type, keyToken: $keyToken, uId: $uId');

      typeGlobalDynamicLink = type;
      keyGlobalDynamicLink = keyToken;
      encodeGlobalDynamicLink = uId;
    }
  }

  void onDeepLinkingWithRedirectInitialPage(
    BuildContext context,
    ValueNotifier<int> currentStep,
  ) {
    appsflyerSdk?.onDeepLinking(
      (p0) => _onDeepLinkingInitial(p0, currentStep, context),
    );

    appsflyerSdk?.onInstallConversionData((installData) {
      _onInstallConversionDataWithRedirect(installData, currentStep, context);
    });

    appsflyerSdk?.onAppOpenAttribution((attributionData) {
      _onAppOpenAttributionWithRedirect(attributionData, currentStep, context);
    });
  }

  void _onInstallConversionDataWithRedirect(
    Map installData,
    ValueNotifier<int> currentStep,
    BuildContext context,
  ) {
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

      handleDynamicLink(type, keyToken, uId, currentStep, context);
    }
  }

  void _onAppOpenAttributionWithRedirect(
    Map attributionData,
    ValueNotifier<int> currentStep,
    BuildContext context,
  ) {
    debugPrint('App open attribution with redirect: $attributionData');

    final type = attributionData[dynamicLinkParamType];
    final keyToken = attributionData[dynamicLinkParamToken];
    final uId = attributionData[dynamicLinkParamEncoded];

    if (type != null || keyToken != null || uId != null) {
      debugPrint(
        'App Open redirect - type: $type, keyToken: $keyToken, uId: $uId',
      );

      typeGlobalDynamicLink = type;
      keyGlobalDynamicLink = keyToken;
      encodeGlobalDynamicLink = uId;

      // Manejar el dynamic link para app ya instalada que se abre
      handleDynamicLink(type, keyToken, uId, currentStep, context);
    }
  }

  void _onDeepLinkingInitial(
    DeepLinkResult p0,
    ValueNotifier<int> currentStep,
    BuildContext context,
  ) {
    final deepLink = p0.deepLink?.clickEvent;
    String? type = deepLink?[dynamicLinkParamType];
    String? keyToken = deepLink?[dynamicLinkParamToken];
    String? uId = deepLink?[dynamicLinkParamEncoded];

    debugPrint('type: $type, keyToken: $keyToken, uId: $uId');

    typeGlobalDynamicLink = type;
    keyGlobalDynamicLink = keyToken;
    encodeGlobalDynamicLink = uId;

    handleDynamicLink(type, keyToken, uId, currentStep, context);
  }
}

void handleDynamicLink(
  String? typeDynamicLink,
  String? keyToken,
  String? uId,
  ValueNotifier<int> currentStep,
  BuildContext context,
) async {
  switch (typeDynamicLink) {
    case dynamicLinkTypeResetPassword:
      if (keyToken == null) return;
      currentStep.value = InitialStep.updatePassword.index;
      break;
    case dynamicLinkTypeValidateEmail:
      if (keyToken == null || !context.mounted) return;
      context.read<ValidateEmailCubit>().validateEmail(keyToken);
      break;
  }
}
