import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/core/app/domain/interfaces/env_vars.dart';
import 'package:flutter_base/core/app/domain/models/env_vars.dart';
import 'package:flutter_base/core/app/ioc/locator.config.dart';
import 'package:flutter_base/ui/router/app_router.dart';
import 'package:flutter_mrmilu/flutter_mrmilu.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit()
void configureDependencies({required String env}) {
  getIt.init(environment: env);
}

@module
abstract class RegisterModule {
  @Singleton(as: IEnvVars)
  EnvVars get getEnvVars => EnvVars();

  @Singleton()
  ProviderContainer get getProviderContainer => ProviderContainer();

  @LazySingleton()
  GoRouter get getAppRouter => router;

  @LazySingleton(
    as: INotificationsService,
    dispose: disposeNotificationsService,
  )
  NotificationsService get getNotificationsService => NotificationsService();

  @Singleton()
  GlobalKey<ScaffoldMessengerState> get getScaffoldKey =>
      GlobalKey<ScaffoldMessengerState>();
}

FutureOr disposeNotificationsService(INotificationsService instance) {
  instance.dispose();
}
