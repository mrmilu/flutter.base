// ignore_for_file: depend_on_referenced_packages

import 'package:flutter_base/src/auth/domain/interfaces/i_auth_repository.dart';
import 'package:flutter_base/src/auth/domain/interfaces/i_token_repository.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_deep_link_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_notifications_service.dart';
import 'package:flutter_base/src/shared/domain/interfaces/i_platform_service.dart';
import 'package:flutter_base/src/shared/domain/models/environments_list.dart';
import 'package:flutter_base/src/user/domain/interfaces/i_user_repository.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

import '../../../helpers/fake/fake_cache_manager.dart';
import 'locator_mock.config.dart';

final getIt = GetIt.instance;

@InjectableInit(preferRelativeImports: true, generateForDir: ['lib', 'test'])
void configureMockDependencies() => getIt.init(environment: Environments.test);

@module
abstract class MockTestModule {
  @LazySingleton(env: testEnvironment)
  INotificationsService get getMockNotificationService =>
      MockTestNotificationsService();

  @LazySingleton(env: testEnvironment)
  IUserRepository get getMockUserRepository => MockTestUserRepository();

  @LazySingleton(env: testEnvironment)
  IAuthRepository get getMockAuthRepository => MockTestAuthRepository();

  @LazySingleton(env: testEnvironment)
  ITokenRepository get getMockTokenRepository => MockTestTokenRepository();

  @LazySingleton(env: testEnvironment)
  IDeepLinkService get getMockDeepLinkService => MockTestDeepLinkService();

  @LazySingleton(env: testEnvironment)
  BaseCacheManager get cacheManager => FakeImageCacheManager();

  @LazySingleton(env: testEnvironment)
  IPlatformService get getPlatformService => MockTestPlatformService();

// Add more mocks if they are necessary in the tests
}

class MockTestNotificationsService extends Mock
    implements INotificationsService {}

class MockTestUserRepository extends Mock implements IUserRepository {}

class MockTestAuthRepository extends Mock implements IAuthRepository {}

class MockTestTokenRepository extends Mock implements ITokenRepository {}

class MockTestDeepLinkService extends Mock implements IDeepLinkService {}

class MockTestPlatformService extends Mock implements IPlatformService {}
