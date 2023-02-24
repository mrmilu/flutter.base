import 'package:flutter_base/common/interfaces/notifications_service.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:flutter_base/core/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/core/auth/domain/interfaces/token_repository.dart';
import 'package:flutter_base/core/auth/domain/use_cases/social_auth_use_case.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:mocktail/mocktail.dart';

@LazySingleton(as: INotificationsService, env: testEnvironment)
class MockTestNotificationsService extends Mock implements INotificationsService {}

@LazySingleton(as: IUserRepository, env: testEnvironment)
class MockTestUserRepository extends Mock implements IUserRepository {}

@LazySingleton(as: IAuthRepository, env: testEnvironment)
class MockTestAuthRepository extends Mock implements IAuthRepository {}

@LazySingleton(as: ITokenRepository, env: testEnvironment)
class MockTestTokenRepository extends Mock implements ITokenRepository {}

// TODO add more mocks if they are necessary in the tests