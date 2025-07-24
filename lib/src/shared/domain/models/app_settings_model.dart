import '../types/app_status_type.dart';

class AppSettingsModel {
  final AppStatusType status;
  AppSettingsModel({
    required this.status,
  });

  AppSettingsModel copyWith({
    AppStatusType? status,
  }) {
    return AppSettingsModel(
      status: status ?? this.status,
    );
  }

  @override
  String toString() => 'AppSettingsModel(status: $status)';

  @override
  bool operator ==(covariant AppSettingsModel other) {
    if (identical(this, other)) return true;

    return other.status == status;
  }

  @override
  int get hashCode => status.hashCode;
}
