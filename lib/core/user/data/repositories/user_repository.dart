import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_base/core/app/data/services/api_service.dart';
import 'package:flutter_base/core/user/data/models/user_data_model.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserRepository)
class UserRepository implements IUserRepository {
  final ApiService _apiService;

  UserRepository(this._apiService);

  @override
  Future<User> getLoggedUser() async {
    final response =
        await _apiService.get<Map<String, dynamic>>('/users/user/');
    return UserDataModel.fromJson(response ?? {}).toDomain();
  }

  @override
  Future<User> avatar(File photo) async {
    final res = await _apiService.post(
      '/user/avatar',
      data: FormData.fromMap({
        'file': await MultipartFile.fromFile(photo.path),
      }),
    );
    return UserDataModel.fromJson(res ?? {}).toDomain();
  }

  @override
  Future<User> deleteAvatar() async {
    final res = await _apiService.delete('/user/avatar');
    return UserDataModel.fromJson(res).toDomain();
  }

  @override
  Future<User> update(UpdateUserInputModel input) async {
    final res = await _apiService.put('/user', data: input.toJson());
    return UserDataModel.fromJson(res ?? {}).toDomain();
  }
}
