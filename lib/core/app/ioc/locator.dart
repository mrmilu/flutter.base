import 'package:flutter/material.dart';
import 'package:flutter_base/core/app/domain/interfaces/env_vars.dart';
import 'package:flutter_base/core/app/domain/models/env_vars.dart';
import 'package:flutter_base/core/app/ioc/locator.config.dart';
import 'package:flutter_base/ui/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r"$initGetIt", // default
  preferRelativeImports: true, // default
  asExtension: false, // default
)
void configureDependencies() {
  $initGetIt(getIt);
}

@module
abstract class RegisterModule {
  @Singleton(as: IEnvVars)
  EnvVars get getEnvVars => EnvVars();

  @Singleton()
  ProviderContainer get getProviderContainer => ProviderContainer();

  @LazySingleton()
  GoRouter get getAppRouter => router;

  @Singleton()
  GlobalKey<ScaffoldMessengerState> get getScaffoldKey =>
      GlobalKey<ScaffoldMessengerState>();
}
