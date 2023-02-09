import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_base/common/interfaces/asset_picker_service.dart';
import 'package:flutter_base/common/interfaces/deep_link_service.dart';
import 'package:flutter_base/common/interfaces/edit_image_service.dart';
import 'package:flutter_base/common/interfaces/fs_repository.dart';
import 'package:flutter_base/common/interfaces/image_compress_service.dart';
import 'package:flutter_base/common/interfaces/notifications_service.dart';
import 'package:flutter_base/common/interfaces/share_service.dart';
import 'package:flutter_base/common/interfaces/social_auth_service.dart';
import 'package:flutter_base/common/services/asset_picker_service.dart';
import 'package:flutter_base/common/services/deep_link_service.dart';
import 'package:flutter_base/common/services/edit_image_service.dart';
import 'package:flutter_base/common/services/image_compress_service.dart';
import 'package:flutter_base/common/services/notifications_service.dart';
import 'package:flutter_base/common/services/secure_storage_service.dart';
import 'package:flutter_base/common/services/share_service.dart';
import 'package:flutter_base/common/services/social_auth_service.dart';
import 'package:flutter_base/core/app/domain/interfaces/env_vars.dart';
import 'package:flutter_base/core/app/domain/models/env_vars.dart';
import 'package:flutter_base/core/app/ioc/locator.config.dart';
import 'package:flutter_base/ui/router/app_router.dart';
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

  @Injectable(as: IAssetPickerService)
  AssetPickerService get getAssetPickerService => AssetPickerService();

  @Injectable(as: ISocialAuthService)
  SocialAuthService get getSocialAuthService => SocialAuthService();

  @Injectable(as: IImageCompressService)
  ImageCompressService get getImageCompressService => ImageCompressService();

  @Singleton(as: IDeepLinkService)
  DeepLinkService get getDeepLinkService => DeepLinkService();

  @Injectable(as: IEditImageService)
  EditImageService get getEditImageService =>
      EditImageService(getIt.get<IFsRepository>());

  @Injectable(as: IShareService)
  ShareService get getShareService => ShareService();

  @LazySingleton()
  SecureStorageService get getSecureStorage => SecureStorageService();

  @Singleton()
  GlobalKey<ScaffoldMessengerState> get getScaffoldKey =>
      GlobalKey<ScaffoldMessengerState>();
}

FutureOr disposeNotificationsService(INotificationsService instance) {
  instance.dispose();
}
