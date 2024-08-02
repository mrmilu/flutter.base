import 'package:flutter/material.dart';
import 'package:flutter_base/src/shared/data/repositories/asset_picker_service.dart';
import 'package:flutter_base/src/shared/data/repositories/deep_link_service.dart';
import 'package:flutter_base/src/shared/data/repositories/edit_image_service.dart';
import 'package:flutter_base/src/shared/data/repositories/fs_repository.dart';
import 'package:flutter_base/src/shared/data/repositories/image_compress_service.dart';
import 'package:flutter_base/src/shared/data/repositories/platform_service.dart';
import 'package:flutter_base/src/shared/data/repositories/secure_storage_service.dart';
import 'package:flutter_base/src/shared/data/repositories/share_service.dart';
import 'package:flutter_base/src/shared/data/repositories/social_auth_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_asset_picker_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_deep_link_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_edit_image_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_env_vars.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_fs_repository.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_image_compress_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_platform_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_share_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_social_auth_service.dart';
import 'package:flutter_base/src/shared/domain/models/env_vars.dart';
import 'package:flutter_base/src/shared/domain/models/environments_list.dart';
import 'package:flutter_base/src/shared/ioc/locator.config.dart';
import 'package:flutter_base/src/shared/presentation/router/app_router.dart';
// ignore: depend_on_referenced_packages
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
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

  @Injectable(as: IAssetPickerService)
  AssetPickerService get getAssetPickerService => AssetPickerService();

  @Injectable(as: ISocialAuthService)
  SocialAuthService get getSocialAuthService => SocialAuthService();

  @Injectable(as: IImageCompressService)
  ImageCompressService get getImageCompressService => ImageCompressService();

  @Singleton(as: IDeepLinkService, env: noTestEnvironment)
  DeepLinkService get getDeepLinkService => DeepLinkService();

  @Injectable(as: IEditImageService)
  EditImageService get getEditImageService =>
      EditImageService(getIt.get<IFsRepository>());

  @Injectable(as: IShareService)
  ShareService get getShareService => ShareService();

  @LazySingleton()
  SecureStorageService get getSecureStorage => SecureStorageService();

  @Injectable(as: IFsRepository)
  FsRepository get getFsRepository => FsRepository();

  @Injectable(as: IPlatformService, env: noTestEnvironment)
  PlatformService get getPlatformService => PlatformService();

  @Singleton()
  GlobalKey<ScaffoldMessengerState> get getScaffoldKey =>
      GlobalKey<ScaffoldMessengerState>();

  @LazySingleton(env: noTestEnvironment)
  BaseCacheManager get cacheManager => DefaultCacheManager();
}
