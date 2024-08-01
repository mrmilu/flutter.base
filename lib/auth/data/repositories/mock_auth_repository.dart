import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/auth/domain/interfaces/auth_repository.dart';
import 'package:flutter_base/auth/domain/models/change_password_input_model.dart';
import 'package:flutter_base/auth/domain/models/login_input_model.dart';
import 'package:flutter_base/auth/domain/models/sign_up_input_model.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IAuthRepository, env: localEnvironment)
class MockAuthRepository implements IAuthRepository {
  final _faker = Faker.instance;

  @override
  Future<String> login(LoginInputModel input) async {
    return _faker.datatype.uuid();
  }

  @override
  Future logout() async {
    Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<String> signUp(SignUpInputModel input) async {
    return _faker.datatype.uuid();
  }

  @override
  Future<String> appleSocialAuth() async {
    return _faker.datatype.uuid();
  }

  @override
  Future<String> googleSocialAuth() async {
    return _faker.datatype.uuid();
  }

  @override
  Future<void> requestResetPassword(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> changePassword(ChangePasswordInputModel input) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> resendPasswordResetEmail(String email) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<void> verifyAccount(String token) async {
    await Future.delayed(const Duration(milliseconds: 300));
  }

  @override
  Future<String> socialAuth(String token) async {
    return _faker.datatype.uuid();
  }
}
