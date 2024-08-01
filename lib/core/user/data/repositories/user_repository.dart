import 'package:cross_file/cross_file.dart';
import 'package:dio/dio.dart';
import 'package:flutter_base/auth/data/dtos/device_output_model.dart';
import 'package:flutter_base/core/app/data/services/api_service.dart';
import 'package:flutter_base/core/app/domain/models/environments_list.dart';
import 'package:flutter_base/core/user/data/models/update_user_output_model.dart';
import 'package:flutter_base/core/user/data/models/user_data_model.dart';
import 'package:flutter_base/core/user/domain/interfaces/user_repository.dart';
import 'package:flutter_base/core/user/domain/models/device_input_model.dart';
import 'package:flutter_base/core/user/domain/models/update_user_input_model.dart';
import 'package:flutter_base/core/user/domain/models/user.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: IUserRepository, env: onlineEnvironment)
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
  Future<User> avatar(XFile photo) async {
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
    final res = await _apiService.put('/user', data: input.toOutput().toJson());
    return UserDataModel.fromJson(res ?? {}).toDomain();
  }

  @override
  Future<void> device(DeviceInputModel input) async {
    await _apiService.post(
      '/devices/',
      data: input.toOutput().toJson(),
    );
  }
}
