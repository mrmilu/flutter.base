import 'dart:convert';

import '../../domain/models/app_settings_model.dart';
import '../../domain/types/app_status_type.dart';

class AppSettingsDto {
  final String status;
  AppSettingsDto({
    required this.status,
  });
  AppSettingsDto._({
    required this.status,
  });

  factory AppSettingsDto.fromDomain(AppSettingsModel model) {
    return AppSettingsDto._(
      status: model.status.toString(),
    );
  }

  AppSettingsModel toDomain() {
    return AppSettingsModel(
      status: AppStatusType.fromString(status),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'status': status,
    };
  }

  factory AppSettingsDto.fromMap(Map<String, dynamic> map) {
    return AppSettingsDto(
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  factory AppSettingsDto.fromJson(String source) =>
      AppSettingsDto.fromMap(json.decode(source));
}
