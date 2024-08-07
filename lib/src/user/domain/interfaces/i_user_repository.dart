import 'package:cross_file/cross_file.dart';
import 'package:flutter_base/src/user/domain/models/device_input_model.dart';
import 'package:flutter_base/src/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/src/user/domain/models/user.dart';

abstract class IUserRepository {
  Future<User> getLoggedUser();

  Future<User> avatar(XFile photo);

  Future<User> deleteAvatar();

  Future<User> update(UpdateUserInputModel input);

  Future<void> device(DeviceInputModel input);
}
