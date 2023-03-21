import 'package:cross_file/cross_file.dart';
import 'package:faker_dart/faker_dart.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/device_input_model.dart';
import 'package:flutter_base/core/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:flutter_mrmilu/flutter_mrmilu.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserRepository, env: localEnvironment)
class MockUserRepository implements IUserRepository {
  final _faker = Faker.instance;

  @override
  Future<User> getLoggedUser() async {
    return User(
      email: _faker.email(),
      name: _faker.name.firstName(),
      verified: true,
      id: _faker.datatype.number(),
    );
  }

  @override
  Future<User> avatar(XFile photo) async {
    return User(
      email: _faker.email(),
      name: _faker.name.firstName(),
      verified: true,
      id: _faker.datatype.number(),
    );
  }

  @override
  Future<User> deleteAvatar() async {
    return User(
      email: _faker.email(),
      name: _faker.name.firstName(),
      verified: true,
      id: _faker.datatype.number(),
    );
  }

  @override
  Future<User> update(UpdateUserInputModel input) async {
    return User(
      email: _faker.email(),
      name: input.name ?? _faker.name.firstName(),
      verified: true,
      id: _faker.datatype.number(),
    );
  }

  @override
  Future<void> device(DeviceInputModel input) async {
    await Future.delayed(const Duration(milliseconds: 500));
  }
}
