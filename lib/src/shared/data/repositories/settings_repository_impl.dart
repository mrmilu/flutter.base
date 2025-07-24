import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import '../../domain/failures/firebase_failure.dart';
import '../../domain/interfaces/i_settings_repository.dart';
import '../../domain/models/app_settings_model.dart';
import '../../domain/types/app_status_type.dart';
import '../../helpers/resource.dart';

class SettingsRepositoryImpl extends ISettingsRepository {
  final Dio httpClient;
  SettingsRepositoryImpl(this.httpClient);

  @override
  Future<Resource<FirebaseFailure, AppSettingsModel>> getAppSettings() async {
    try {
      final result = await httpClient.get('/settings');

      debugPrint('result: $result');

      final appSettings = AppSettingsModel(
        status: AppStatusType.open(),
      );

      // final appSettings = AppSettingsDto.fromMap(doc.data()!).toDomain();

      return Resource.success(appSettings);
    } catch (e) {
      final appSettings = AppSettingsModel(
        status: AppStatusType.open(),
      );
      return Resource.success(appSettings);
      // return Resource.failure(FirebaseFailure.serverError());
    }
  }
}
