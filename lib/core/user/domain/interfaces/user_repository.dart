import 'dart:io';

import 'package:flutter_base/core/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';

abstract class IUserRepository {
  Future<User> getLoggedUser();

  Future<User> avatar(File photo);

  Future<User> deleteAvatar();

  Future<User> update(UpdateUserInputModel input);
}
